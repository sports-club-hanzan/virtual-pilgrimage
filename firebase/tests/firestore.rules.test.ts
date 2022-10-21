// https://firebase.google.com/docs/firestore/security/test-rules-emulator

import * as firebase from '@firebase/rules-unit-testing';
import * as fs from 'fs';
import * as uuid from 'uuid';

const uid = () => uuid.v4();
const projectId = uid();
const databaseName = 'virtual-pilgrimage-test';
const rules = fs.readFileSync('./firestore.rules', 'utf8');
let testEnv: firebase.RulesTestEnvironment;

type Auth = {
  uid?: string;
  // other fields are used as request.auth.token in firestore.rules
  [key: string]: any;
};

// setup and clean up
beforeAll(async () => {
  testEnv = await firebase.initializeTestEnvironment({
    projectId,
    firestore: {
      rules,
    },
  });
});

beforeEach(async () => {
  await testEnv.clearFirestore();
});

afterAll(async () => {
  await testEnv.cleanup();
});

describe('/users', () => {
  describe('create', () => {
    describe('正常系', () => {
      it('作成できる', async () => {
        // given
        const userId = uid();
        const context = testEnv.authenticatedContext(userId);

        // when
        await firebase.assertSucceeds(
          context.firestore().doc(`users/${userId}`).set({
            nickname: 'taro12',
            email: 'test@example.com',
            gender: 0, // 0 は性別未設定
          })
        );
      });

      it('nicknameを指定せずとも作成できる(ユーザ登録時のユースケース)', async () => {
        // given
        const userId = uid();
        const context = testEnv.authenticatedContext(userId);

        // when
        await firebase.assertSucceeds(
          context.firestore().doc(`users/${userId}`).set({
            // nickname: 'taro12',
            email: 'test@example.com',
            gender: 0, // 0 は性別未設定
          })
        );
      });

      it.each`
        email                       | casename
        ${'example.corp@gmail.com'} | ${'gmail'}
        ${'example@yahoo.co.jp'}    | ${'yahoo.co.jp'}
        ${'example@yahoo.ne.jp'}    | ${'yahoo.ne.jp'}
        ${'example@ymail.ne.jp'}    | ${'ymail.ne.jp'}
        ${'example@outlook.jp'}     | ${'outlook(jp)'}
        ${'example@outlook.com'}    | ${'outlook(com)'}
        ${'example@docomo.ne.jp'}   | ${'docomo'}
        ${'example@ezweb.ne.jp'}    | ${'au'}
        ${'example@softbank.ne.jp'} | ${'softbank'}
      `('主要なメールアドレスで作成できる: $casename', async ({ email }) => {
        // given
        const userId = uid();
        const context = testEnv.authenticatedContext(userId);

        // when
        await firebase.assertSucceeds(
          context.firestore().doc(`users/${userId}`).set({
            nickname: 'taro12',
            email,
            gender: 0,
          })
        );
      });
    });

    describe('異常系', () => {
      const userId = uid();
      it.each`
        uid       | nickname     | email                 | gender | casename
        ${uid()}  | ${'taro12'}  | ${'test@example.com'} | ${0}   | ${'別のユーザが作成する'}
        ${userId} | ${'t'}       | ${'test@example.com'} | ${0}   | ${'ユーザ名が短い'}
        ${userId} | ${123456789} | ${'test@example.com'} | ${0}   | ${'ユーザ名が文字列でない'}
        ${userId} | ${'taro12'}  | ${'test@exampl'}      | ${0}   | ${'emailが不適切'}
        ${userId} | ${'taro12'}  | ${'test@example.com'} | ${4}   | ${'genderが4以上'}
        ${userId} | ${'taro12'}  | ${'test@example.com'} | ${-1}  | ${'genderが0未満'}
      `('$casename', async ({ uid, nickname, email, gender }) => {
        // given
        const context = testEnv.authenticatedContext(userId);

        // when
        await firebase.assertFails(
          context.firestore().doc(`users/${uid}`).set({
            nickname: nickname,
            email: email,
            gender: gender,
          })
        );
      });
    });
  });
});
