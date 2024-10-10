import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTitlebar extends StatelessWidget {
  const AuthTitlebar({required this.title, required this.subTitle, super.key});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        children: [
          TextSpan(
            text: subTitle,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
        style: GoogleFonts.outfit(
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
