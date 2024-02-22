import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("${DateTime.now()} | Uma requisição foi feita!");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("${DateTime.now()} | Uma respsota foi recebida!");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("${DateTime.now()} | Um erro aconteceu!");
    super.onError(err, handler);
  }
}
