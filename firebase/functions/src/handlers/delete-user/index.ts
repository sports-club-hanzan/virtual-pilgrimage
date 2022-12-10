import {defaultFunctions} from "../function";
import {auth} from "firebase-admin";
import {getFirestore} from "firebase-admin/firestore";
import {getStorage} from "firebase-admin/storage";

export const deleteUser = defaultFunctions()
    // `delete_users/{userId}` にデータが追加されたらfunctionが起動
    .firestore.document("deleted_users/{docId}")
    .onCreate(async (snap) => {
      const doc = snap.data();
      const uid = doc.uid as string;

      const db = getFirestore();
      const storage = getStorage();

      // firestore上のデータ、cloudstorage上のデータ、firebase authentication 上のデータが削除される
      await Promise.all([
        db.doc(`users/${uid}`).delete(),
        storage.bucket(`users/${uid}`).delete(),
        auth().deleteUser(uid),
      ]);
    })
;
