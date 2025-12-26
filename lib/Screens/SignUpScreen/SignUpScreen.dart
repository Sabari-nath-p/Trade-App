import 'package:flutter/material.dart';
import 'package:tradeapp/Screens/SignInScreen/Views/WebView.dart';
import 'package:tradeapp/Screens/SignUpScreen/Views/DesktopView.dart';
import 'package:tradeapp/Screens/SignUpScreen/Views/MobileView.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111F22),
      body: Column(
        children: [
          if (MediaQuery.of(context).size.width > 500)
            SignupDesktopView()
          else
            SignupMobileView(),
        ],
      ),
    );
  }
}
