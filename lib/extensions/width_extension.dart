import 'package:flutter/widgets.dart';
extension WidthExtension on Widget {
  Widget setWidth(double width) {
    return SizedBox(
      width: width,
      child: this,
    );
  }
}