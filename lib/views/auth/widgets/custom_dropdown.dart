import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../app_theme/app_theme.dart';
import '../../../constants/app_fonts.dart';

class CustomDropdownField extends StatelessWidget {
  final String? hintText;
  final double? fontSize;
  final String? fieldName;
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final Function(String?)? onChanged;
  final FormFieldValidator<String>? validator;
  final Color? hintTextColor;
  final Color? fieldBorderColor;
  final Color? fillColor;
  final Color? inputTextColor;
  final Color? dropdownIconColor;
  final bool isEditProfileInfoScreen;

  const CustomDropdownField({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.fieldName,
    this.validator,
    this.hintTextColor,
    this.fieldBorderColor,
    this.fillColor,
    this.inputTextColor,
    this.dropdownIconColor,
    this.isEditProfileInfoScreen = false,
    this.fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: value,
      items: items,
      onChanged: onChanged,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: hintTextColor ?? AppTheme.darkBackgroundColor,
          fontFamily: AppFonts.medium,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        constraints: BoxConstraints(minHeight: 48, minWidth: 90.w),
        fillColor: fillColor ?? AppTheme.primaryColor,
        filled: true,
        contentPadding: const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1.3,
            color: fieldBorderColor ?? AppTheme.textfieldBorderColor.withOpacity(.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1.3,
            color: fieldBorderColor ?? AppTheme.textfieldBorderColor.withOpacity(.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1.3,
            color: fieldBorderColor ?? AppTheme.textfieldBorderColor.withOpacity(.3),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1.3,
            color:AppTheme.textfieldBorderColor.withOpacity(.3),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1.3,
            color: AppTheme.secondaryColor,
          ),
        ),
        errorStyle: TextStyle(
          fontSize: 10,
          color: AppTheme.secondaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      hint: Text(
        hintText ?? '',
        style:  TextStyle(
            fontWeight: FontWeight.w400,
            fontSize:fontSize?? 14,  fontFamily: AppFonts.medium,color: hintTextColor??AppTheme.lightGreyColor),
      ),
      style: TextStyle(
        fontSize:fontSize?? 16,
        fontFamily: "medium",
        color: inputTextColor ?? AppTheme.darkBackgroundColor,
      ),
      iconStyleData: IconStyleData(
        icon: Icon(Icons.keyboard_arrow_down, size: 30, color: dropdownIconColor ?? AppTheme.lightGreyColor),
        iconSize: 30,
        iconEnabledColor: dropdownIconColor ?? AppTheme.lightGreyColor,
        iconDisabledColor: Colors.grey,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        width: 91.w, // Adjust dropdown menu width
        offset: const Offset(0, -4), // Adjust dropdown position
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: fillColor ?? AppTheme.primaryColor,
        ),
      ),
      validator: validator,
      buttonStyleData: ButtonStyleData(
        height: 27, // Set your desired dropdown field height here
        padding: const EdgeInsets.symmetric(horizontal: 0),
      ),
    );
  }
}
