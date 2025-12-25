import 'package:flutter/material.dart';
import 'package:tradeapp/Screens/DashboardScreen/Sections/AddTradeLogScreen/Components/TradeContextCard.dart';

class AddTradeLogDesktop extends StatelessWidget {
  const AddTradeLogDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("New Trade Entry"), Spacer(), // add remaing icon
          ],
        ),
        TradeContextCard(),
      ],
    );
  }
}
