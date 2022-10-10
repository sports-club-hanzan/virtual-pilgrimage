// CloudStorage の collection のパス定義
extension CloudStorageCollectionPath on String {
  static String pilgrimage(String pilgrimageId, String filename) =>
      'temples/$pilgrimageId/$filename';

  static String user(String userId) => 'users/$userId/profile.png';
}
