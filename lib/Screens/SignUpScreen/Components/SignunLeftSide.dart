import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpLeftSide extends StatelessWidget {
  const SignUpLeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/logo.png", height: 32.h, width: 32.w),
              ),
              Text(
                "TradeJournal AI",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff111F22),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Start Trading Smarter",
              style: GoogleFonts.inter(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Color(0xffFFFFFF)
              ),), 
              Text("Create your account to access advanced journaling and AI insights.",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xffFFFFFF)
              ),),
              
               SizedBox(height: 24.h),

            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 46),
                side: BorderSide(color: Color(0xff2B4E54)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/googlelogo.png", height: 18.h),
                  SizedBox(width: 10.w),
                  Text(
                    "Sign up with Google",
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
             SizedBox(height: 20.h),

            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade700)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Or continue with",
                    style: GoogleFonts.inter(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey.shade700)),
              ],
            ),

            ],
          ),
        ),
          ),
        )
      ],
    );
  }
}
