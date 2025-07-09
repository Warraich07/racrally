import 'package:flutter/widgets.dart';
extension AlignmentExtension on Widget {
  Widget alignCenter() {
    return Align(
      alignment: Alignment.center,
      child: this,
    );
  }
  Widget alignTopCenter() {
    return Align(
      alignment: Alignment.topCenter,
      child: this,
    );
  }
  Widget alignBottomCenter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: this,
    );
  }
  Widget alignTopLeft() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }
  Widget alignBottomLeft() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: this,
    );
  }
  Widget alignTopRight() {
    return Align(
      alignment: Alignment.topRight,
      child: this,
    );
  }
  Widget alignBottomRight() {
    return Align(
      alignment: Alignment.bottomRight,
      child: this,
    );
  }
  Widget alignCenterRight() {
    return Align(
      alignment: Alignment.centerRight,
      child: this,
    );
  }
  Widget alignCenterLeft() {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }
}