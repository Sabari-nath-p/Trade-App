import 'package:flutter/material.dart';
import 'package:tradeapp/Screens/SignInScreen/Components/SigninLeftHalf.dart';
import 'package:tradeapp/Screens/SignInScreen/Components/SigninRightHalf.dart';

class SignInWebview extends StatelessWidget {
  const SignInWebview({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Signinlefthalf(),
        Expanded(child: SigninrightHalf()),
      ],
    );
  }
}
