import 'package:flutter/widgets.dart';
extension HeightExtension on Widget {
  Widget setHeight(double height) {
    return SizedBox(
      height: height,
      child: this,
    );
  }
}