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
  String? happy;
  String? sad;
  String? energetic;
  String? calm;
  String? angry;
  String? bored;

  FeelingPercentage(
      {this.happy,
      this.sad,
      this.energetic,
      this.calm,
      this.angry,
      this.bored});

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
  String? userFeelingId;
  String? feelingId;
  String? feelingName;
  String? submitTime;

  FeelingList(
      {this.userFeelingId, this.feelingId, this.feelingName, this.submitTime});

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
  String? title;
  String? description;
  String? youtubeUrl;

  VideoArr({this.title, this.description, this.youtubeUrl});

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
