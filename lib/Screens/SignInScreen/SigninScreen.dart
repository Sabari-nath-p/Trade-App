import 'package:flutter/material.dart';
import 'package:tradeapp/Screens/SignInScreen/Views/MobileView.dart';
import 'package:tradeapp/Screens/SignInScreen/Views/WebView.dart';

class Signinscreen extends StatelessWidget {
  const Signinscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (MediaQuery.of(context).size.width > 500)
            SignInWebview()
          else
            SigninMobileView(),
        ],
      ),
    );
  }
}
