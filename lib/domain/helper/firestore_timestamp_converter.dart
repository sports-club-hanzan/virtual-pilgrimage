import 'package:cloud_firestore/cloud_firestore.dart';

// DateTime <-> Timestamp の相互変換用クラス
class FirestoreTimestampConverter {
  static Timestamp dateTimeToTimestamp(DateTime dateTime) => Timestamp.fromDate(dateTime);

  static DateTime timestampToDateTime(Timestamp timestamp) => timestamp.toDate();
}
