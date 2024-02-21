import 'package:dio/dio.dart';

class DioService {
  final Dio _dio = Dio();

  static const String url =
      "https://flutter-dio-2ca78-default-rtdb.firebaseio.com/";
}
