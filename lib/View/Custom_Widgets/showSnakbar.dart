import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWidgets {
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color? bgcolor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),

        content: Text(
          message,
          style: GoogleFonts.poppins(fontSize: 15, color: bgcolor),
        ),
      ),
    );
  }
}
