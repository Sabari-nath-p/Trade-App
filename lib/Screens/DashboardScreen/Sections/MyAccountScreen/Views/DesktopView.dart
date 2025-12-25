import 'package:flutter/material.dart';
import 'package:tradeapp/Screens/DashboardScreen/Sections/MyAccountScreen/Components/CreateAccountBtCard.dart';
import 'package:tradeapp/Screens/DashboardScreen/Sections/MyAccountScreen/Components/MyAccountCard.dart';
import 'package:tradeapp/Screens/DashboardScreen/Sections/MyAccountScreen/Components/MyAccountHeaderCard.dart';

class MyAccountDesktop extends StatelessWidget {
  const MyAccountDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyAccountHeaderCard(),
        Wrap(
          children: [MyAccountCard(), MyAccountCard(), CreateAccountBtCard()],
        ),
      ],
    );
  }
}
