import { getFirestore, Timestamp } from "firebase-admin/firestore";
import { defaultFunctions } from "../function";

// 期間ごとのヘルスケア情報
type HealthByPeriod = {
  burnedCalorie: number;
  distance: number;
  steps: number;
}

// ユーザに紐ずくヘルスケア情報
type Health = {
  today: HealthByPeriod;
  yesterday: HealthByPeriod;
  week: HealthByPeriod;
  month: HealthByPeriod;
  totalSteps: number;
  totalDistance: number;
  updatedAt: Timestamp;
}

// ユーザ情報
// 利用するデータだけ保持している
type User = {
  nickname: string;
  userIconUrl: string;
  health?: Health;
}

// 1日ごとに計測しているヘルスケア情報
type HealthEachDay = {
  burnedCalorie: number;
  distance: number;
  steps: number;
  date: Timestamp;
  userId: string;
}

const toStartTime = (targetDate: Date): Date => {
    targetDate.setHours(0);
    targetDate.setMinutes(0);
    targetDate.setSeconds(0);
    return targetDate;
}

const isOverTargetDate = (userUpdatedAt: Timestamp, targetDate: Date): boolean => {
  const targetDateStartTime = toStartTime(targetDate);
      return userUpdatedAt.seconds > Math.floor(targetDateStartTime.getTime() / 1000);
}

// 期間ごとのヘルスケア情報を集計する
const aggregateHealthByPeriod = (healths: HealthEachDay[], startWith: Date): HealthByPeriod => {
    const filtered = healths.filter((health) => {
      return isOverTargetDate(health.date, startWith);
    });
    const steps = filtered.reduce((sum, elem) => {
      return sum + elem.steps;
    }, 0);
    const distance = filtered.reduce((sum, elem) => {
      return sum + elem.distance;
    }, 0);
    const burnedCalorie = filtered.reduce((sum, elem) => {
      return sum + elem.burnedCalorie;
    }, 0);
    return {steps, distance, burnedCalorie};
}

const updateHealthHandler = async () => {
  const db = getFirestore();
  // firestoreからユーザ一覧を取得
  const userSnapshot = await db.collection("users").get();
  const today = new Date();
  const oneMonthAgo = new Date();
  oneMonthAgo.setMonth(oneMonthAgo.getMonth() - 1);

  // usersテーブルの全ての情報をさらって、healthテーブルから期間ごとの情報を全て取得する
  await Promise.all(userSnapshot.docs.map(async (userDoc) => {
    const userId = userDoc.id;
    const user = userDoc.data() as User;
    // if (user.health == undefined || userId != "EQzrejcSTPXOUEGf6qlDmYqdYUr2") {
    //   return;
    // }
    if (user.health == undefined) {
      return;
    }

    // healthテーブルの id は {user_id}_{date} 形式となっているため、where で user_id の prefix と date を使って絞り込める
    const healthSnapshot = await db.collection("health")
      // LIKE っぽい検索
      .orderBy("userId")
      .startAt(userId)
      .endAt(userId + "\uf8ff")
      .get();

    // 本日分をのぞいて1ヶ月分のデータを取得
    // Firebase では where と orderby で指定するデータが同じでないといけないため、
    // このような絞り込みしかできない
    const healths = healthSnapshot.docs
      .filter(doc => {
        const data = doc.data() as HealthEachDay;
        const date = data.date.toDate(); // assuming date is stored as a Firestore Timestamp
        return date >= oneMonthAgo && date < today;
      })
      .map((doc) => doc.data() as HealthEachDay);
    if (healths.length == 0) {
      console.debug(`no health data [userId][${userId}]`);
      return;
    }
    // 昨日
    const targetDateYesterday = new Date();
    targetDateYesterday.setDate(targetDateYesterday.getDate() - 1);
    const yesterday = aggregateHealthByPeriod(healths, targetDateYesterday);
    // 1週間
    const targetDateWeek = new Date();
    targetDateWeek.setDate(targetDateWeek.getDate() - 7);
    const week = aggregateHealthByPeriod(healths, targetDateWeek);
    // 1ヶ月
    const month = aggregateHealthByPeriod(healths, oneMonthAgo);

    console.log(`old health [${JSON.stringify(user.health)}]`);
    // ユーザ情報を上書きしてDBに保存
    const updatedUser: User = {
      ...user,
      health: {
        ...user.health,
        yesterday: yesterday,
        week: week,
        month: month,
      }
    }
    console.log(`update health [userId][${userId}][old][${JSON.stringify(user.health)}][new][${JSON.stringify(updatedUser.health)}][healths][${JSON.stringify(healths)}]`);
    // const result = await db.collection("users").doc(userId).set(user);
    // console.log(`success to update user health [userId][${userId}][time][${result.writeTime.seconds}]`);
    console.log(`success to update user health [userId][${userId}]`);
  }));
}

export const updateUserHealth = defaultFunctions()
  .runWith({ memory: "512MB", timeoutSeconds: 9 * 60 })
  .pubsub.schedule("1 * * * *")
  .timeZone("Asia/Tokyo")
  .onRun(updateHealthHandler)
  ;
