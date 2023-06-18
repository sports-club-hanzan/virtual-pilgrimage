/**
 * ヘルスケア情報の保存形式変更のためのデータマイグレスクリプト
 * npm run adhoc_migrate_health -- "path/to/sdkkey.json"
 */
import * as admin from "firebase-admin";
import { Timestamp } from "@google-cloud/firestore";

// 期間ごとのヘルスケア情報
type HealthByPeriod = {
  burnedCalorie: number;
  distance: number;
  steps: number;
}

// ユーザに紐ずくヘルスケア情報
type Health = {
  today: HealthByPeriod;
  twoDayAgo: HealthByPeriod;
  week: HealthByPeriod;
  month: HealthByPeriod;
  totalSteps: number;
  totalDistance: number;
  updatedAt: Timestamp;
}

// ユーザ情報
// 利用するデータだけ保持している
type User = {
  id: string;
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
  expiredAt: Timestamp;
}

async function main(keyPath: string): Promise<void> {
  // firebase の setup
  const serviceAccount = require(keyPath);
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });
  const db = admin.firestore();

  // 実行日と2日前と8日前の日付を取得
  const today = new Date();
  const twoDayAgo = new Date();
  twoDayAgo.setDate(today.getDate() - 2);
  const eightDayAgo = new Date();
  eightDayAgo.setDate(today.getDate() - 8);

  // ユーザー情報一覧を取得
  const userSnapshot = await db.collection("users").get();

  // usersテーブルの全ての情報をさらって、healthテーブルから期間ごとの情報を全て取得する
  await Promise.all(userSnapshot.docs.map(async (userDoc) => {
    const userId = userDoc.id;
    const user = userDoc.data() as User;
    if (user.health == undefined) {
      console.debug(`migrate skip: no user health data [userId][${userId}]`)
      return;
    }

    // 2日前の日付をyyyyMMdd形式の文字列に変換
    const twoDayAgoStr = `${twoDayAgo.getFullYear()}${("0" + (twoDayAgo.getMonth() + 1)).slice(-2)}${("0" + twoDayAgo.getDate()).slice(-2)}`;
    // 8日前の日付をyyyyMMdd形式の文字列に変換
    const eightDayAgoStr = `${eightDayAgo.getFullYear()}${("0" + (eightDayAgo.getMonth() + 1)).slice(-2)}${("0" + eightDayAgo.getDate()).slice(-2)}`;

    const twoDayAgoExpiredAt = new Date();
    const eightDayAgoExpiredAt = new Date();
    {
      twoDayAgoExpiredAt.setTime(twoDayAgo.getTime())
      twoDayAgoExpiredAt.setMonth(twoDayAgoExpiredAt.getMonth() + 3);
      eightDayAgoExpiredAt.setTime(eightDayAgo.getTime())
      eightDayAgoExpiredAt.setMonth(eightDayAgoExpiredAt.getMonth() + 3);
    }

    const twoDayAgoHealth: HealthEachDay = {
      burnedCalorie: user.health.week.burnedCalorie,
      distance: user.health.week.distance,
      steps: user.health.week.steps,
      date: Timestamp.fromDate(twoDayAgo),
      userId: user.id,
      expiredAt: Timestamp.fromDate(twoDayAgoExpiredAt)
    }
    const eightDayAgoHealth: HealthEachDay = {
      burnedCalorie: user.health.month.burnedCalorie,
      distance: user.health.month.distance,
      steps: user.health.month.steps,
      date: Timestamp.fromDate(eightDayAgo),
      userId: user.id,
      expiredAt: Timestamp.fromDate(eightDayAgoExpiredAt)
    }

    {
      const twoDayAgoExistSnapshot = await db.collection("health").doc(`${userId}_${twoDayAgoStr}`).get();
      const twoDayAgoExistData = twoDayAgoExistSnapshot.data() as HealthEachDay;
      const eightDayAgoExistSnapshot = await db.collection("health").doc(`${userId}_${eightDayAgoStr}`).get();
      const eightDayAgoExistData = eightDayAgoExistSnapshot.data() as HealthEachDay;
      console.log(`twoDayAgo: [userId][${userId}][date][${twoDayAgo}][now][${JSON.stringify(twoDayAgoExistData)}][new][${JSON.stringify(twoDayAgoHealth)}]`);
      console.log(`eightDayAgo: [userId][${userId}][date][${eightDayAgo}][now][${JSON.stringify(eightDayAgoExistData)}][new][${JSON.stringify(eightDayAgoHealth)}]`);
    }

    // 利用する場合はコメントアウトを外す
    await Promise.all([
      db.collection("health").doc(`${userId}_${twoDayAgoStr}`).set(twoDayAgoHealth),
      db.collection("health").doc(`${userId}_${eightDayAgoStr}`).set(eightDayAgoHealth),
    ]);
  }));
}


const keyPath = process.argv[2];
(async () => {
  await main(keyPath);
})();
