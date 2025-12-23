import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signinlefthalf extends StatelessWidget {
  const Signinlefthalf({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 960.w,
          height: 1200.h,
          child: Image.asset("assets/images/signinbg.png", fit: BoxFit.cover),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          child: Text(
            "“The AI analysis has completely transformed\nmy risk management strategy. I can finally see\nthe patterns in my trading behavior.”",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
