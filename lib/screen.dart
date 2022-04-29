import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qubehealth/feelings.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeelingsHistory extends StatefulWidget {
  const FeelingsHistory({Key? key}) : super(key: key);

  @override
  State<FeelingsHistory> createState() => _FeelingsHistoryState();
}

class _FeelingsHistoryState extends State<FeelingsHistory> {
  bool loaded = false;

  String energetic = "0";
  String sad = "0";
  String angry = "0";
  String happy = "0";
  String calm = "0";
  String bored = "0";
  String love = "0";

  List<dynamic> feeling_list = [];
  List<dynamic> video_arr = [];
  String date = "";
  String day = "";
  String desc = "";
  String link = "";
  DateTime dt = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  void getData() {
    FeelingsResponse().getData().then((value) {
      setState(() {
        energetic = value["data"]["feeling_percentage"]["Energetic"];
        sad = value["data"]["feeling_percentage"]["Sad"];
        angry = value["data"]["feeling_percentage"]["Angry"];
        happy = value["data"]["feeling_percentage"]["Happy"];
        calm = value["data"]["feeling_percentage"]["Calm"];
        bored = value["data"]["feeling_percentage"]["Bored"];
        feeling_list = value["data"]["feeling_list"];
        video_arr = value["data"]["video_arr"];
        loaded = true;
      });

      if (feeling_list.isNotEmpty) {
        setState(() {
          dt = DateTime.parse(feeling_list[0]["submit_time"]);
          _selectedDate = dt;
          date = DateFormat('d MMM, yyyy').format(dt);
          day = DateFormat('EE').format(dt).substring(0, 2);
        });
      }

      if (video_arr.isNotEmpty) {
        setState(() {
          desc = value["data"]["video_arr"][0]["description"];
          link = value["data"]["video_arr"][0]["youtube_url"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? SingleChildScrollView(
            child: Column(
              children: [
                feelingHistory(context),
                const Divider(),
                calendarView(context),
                const Divider(),
                feelingList(context),
                const Divider(),
                additional(context),
                const Divider(color: Colors.white),
                videoThumbnail(),
              ],
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 10.0),
                Text("Please wait! While we get your feelings.",
                    style: GoogleFonts.openSans()),
              ],
            ),
          );
  }

  Widget videoThumbnail() {
    String url = link;
    bool trimWhitespaces = true;
    String id = '';

    if (!url.contains("http") && (url.length == 11)) {
      id = url;
    }
    if (trimWhitespaces) {
      url = url.trim();
    }

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        id = match.group(1)!;
      }
    }

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Container(
      height: 225.h,
      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
          ),
          builder: (builder, player) {
            return const Text("");
          },
        ),
      ),
    );
  }

  Widget calendarView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              date,
              style: GoogleFonts.openSans(
                fontSize: 15.w,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          CalendarTimeline(
            initialDate: _selectedDate,
            firstDate: DateTime.utc(dt.year, DateTime.january, 1),
            lastDate: DateTime.utc(dt.year, DateTime.december, 31),
            onDateSelected: (value) {
              setState(() {
                _selectedDate = value!;
                date = DateFormat('d MMM, yyyy').format(value);
              });
            },
            monthColor: Colors.black,
            dayColor: const Color.fromARGB(255, 180, 180, 180),
            dayNameColor: Colors.white,
            activeDayColor: Colors.white,
            dotsColor: const Color.fromARGB(255, 79, 79, 79),
            activeBackgroundDayColor: const Color.fromARGB(255, 79, 79, 79),
            locale: 'en',
          ),
        ],
      ),
    );
  }

  Widget additional(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Text(
            "You May Find This Interesting",
            style: GoogleFonts.openSans(
              fontSize: 18.w,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            desc,
            textAlign: TextAlign.justify,
            style: GoogleFonts.openSans(
              fontSize: 15.w,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  List<Row> getRows() {
    int time = int.parse(DateFormat('hh').format(dt));
    List<Row> rows = [];
    for (var v = 0; v < feeling_list.length; v++) {
      rows.add(Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              time >= 00 && time <= 04
                  ? Text("12AM - 4AM",
                      style: GoogleFonts.openSans(
                          fontSize: 15.w, fontWeight: FontWeight.w600))
                  : time >= 04 && time <= 08
                      ? Text("4AM - 8AM",
                          style: GoogleFonts.openSans(
                              fontSize: 15.w, fontWeight: FontWeight.w600))
                      : time >= 08 && time <= 12
                          ? Text("8AM - 12PM",
                              style: GoogleFonts.openSans(
                                  fontSize: 15.w, fontWeight: FontWeight.w600))
                          : time >= 12 && time <= 04
                              ? Text("12PM - 4PM",
                                  style: GoogleFonts.openSans(
                                      fontSize: 15.w,
                                      fontWeight: FontWeight.w600))
                              : time >= 04 && time <= 08
                                  ? Text("4PM - 8PM",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15.w,
                                          fontWeight: FontWeight.w600))
                                  : Text("8PM - 12AM",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15.w,
                                          fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              feeling_list[v]["feeling_name"] == "Energetic"
                  ? Text("⚡ Energetic",
                      style: GoogleFonts.openSans(
                          fontSize: 15.w, fontWeight: FontWeight.w600))
                  : feeling_list[v]["feeling_name"] == "Sad"
                      ? Text("😫 Sad",
                          style: GoogleFonts.openSans(
                              fontSize: 15.w, fontWeight: FontWeight.w600))
                      : feeling_list[v]["feeling_name"] == "Happy"
                          ? Text("😃 Happy",
                              style: GoogleFonts.openSans(
                                  fontSize: 15.w, fontWeight: FontWeight.w600))
                          : feeling_list[v]["feeling_name"] == "Angry"
                              ? Text("😡 Angry",
                                  style: GoogleFonts.openSans(
                                      fontSize: 15.w,
                                      fontWeight: FontWeight.w600))
                              : feeling_list[v]["feeling_name"] == "Calm"
                                  ? Text("🍃 Calm",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15.w,
                                          fontWeight: FontWeight.w600))
                                  : feeling_list[v]["feeling_name"] == "Bored"
                                      ? Text("😖 Bored",
                                          style: GoogleFonts.openSans(
                                              fontSize: 15.w,
                                              fontWeight: FontWeight.w600))
                                      : Text("🥰 Love",
                                          style: GoogleFonts.openSans(
                                              fontSize: 15.w,
                                              fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ));
    }
    return rows;
  }

  Widget feelingList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: getRows(),
      ),
    );
  }

  Widget feelingHistory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Your feelings from last 30 days",
            style: GoogleFonts.openSans(
                fontSize: 15.w, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              feeelingCards(context, "⚡", "Energetic", energetic),
              feeelingCards(context, "😫", "Sad", sad),
              feeelingCards(context, "😃", "Happy", happy),
              feeelingCards(context, "😡", "Angry", angry),
              feeelingCards(context, "🍃", "Calm", calm),
              feeelingCards(context, "😖", "Bored", bored),
              feeelingCards(context, "🥰", "Love", love),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              feelingText(context, "Energetic", energetic),
              feelingText(context, "Sad", sad),
              feelingText(context, "Happy", happy),
              feelingText(context, "Angry", angry),
              feelingText(context, "Calm", calm),
              feelingText(context, "Bored", bored),
              feelingText(context, "Love", love),
            ],
          ),
        ],
      ),
    );
  }

  Widget feelingText(BuildContext context, String feeling, String value) {
    return SizedBox(
      width: 40.w,
      child: Text(
        feeling,
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
            color: value == "0" ? Colors.grey : Colors.black,
            fontSize: 10.w,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget feeelingCards(
      BuildContext context, String emoji, String feeling, String value) {
    return Material(
      elevation: value == "0" ? 0.5 : 2.0,
      borderRadius: const BorderRadius.all(
        Radius.circular(40.0),
      ),
      child: Container(
        foregroundDecoration: value == "0"
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.0),
                backgroundBlendMode: BlendMode.softLight,
              )
            : const BoxDecoration(),
        padding: const EdgeInsets.only(top: 18.0),
        decoration: BoxDecoration(
          color: value == "0" ? Colors.white : Colors.grey[100],
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [
            BoxShadow(color: value == "0" ? Colors.white : Colors.grey),
          ],
        ),
        height: 90.h,
        width: 40.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: value == "0"
                  ? const Text("")
                  : Text(
                      "${int.parse(value) * 10}%",
                      style: GoogleFonts.openSans(
                          fontSize: 15.w, fontWeight: FontWeight.w500),
                    ),
            ),
            CircleAvatar(
              backgroundColor: value == "0"
                  ? const Color.fromARGB(255, 200, 231, 199)
                  : const Color.fromARGB(255, 140, 196, 87),
              child: Center(
                child: Text(
                  emoji,
                  style: GoogleFonts.openSans(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
