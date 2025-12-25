import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradeapp/Screens/DashboardScreen/Components/NavbarWeb.dart';
import 'package:tradeapp/Screens/DashboardScreen/Sections/MyAccountScreen/MyAccountScreen.dart';

class DashboardWebView extends StatelessWidget {
  const DashboardWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 100.w, child: NavbarWebView()),
            MyAccountScreen(),
          ],
        ),
      ],
    );
  }
}
