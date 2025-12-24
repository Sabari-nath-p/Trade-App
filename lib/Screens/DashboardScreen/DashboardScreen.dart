import 'package:flutter/material.dart';
import 'package:tradeapp/Screens/DashboardScreen/Views/Webview.dart';

class Dashboardscreen extends StatelessWidget {
  const Dashboardscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Row(children: [DashboardWebView()]));
  }
}
