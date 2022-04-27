import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qubehealth/feelings.dart';

class FeelingsHistory extends StatefulWidget {
  const FeelingsHistory({Key? key}) : super(key: key);

  @override
  State<FeelingsHistory> createState() => _FeelingsHistoryState();
}

class _FeelingsHistoryState extends State<FeelingsHistory> {
  late String description;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }

  Widget videoThumbnail() {
    return Container();
  }

  Widget calendarView(BuildContext context) {
    String date = "2 May, 2022";

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
              calendarButton("Mo", "2", true),
              calendarButton("Tu", "3", false),
              calendarButton("We", "4", false),
              calendarButton("Th", "5", false),
              calendarButton("Fr", "6", false),
              calendarButton("Sa", "7", false),
              calendarButton("Su", "8", false),
            ],
          ),
        ],
      ),
    );
  }

  Widget calendarButton(String weekday, String date, bool selected) {
    return Container(
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
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
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

  Widget feelingList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("9AM - 12PM",
                      style: GoogleFonts.openSans(
                          fontSize: 13.w, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10.0),
                  Text("2PM - 4PM",
                      style: GoogleFonts.openSans(
                          fontSize: 13.w, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10.0),
                  Text("4AM - 6PM",
                      style: GoogleFonts.openSans(
                          fontSize: 13.w, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("🥰 Love",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.openSans(
                          fontSize: 13.w, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10.0),
                  Text("😡 Angry",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.openSans(
                          fontSize: 13.w, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10.0),
                  Text("😡 Angry",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.openSans(
                          fontSize: 13.w, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ],
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
              feeelingCards(context, "⚡", "Energetic", "3"),
              feeelingCards(context, "😫", "Sad", "2"),
              feeelingCards(context, "😃", "Happy", "4"),
              feeelingCards(context, "😡", "Angry", "1"),
              feeelingCards(context, "🍃", "Calm", "0"),
              feeelingCards(context, "😖", "Bored", "0"),
              feeelingCards(context, "🥰", "Love", "0"),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              feelingText(context, "Energetic", "3"),
              feelingText(context, "Sad", "2"),
              feelingText(context, "Happy", "4"),
              feelingText(context, "Angry", "1"),
              feelingText(context, "Calm", "0"),
              feelingText(context, "Bored", "0"),
              feelingText(context, "Love", "0"),
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
