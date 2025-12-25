import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradeapp/Screens/DashboardScreen/DashboardScreen.dart';
import 'package:tradeapp/Screens/DashboardScreen/Views/Webview.dart';
import 'package:tradeapp/Screens/SignUpScreen/SignUpScreen.dart';

class SigninrightHalf extends StatelessWidget {
  const SigninrightHalf({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //  height: 598.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 24.w),
        decoration: BoxDecoration(
          color: Color(0xff111F22),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 30.sp,
                fontWeight: FontWeight.w900,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              "Access your intelligent trading dashboard.",
              style: GoogleFonts.inter(fontSize: 16, color: Color(0xff92C0C9)),
            ),

            SizedBox(height: 24.h),

            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 46.h),
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

            SizedBox(height: 20.h),
            Text(
              "Email Address",
              style: GoogleFonts.inter(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 6.h),

            TextField(
              decoration: InputDecoration(
                hintText: "trader@example.com",
                hintStyle: GoogleFonts.inter(color: Colors.grey),
                prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                filled: true,
                fillColor: Color(0xff16282C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              "Password",
              style: GoogleFonts.inter(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 6.h),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "••••••••",
                hintStyle: GoogleFonts.inter(color: Colors.grey),
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                suffixIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: const Color(0xff16282C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (_) {},
                  side: BorderSide(color: Colors.grey),
                ),
                Text(
                  "Remember me",
                  style: GoogleFonts.inter(
                    color: Color(0xff92C0C9),
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  "Forgot Password?",
                  style: GoogleFonts.inter(
                    color: Color(0xff2BCDEE6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            InkWell(
              onTap: () {
                Get.to(
                  () => Dashboardscreen(),
                  transition: Transition.rightToLeft,
                );
              },
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff2BCDEE),
                ),
                child: Center(
                  child: Text(
                    "Log In",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            Row(
              children: [
                Text(
                  "Don't have an account? ",
                  style: GoogleFonts.inter(
                    color: Color(0xff92C0C9),
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 10.h),
                InkWell(
                  onTap: () {
                    print("clicked here");
                    Get.to(
                      () => Signupscreen(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Text(
                    "Sign up for free",
                    style: GoogleFonts.inter(
                      color: Color(0xffFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
