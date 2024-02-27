import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api',
      contentType: Headers.jsonContentType,
    ),
  );

  DioClient._();

  static final instance = DioClient._();

  Dio get dio => _dio;
}
