import 'package:flutter/material.dart';
import 'package:tradeapp/Screens/DashboardScreen/Components/NavbarItems.dart';

class NavbarWebView extends StatelessWidget {
  const NavbarWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

         // header code
        NavBarItems(image: "", name: ""),
        NavBarItems(image: "", name: ""),
        NavBarItems(image: "", name: ""),
        NavBarItems(image: "", name: ""),
      ],
    );
  }
}
