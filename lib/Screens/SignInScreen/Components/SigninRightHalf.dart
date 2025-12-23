import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninrightHalf extends StatelessWidget {
  const SigninrightHalf({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome Back",
          style: GoogleFonts.inter(
            color: Color(0xffFFFFFF),
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
