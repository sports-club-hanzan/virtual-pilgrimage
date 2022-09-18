import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:virtualpilgrimage/domain/network/http_client_repository.dart';

class HttpClientRepositoryImpl extends HttpClientRepository {
  HttpClientRepositoryImpl();

  @override
  Future<BitmapDescriptor> loadIconImage(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return BitmapDescriptor.fromBytes(response.bodyBytes.buffer.asUint8List());
  }
}
