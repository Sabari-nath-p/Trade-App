import 'package:flutter/material.dart';
import 'package:tradeapp/Screens/SignUpScreen/Components/SignunLeftSide.dart';
import 'package:tradeapp/Screens/SignUpScreen/Components/SignupRightSide.dart';

class SignupDesktopView extends StatelessWidget {
  const SignupDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [SignUpLeftSide(), SignUpRightSide()]);
  }
}
