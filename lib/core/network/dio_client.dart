import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  final Logger logger = Logger();
  late final Dio dio;

  factory DioService() => _instance;

  DioService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8080/api',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          _logRequest(options);
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logResponse(response);
          handler.next(response);
        },
        onError: (DioException error, handler) {
          _logError(error);
          handler.next(error);
        },
      ),
    );
  }

  void _logRequest(RequestOptions options) {
    logger.i('🌐 ${options.method.toUpperCase()} ${options.uri}');
    logger.d('Headers: ${options.headers}');
    logger.d('Request Data: ${options.data}');
    logger.d('Query Parameters: ${options.queryParameters}');
  }

  void _logResponse(Response response) {
    logger.i('✅ ${response.statusCode} ${response.statusMessage}');
    logger.d('Response Headers: ${response.headers}');
    logger.d('Response Data: ${response.data}');
  }

  void _logError(DioException error) {
    logger.e('❌ Error: ${error.message}');
    if (error.response != null) {
      logger.e('Status Code: ${error.response?.statusCode}');
      logger.e('Error Data: ${error.response?.data}');
      logger.e('Error Headers: ${error.response?.headers}');
    }
    logger.e('Stack Trace: ${error.stackTrace}');
  }
}
