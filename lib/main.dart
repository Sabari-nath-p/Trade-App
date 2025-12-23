import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tradeapp/Screens/SignInScreen/Components/SigninRightHalf.dart';
import 'package:tradeapp/Screens/SignInScreen/SigninScreen.dart';

void main() {
  runApp(TradeApp());
}

class TradeApp extends StatelessWidget {
  const TradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1200),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, context) {
        return GetMaterialApp(home: Signinscreen());
      },
    );
  }
}
