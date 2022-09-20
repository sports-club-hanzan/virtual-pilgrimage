// Firestore の collection のパス定義
extension FirestoreCollectionPath on String {
  static const String users = 'users';

  static String health(String userId) => '$users/$userId/health';

  static String steps(String userId, DateTime now) => '$users/$userId/steps/';
}
