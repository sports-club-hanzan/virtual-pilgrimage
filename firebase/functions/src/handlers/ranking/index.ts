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

// ランキングテーブルに保持したいユーザ情報
type UserInfoForRanking = {
  nickname: string;
  userIconUrl: string;
}

// ユーザの歩数または距離情報とランキングテーブルに保持したい情報を保持する型
type IntermediateUserInfo = {
  id: string;
  value: number;
  userInfo: UserInfoForRanking;
}

// ランキングに保持するユーザ情報
type RankingUserInfo = {
  userId: string;
  rank: number;
  nickname: string;
  userIconUrl: string;
  value: number;
}

// テーブルに書きこむランキング情報
type Ranking = {
  users: Array<RankingUserInfo>
}

/**
 * 降順にデータをソート
 */
const compareWithNumber = (a: IntermediateUserInfo, b: IntermediateUserInfo) => {
  if (a.value < b.value) {
    return 1;
  }
  return -1;
}

// データを変換するための関数の作成
const convertRanking = (sortedSteps: Array<IntermediateUserInfo>): Ranking => {
  return {
    users: sortedSteps.map((value, index) => {
      return {
        rank: index + 1,
        value: value.value,
        userId: value.id,
        nickname: value.userInfo.nickname,
        userIconUrl: value.userInfo.userIconUrl,
      };
    })
  };
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

const updateRankingHandler = async () => {
  const db = getFirestore();
  const querySnapshot = await db.collection("users").get();

  const dailySteps: Array<IntermediateUserInfo> = []
  const dailyDistances: Array<IntermediateUserInfo> = []
  const weeklySteps: Array<IntermediateUserInfo> = []
  const weeklyDistances: Array<IntermediateUserInfo> = []
  const monthlySteps: Array<IntermediateUserInfo> = []
  const monthlyDistances: Array<IntermediateUserInfo> = []

  // 日付(yyyymmdd形式で取得)
  const datetime = new Date();
  const unixtime = datetime.getTime()

  // usersテーブルの全ての情報をさらって、期間ごとの情報を保持する
  querySnapshot.docs.forEach(doc => {
    const user = doc.data() as User;
    if (user.health == null) {
      return;
    }
    const userInfoForRanking: { userInfo: UserInfoForRanking } = {
      userInfo: {
        nickname: user.nickname,
        userIconUrl: user.userIconUrl,
      }
    };
    const today = new Date();
    {
      const targetDate = new Date();
      targetDate.setDate(today.getDate() - 1);
      // 当日、すでに歩数・距離が更新されているユーザは前日のデータを参照する(前日のデータに昨日の歩数が格納されている)
      if (isOverTargetDate(user.health.updatedAt, today)) {
        dailySteps.push({ id: doc.id, value: user.health.yesterday.steps, ...userInfoForRanking });
        dailyDistances.push({ id: doc.id, value: user.health.yesterday.distance, ...userInfoForRanking });
      }
      // 昨日更新されているユーザは当日に計測した歩数と距離を詰める(当日のデータに昨日の歩数が格納されている)
      else if (isOverTargetDate(user.health.updatedAt, targetDate)) {
        dailySteps.push({ id: doc.id, value: user.health.today.steps, ...userInfoForRanking });
        dailyDistances.push({ id: doc.id, value: user.health.today.distance, ...userInfoForRanking });
      }
      // 一昨日以前に更新されたユーザは0歩、0km扱い
      else {
        dailySteps.push({ id: doc.id, value: 0, ...userInfoForRanking });
        dailyDistances.push({ id: doc.id, value: 0, ...userInfoForRanking });
      }
    }
    {
      const targetDate = new Date();
      targetDate.setDate(targetDate.getDate() - 7);
      // 先週に1度でも更新されているユーザだけ計測した歩数と距離を詰める
      if (isOverTargetDate(user.health.updatedAt, targetDate)) {
        weeklySteps.push({ id: doc.id, value: user.health.week.steps, ...userInfoForRanking });
        weeklyDistances.push({ id: doc.id, value: user.health.week.distance, ...userInfoForRanking });
      } else {
        weeklySteps.push({ id: doc.id, value: 0, ...userInfoForRanking });
        weeklyDistances.push({ id: doc.id, value: 0, ...userInfoForRanking });
      }
    }
    {
      const targetDate = new Date();
      targetDate.setDate(targetDate.getDate() - 31);
      // 1ヶ月以内に1度でも更新されているユーザだけ計測した歩数と距離を詰める
      if (isOverTargetDate(user.health.updatedAt, targetDate)) {
        monthlySteps.push({ id: doc.id, value: user.health.month.steps, ...userInfoForRanking });
        monthlyDistances.push({ id: doc.id, value: user.health.month.distance, ...userInfoForRanking });
      } else {
        monthlySteps.push({ id: doc.id, value: 0, ...userInfoForRanking });
        monthlyDistances.push({ id: doc.id, value: 0, ...userInfoForRanking });
      }
    }
  });

  /**
   * 歩数と距離のランキングを書き込む
   * @param steps     全ユーザの歩数情報
   * @param distances 前ユーザの歩行距離情報
   * @param period    各情報の集計期間
   */
  const updateRankingWithStepsAndDistances = async (steps: Array<IntermediateUserInfo>, distances: Array<IntermediateUserInfo>, period: "daily" | "weekly" | "monthly") => {
    const sortedSteps = steps.sort(compareWithNumber).slice(0, 100);
    const sortedDistances = distances.sort(compareWithNumber).slice(0, 100);
    const updatedRankingResult = await db.collection("rankings").doc(period).set({
      "updatedTime": unixtime,
      "step": convertRanking(sortedSteps),
      "distance": convertRanking(sortedDistances)
    });
    console.log(`update ranking of ${period} steps and distance. [time][${updatedRankingResult.writeTime.seconds}]`);
  }

  // 期間ごとにランキングテーブルを更新
  // 9:00以降であれば昨日の歩数を9:00以前であれば今日の歩数を日次のランキングとして保存
  await updateRankingWithStepsAndDistances(dailySteps, dailyDistances, "daily");
  await updateRankingWithStepsAndDistances(weeklySteps, weeklyDistances, "weekly");
  await updateRankingWithStepsAndDistances(monthlySteps, monthlyDistances, "monthly");
}

export const updateRanking = defaultFunctions()
  .runWith({ memory: "512MB", timeoutSeconds: 9 * 60 })
  .pubsub.schedule("31 5,11,17,23 * * *")
  .timeZone("Asia/Tokyo")
  .onRun(updateRankingHandler)
  ;
