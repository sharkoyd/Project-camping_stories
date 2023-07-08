import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
Widget Button(width, height, btnText, btnColor, onPress, borderColor) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onPress,
      style: OutlinedButton.styleFrom(
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        side: BorderSide(
          color: borderColor, width: 1, // Set the border color
        ),
      ),
      child: Text(
        btnText,
        style: GoogleFonts.openSans(
            color: const Color(0xffF3F3F3),
            fontSize: 12,
            fontWeight: FontWeight.w600),
      ),
    ),
  );
}
