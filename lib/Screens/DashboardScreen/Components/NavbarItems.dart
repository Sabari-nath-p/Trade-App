import 'package:flutter/material.dart';

class NavBarItems extends StatelessWidget {
  String image;
  bool isSelected;
  String name;
  NavBarItems({
    super.key,
    required this.image,
    this.isSelected = false,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(image),
    );
  }
}
