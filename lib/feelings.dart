import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:qubehealth/main.dart';

class FeelingsResponse {
  late Dio _dio;

  FeelingsResponse() {
    _dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
  }

  Future<List<VideoArr>?> getVideoArr() async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://www.qubehealth.com/qube_services/api/testservice/getListOfUserFeeling"),
        headers: {
          'x-api-key': "f6d646a6c2f2df883ea0cccaa4097358ede98284",
          'content-type': 'application/json'
        },
        body: {"user_id": 3206161992, "feeling_date": "15-04-2022"},
      );
      // final response = await _dio.post(
      //   "https://www.qubehealth.com/qube_services/api/testservice/getListOfUserFeeling",
      //   data: {"user_id": 3206161992, "feeling_date": "15-04-2022"},
      // );

      // _dio.options.headers['x-api-key'] =
      //     "f6d646a6c2f2df883ea0cccaa4097358ede98284";

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print(item);
        List<VideoArr>? result =
            item.map((item) => VideoArr.fromJson(item)).toList();
        print("Found");
        return result;
      } else {
        print("Data not found");
      }
    } catch (e) {
      print(e.toString);
    }
    return null;
  }

  Future<FeelingPercentage?> getFeelingPercentage() async {
    FeelingPercentage result;

    try {
      final response = await http.post(
        Uri.parse(
            "https://www.qubehealth.com/qube_services/api/testservice/getListOfUserFeeling"),
        headers: {
          'x-api-key': "f6d646a6c2f2df883ea0cccaa4097358ede98284",
          'content-type': 'application/json'
        },
        body: {"user_id": 3206161992, "feeling_date": "15-04-2022"},
      );

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = FeelingPercentage.fromJson(item);
        print(result.angry);
        return result;
      } else {
        print("Data not found");
      }
    } catch (e) {
      print(e.toString);
    }
    return null;
  }

  Future<List<FeelingList>?> getFeelingList() async {
    Feelings result;

    try {
      final response = await http.post(
        Uri.parse(
            "https://www.qubehealth.com/qube_services/api/testservice/getListOfUserFeeling"),
        headers: {
          'x-api-key': "f6d646a6c2f2df883ea0cccaa4097358ede98284",
          'content-type': 'application/json'
        },
        body: {"user_id": 3206161992, "feeling_date": "15-04-2022"},
      );

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = Feelings.fromJson(item);
        print("Found");
        return result.data!.feelingList;
      } else {
        print("Data not found");
      }
    } catch (e) {
      print(e.toString);
    }
    return null;
  }
}

class Feelings {
  String? status;
  Data? data;

  Feelings({this.status, this.data});

  Feelings.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  FeelingPercentage? feelingPercentage;
  List<FeelingList>? feelingList;
  List<VideoArr>? videoArr;

  Data({this.feelingPercentage, this.feelingList, this.videoArr});

  Data.fromJson(Map<String, dynamic> json) {
    feelingPercentage = json['feeling_percentage'] != null
        ? FeelingPercentage.fromJson(json['feeling_percentage'])
        : null;
    if (json['feeling_list'] != null) {
      feelingList = <FeelingList>[];
      json['feeling_list'].forEach((v) {
        feelingList!.add(FeelingList.fromJson(v));
      });
    }
    if (json['video_arr'] != null) {
      videoArr = <VideoArr>[];
      json['video_arr'].forEach((v) {
        videoArr!.add(VideoArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feelingPercentage != null) {
      data['feeling_percentage'] = feelingPercentage!.toJson();
    }
    if (feelingList != null) {
      data['feeling_list'] = feelingList!.map((v) => v.toJson()).toList();
    }
    if (videoArr != null) {
      data['video_arr'] = videoArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeelingPercentage {
  late String happy;
  late String sad;
  late String energetic;
  late String calm;
  late String angry;
  late String bored;

  FeelingPercentage(
      {required this.happy,
      required this.sad,
      required this.energetic,
      required this.calm,
      required this.angry,
      required this.bored});

  FeelingPercentage.fromJson(Map<String, dynamic> json) {
    happy = json['Happy'];
    sad = json['Sad'];
    energetic = json['Energetic'];
    calm = json['Calm'];
    angry = json['Angry'];
    bored = json['Bored'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Happy'] = happy;
    data['Sad'] = sad;
    data['Energetic'] = energetic;
    data['Calm'] = calm;
    data['Angry'] = angry;
    data['Bored'] = bored;
    return data;
  }
}

class FeelingList {
  late String userFeelingId;
  late String feelingId;
  late String feelingName;
  late String submitTime;

  FeelingList(
      {required this.userFeelingId,
      required this.feelingId,
      required this.feelingName,
      required this.submitTime});

  FeelingList.fromJson(Map<String, dynamic> json) {
    userFeelingId = json['user_feeling_id'];
    feelingId = json['feeling_id'];
    feelingName = json['feeling_name'];
    submitTime = json['submit_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_feeling_id'] = userFeelingId;
    data['feeling_id'] = feelingId;
    data['feeling_name'] = feelingName;
    data['submit_time'] = submitTime;
    return data;
  }
}

class VideoArr {
  late String title;
  late String description;
  late String youtubeUrl;

  VideoArr(
      {required this.title,
      required this.description,
      required this.youtubeUrl});

  VideoArr.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    youtubeUrl = json['youtube_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['youtube_url'] = youtubeUrl;
    return data;
  }
}
