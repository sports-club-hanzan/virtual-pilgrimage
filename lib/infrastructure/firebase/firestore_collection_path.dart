// Firestore の collection のパス定義
class FirestoreCollectionPath {
  static const String users = 'users';
  static String health(String userId) => '$users/$userId/health';
}
