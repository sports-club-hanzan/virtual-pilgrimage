import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

final userIconRepositoryProvider = Provider<UserIconRepository>(
  (ref) => UserIconRepository(),
);

class UserIconRepository {
  UserIconRepository();

  Future<BitmapDescriptor> loadIconImage(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return BitmapDescriptor.fromBytes(response.bodyBytes.buffer.asUint8List());
  }
}
