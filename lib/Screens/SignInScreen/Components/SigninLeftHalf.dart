import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Signinlefthalf extends StatelessWidget {
  const Signinlefthalf({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 960.w,
      height: 1200.h,
      child: Stack(
        children: [
          Positioned(
            width: 960.w,
            height: 1200.h,
            child: Image.asset("assets/images/signinbg.png", fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 32.h,
                  width: 32.w,
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
          Positioned(
            left: 48.w,
            bottom: 48.w,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "“The AI analysis has completely transformed\nmy risk management strategy. I can finally see\nthe patterns in my trading behavior.”",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/profileimage.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Alex Chen",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          Text(
                            "Professional Forex Trader",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff92C0C9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
