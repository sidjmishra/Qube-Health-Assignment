import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qubehealth/feelings.dart';

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

  @override
  void initState() {
    super.initState();
    getData();
  }

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
    return Container();
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
                fontSize: 12.w,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              day == "Mo"
                  ? calendarButton("Mo", date.substring(0, 2), true)
                  : calendarButton("Mo", date.substring(0, 2), false),
              day == "Tu"
                  ? calendarButton("Tu", date.substring(0, 2), true)
                  : calendarButton("Tu", date.substring(0, 2), false),
              day == "We"
                  ? calendarButton("We", date.substring(0, 2), true)
                  : calendarButton("We", date.substring(0, 2), false),
              day == "Th"
                  ? calendarButton("Th", date.substring(0, 2), true)
                  : calendarButton("Th", date.substring(0, 2), false),
              day == "Fr"
                  ? calendarButton("Fr", date.substring(0, 2), true)
                  : calendarButton("Fr", date.substring(0, 2), false),
              day == "Sa"
                  ? calendarButton("Sa", date.substring(0, 2), true)
                  : calendarButton("Sa", date.substring(0, 2), false),
              day == "Su"
                  ? calendarButton("Su", date.substring(0, 2), true)
                  : calendarButton("Su", date.substring(0, 2), false),
            ],
          ),
        ],
      ),
    );
  }

  Widget calendarButton(String weekday, String date, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected ? selected = false : selected = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: selected ? Colors.grey[800] : Colors.transparent,
        ),
        height: 90.h,
        width: 40.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekday,
              style: selected
                  ? GoogleFonts.openSans(color: Colors.white, fontSize: 15.w)
                  : GoogleFonts.openSans(color: Colors.black, fontSize: 15.w),
            ),
            const SizedBox(height: 10.0),
            Text(
              date,
              style: selected
                  ? GoogleFonts.openSans(color: Colors.white, fontSize: 15.w)
                  : GoogleFonts.openSans(color: Colors.black, fontSize: 15.w),
            ),
          ],
        ),
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
              fontSize: 13.w,
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
                          fontSize: 13.w, fontWeight: FontWeight.w600))
                  : time >= 04 && time <= 08
                      ? Text("4AM - 8AM",
                          style: GoogleFonts.openSans(
                              fontSize: 13.w, fontWeight: FontWeight.w600))
                      : time >= 08 && time <= 12
                          ? Text("8AM - 12PM",
                              style: GoogleFonts.openSans(
                                  fontSize: 13.w, fontWeight: FontWeight.w600))
                          : time >= 12 && time <= 04
                              ? Text("12PM - 4PM",
                                  style: GoogleFonts.openSans(
                                      fontSize: 13.w,
                                      fontWeight: FontWeight.w600))
                              : time >= 04 && time <= 08
                                  ? Text("4PM - 8PM",
                                      style: GoogleFonts.openSans(
                                          fontSize: 13.w,
                                          fontWeight: FontWeight.w600))
                                  : Text("8PM - 12AM",
                                      style: GoogleFonts.openSans(
                                          fontSize: 13.w,
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
                          fontSize: 13.w, fontWeight: FontWeight.w600))
                  : feeling_list[v]["feeling_name"] == "Sad"
                      ? Text("😫 Sad",
                          style: GoogleFonts.openSans(
                              fontSize: 13.w, fontWeight: FontWeight.w600))
                      : feeling_list[v]["feeling_name"] == "Happy"
                          ? Text("😃 Happy",
                              style: GoogleFonts.openSans(
                                  fontSize: 13.w, fontWeight: FontWeight.w600))
                          : feeling_list[v]["feeling_name"] == "Angry"
                              ? Text("😡 Angry",
                                  style: GoogleFonts.openSans(
                                      fontSize: 13.w,
                                      fontWeight: FontWeight.w600))
                              : feeling_list[v]["feeling_name"] == "Calm"
                                  ? Text("🍃 Calm",
                                      style: GoogleFonts.openSans(
                                          fontSize: 13.w,
                                          fontWeight: FontWeight.w600))
                                  : feeling_list[v]["feeling_name"] == "Bored"
                                      ? Text("😖 Bored",
                                          style: GoogleFonts.openSans(
                                              fontSize: 13.w,
                                              fontWeight: FontWeight.w600))
                                      : Text("🥰 Love",
                                          style: GoogleFonts.openSans(
                                              fontSize: 13.w,
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
                fontSize: 13.w, fontWeight: FontWeight.w600),
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
        maxLines: 1,
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
            color: value == "0" ? Colors.grey : Colors.black,
            fontSize: 9.w,
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
                          fontSize: 13.w, fontWeight: FontWeight.w300),
                    ),
            ),
            CircleAvatar(
              backgroundColor: value == "0"
                  ? Colors.lightGreen[200]
                  : Colors.lightGreenAccent[700],
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
