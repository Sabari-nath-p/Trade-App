import 'package:flutter/material.dart';

class Responsivesupporter {
  static bool checkIsMobile(BuildContext context) {
    return (MediaQuery.of(context).size.width < 500);
  }
}
