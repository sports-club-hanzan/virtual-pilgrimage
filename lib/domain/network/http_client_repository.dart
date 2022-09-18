import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virtualpilgrimage/infrastructure/network/http_client_repository_impl.dart';

final httpClientRepositoryProvider = Provider<HttpClientRepository>(
    (ref) => HttpClientRepositoryImpl(
    ),
);

abstract class HttpClientRepository {
  Future<BitmapDescriptor> loadIconImage(String url);
}
