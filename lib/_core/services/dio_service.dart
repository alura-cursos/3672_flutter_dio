import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_listin/_core/data/local_data_handler.dart';
import 'package:flutter_listin/listins/data/database.dart';

class DioService {
  final Dio _dio = Dio();

  static const String url =
      "https://flutter-dio-2ca78-default-rtdb.firebaseio.com/";

  Future<void> saveLocalToServer(AppDatabase appdatabase) async {
    Map<String, dynamic> localData =
        await LocalDataHandler().localDataToMap(appdatabase: appdatabase);

    await _dio.put(
      "${url}listins.json",
      data: json.encode(
        localData["listins"],
      ),
      options: Options(contentType: "application/json; utf-8;"),
    );
  }

  getDataFromServer(AppDatabase appDatabase) async {
    Response response = await _dio.get("${url}listins.json");

    // print(response.statusCode);
    // print(response.headers.toString());
    // print(response.data);
    // print(response.data.runtimeType);

    if (response.data != null) {
      if ((response.data as List<dynamic>).isNotEmpty) {
        Map<String, dynamic> map = {};

        map["listins"] = response.data;

        await LocalDataHandler().mapToLocalData(
          map: map,
          appdatabase: appDatabase,
        );
      }
    }
  }
}
