import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/View/Custom_Widgets/showSnakbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailtextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void clearController() {
    emailtextEditingController.clear();
    _passwordtextEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "WellCome Back To",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign-Up",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "Email ID",
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: emailtextEditingController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.black12,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: _passwordtextEditingController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.black12,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () async {
                      if (emailtextEditingController.text.trim().isNotEmpty &&
                          _passwordtextEditingController.text
                              .trim()
                              .isNotEmpty) {
                        try {
                          UserCredential userCredentialobj = await _firebaseAuth
                              .createUserWithEmailAndPassword(
                                email: emailtextEditingController.text,
                                password: _passwordtextEditingController.text,
                              );
                          CustomWidgets.showSnackBar(
                            context,
                            "Sign-UP Successfully",
                            bgcolor: Colors.green,
                          );
                          log("UserCredential : $userCredentialobj");
                        } on FirebaseAuthException catch (error) {
                          log("Exception is the : $error");
                          CustomWidgets.showSnackBar(
                            context,
                            "${error.message}",
                            bgcolor: Colors.redAccent,
                          );
                        }
                        clearController();
                      } else {
                        CustomWidgets.showSnackBar(
                          context,
                          "Please Enter Some Data",
                          bgcolor: Colors.redAccent,
                        );
                      }
                      clearController();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Sign-Up",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
