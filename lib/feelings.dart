import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:qubehealth/main.dart';
import 'package:qubehealth/response.dart';

class FeelingsResponse {
  late Dio _dio;

  FeelingsResponse() {
    _dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
  }

  getData() async {
    // Feelings result;
    try {
      final response = await _dio.post(
        "https://www.qubehealth.com/qube_services/api/testservice/getListOfUserFeeling",
        data: {"user_id": "3206161992", "feeling_date": "15-04-2022"},
        options: Options(headers: {
          'X-API-KEY': "f6d646a6c2f2df883ea0cccaa4097358ede98284",
        }),
      );

      if (response.statusCode == 200) {
        final item = json.decode(response.data);
        // result = Feelings.fromJson(item);
        return item;
      } else {
        print("Data not found");
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<FeelingPercentage?> getFeelingPercentage() async {
    FeelingPercentage result;

    try {
      final response = await _dio.post(
        "https://www.qubehealth.com/qube_services/api/testservice/getListOfUserFeeling",
        data: {"user_id": "3206161992", "feeling_date": "15-04-2022"},
        options: Options(headers: {
          'X-API-KEY': "f6d646a6c2f2df883ea0cccaa4097358ede98284",
        }),
      );

      if (response.statusCode == 200) {
        final item = json.decode(response.data);
        result = FeelingPercentage.fromJson(item);
        return result;
      } else {
        print("Data not found");
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
