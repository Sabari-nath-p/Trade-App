import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class SignUpRightSide extends StatelessWidget {
  const SignUpRightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.topRight,
        child: Row(
          children: [
            Text("Already have an account?",
            style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffFFFFFF),
                    ),
                    ),
                    TextButton(onPressed: (){}, child: 
                    Text("Log in",
                    style: GoogleFonts.inter(
                       fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2BCDEE),
    
                    ),))
          ],
        ),
      ),
    Center(child: Container(
       height: 514.h,
       width: 512.w,
      child: Image.asset("assets/images/signuprightcontainer.png"))),
    ]);
  }
}
