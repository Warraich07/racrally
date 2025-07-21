import 'package:flutter/cupertino.dart';

class VenueField {
  final TextEditingController controller;
  String label;

  VenueField({required this.label}) : controller = TextEditingController();
}
