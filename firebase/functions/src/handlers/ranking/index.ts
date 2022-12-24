import { getFirestore } from "firebase-admin/firestore";
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
  week: HealthByPeriod;
  month: HealthByPeriod;
  totalSteps: number;
  totalDistance: number;
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

const updateRankingHandler = async () => {
  const db = getFirestore();
  const querySnapshot = await db.collection("users").get();

  const todaySteps: Array<IntermediateUserInfo> = []
  const todayDistances: Array<IntermediateUserInfo> = []
  const weekSteps: Array<IntermediateUserInfo> = []
  const weekDistances: Array<IntermediateUserInfo> = []
  const monthSteps: Array<IntermediateUserInfo> = []
  const monthDistances: Array<IntermediateUserInfo> = []

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
    todaySteps.push({ id: doc.id, value: user.health.today.steps, ...userInfoForRanking });
    todayDistances.push({ id: doc.id, value: user.health.today.distance, ...userInfoForRanking });
    weekSteps.push({ id: doc.id, value: user.health.week.steps, ...userInfoForRanking });
    weekDistances.push({ id: doc.id, value: user.health.week.distance, ...userInfoForRanking });
    monthSteps.push({ id: doc.id, value: user.health.month.steps, ...userInfoForRanking });
    monthDistances.push({ id: doc.id, value: user.health.month.distance, ...userInfoForRanking });
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
  await updateRankingWithStepsAndDistances(todaySteps, todayDistances, "daily");
  await updateRankingWithStepsAndDistances(weekSteps, weekDistances, "weekly");
  await updateRankingWithStepsAndDistances(monthSteps, monthDistances, "monthly");
}

export const updateRanking = defaultFunctions()
  .runWith({ memory: "512MB", timeoutSeconds: 9 * 60 })
  .pubsub.schedule("0 4 * * *")
  .timeZone("Asia/Tokyo")
  .onRun(updateRankingHandler)
  ;