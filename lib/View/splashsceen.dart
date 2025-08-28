import 'dart:async';
import 'package:flutter/material.dart';
import 'package:list_view/view/todo.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class Splashsceen extends StatefulWidget {
  const Splashsceen({super.key});

  @override
  State createState() => _SplashsceenState();
}

class _SplashsceenState extends State {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 6),
      () => Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => Todo())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: 500,
              width: 350,
              child: Lottie.asset("assets/Task Done.json"),
            ),
          ),
          Text(
            "To-Do App",
            style: GoogleFonts.quicksand(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 200),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Created By Shivam",
                  style: GoogleFonts.quicksand(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
