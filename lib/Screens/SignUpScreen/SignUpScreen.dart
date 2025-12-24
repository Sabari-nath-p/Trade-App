import 'package:flutter/material.dart';
import 'package:tradeapp/Screens/SignInScreen/Views/WebView.dart';
import 'package:tradeapp/Screens/SignUpScreen/Views/MobileView.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (MediaQuery.of(context).size.width > 500)
            SignInWebview()
          else
            SignupMobileView(),
        ],
      ),
    );
  }
}
