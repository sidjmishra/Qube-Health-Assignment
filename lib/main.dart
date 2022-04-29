import 'package:flutter/material.dart';
import 'package:video_length/videospecs.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Assignment",
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                children: [
                  const Text("Upload 5 seconds video"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const VideoSpecs(len: 5.0))));
                    },
                    child: const Text("Upload"),
                  )
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  const Text("Upload 15 seconds video"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const VideoSpecs(len: 15.0))));
                    },
                    child: const Text("Upload"),
                  )
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  const Text("Upload 30 seconds video"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const VideoSpecs(len: 30.0))));
                    },
                    child: const Text("Upload"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
