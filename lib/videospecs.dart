// ignore_for_file: avoid_print

import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:video_player/video_player.dart';

class VideoSpecs extends StatefulWidget {
  final double len;
  const VideoSpecs({required this.len, Key? key}) : super(key: key);

  @override
  State<VideoSpecs> createState() => _VideoSpecsState();
}

class _VideoSpecsState extends State<VideoSpecs> {
  final videoInfo = FlutterVideoInfo();
  bool correctFile = false;
  double l = 0.0;

  chooseFromGallery() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    var a = await videoInfo.getVideoInfo(result!.files.single.path!);

    print(a!.duration! / 1000);
    if ((a.duration! / 1000) <= widget.len) {
      print("Correct");
      setState(() {
        correctFile = true;
        l = (a!.duration! / 1000);
      });
    } else {
      print("Incorrect");
      setState(() {
        l = (a!.duration! / 1000);
        correctFile = false;
        a = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Video length is of $l seconds."),
            ),
            correctFile
                ? const Text("File Uploaded successfully")
                : Text("Upload Proper Video of ${widget.len}"),
            ElevatedButton(
              onPressed: chooseFromGallery,
              child: const Text("Select Video"),
            ),
          ],
        ),
      ),
    );
  }
}
