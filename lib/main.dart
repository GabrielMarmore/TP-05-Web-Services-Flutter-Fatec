import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Joker API",
      theme: ThemeData(brightness: Brightness.light, primaryColor: Colors.blue),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String jokeQ = "";
  String jokeA = "";

  getJoke() async {
    var url = "https://v2.jokeapi.dev/joke/Programming?type=twopart";
    var response = await http.get(Uri.parse(url));

    Map<String, dynamic> data = convert.jsonDecode(response.body);

    setState(() {
      jokeQ = data["setup"];
      jokeA = data["delivery"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joker API"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(60),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Question: $jokeQ",
              style: const TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Text(
                "Answer: $jokeA",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 20),
              child: TextButton(
                onPressed: getJoke,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Generate programming joke",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
