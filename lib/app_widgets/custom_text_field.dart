import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../app_theme/app_theme.dart';
import '../constants/app_fonts.dart';


/// Text Field
class CustomTextField extends StatefulWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final String? prefixIcon;
  final bool? isObscure;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final onChanged;
  final String? suffixText;
  final String? prefixText;
  final String? fieldName;
  final inputFormatters;
  final bool? enabled;
  final String? heading;
  final int? maxLines;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? hintTextColor;
  final Color? fieldBorderColor;
  final Color? fillColor;
  final Color? inputTextColor;
  final double? scale;
  final  Function()? onTap;
  final  Function()? onTapSearchIcon;
  final bool isEditProfileInfoScreen;
  final FocusNode? focusNode;
  void Function(String)? onFieldSubmitted;
  CustomTextField(
      {super.key,
        this.hintText,
        this.suffixIcon,
        this.isObscure,
        this.prefixIcon,
        this.validator,
        this.keyboardType,
        this.suffixText,
        this.prefixText,
        this.onChanged,
        this.controller,
        this.inputFormatters,
        this.onTapSearchIcon,
        this.heading,
        this.focusNode,this.onFieldSubmitted,
        this.enabled, this.maxLines, this.prefixIconColor, this.scale, this.onTap, this.fieldName, this.hintTextColor, this.fillColor, this.inputTextColor, this.fieldBorderColor, this.suffixIconColor,this.isEditProfileInfoScreen=false
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
 bool showPassword=false;
  @override
  Widget build(BuildContext context) {
    return
      Column(crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 13.0),
          //   child: BoldText(Text: widget.fieldName.toString()?? '',color: Colors.black),
          // ),
          // SizedBox(height: 5),
          TextFormField(
            onFieldSubmitted: widget.onFieldSubmitted,
            focusNode: widget.focusNode,
            // enabled: widget.enabled??true,
            readOnly: widget.enabled ?? false,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            maxLines:widget.maxLines??1 ,
            onTap: widget.onTap,
            obscureText: widget.isObscure??false,
            obscuringCharacter: "*",
            controller: widget.controller,
            cursorColor: Colors.black,
            cursorErrorColor: Colors.black,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters ?? [],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style:  TextStyle(fontSize: 16,fontFamily: "medium",color: widget.inputTextColor??AppTheme.darkBackgroundColor),
            decoration: InputDecoration(
                constraints: BoxConstraints(minHeight: 48,minWidth: 90.w),
                fillColor:  widget.fillColor??AppTheme.primaryColor,
                filled: true,
                suffixText: widget.suffixText ?? '',
                prefixText: widget.prefixText ?? '',
                prefixStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                    borderSide:  BorderSide(
                        width: 1.3,color: widget.fieldBorderColor??AppTheme.textfieldBorderColor.withOpacity(.3) )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:  BorderSide(
                        width: 1.3,color: widget.fieldBorderColor?? AppTheme.textfieldBorderColor.withOpacity(.3))
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:  BorderSide(
                        width: 1.3,color:  widget.fieldBorderColor??AppTheme.textfieldBorderColor.withOpacity(.3))
                ),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:  BorderSide(
                        width: 1.3,color: widget.fieldBorderColor??AppTheme.textfieldBorderColor.withOpacity(.3))
                ),
                errorBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color:widget.isEditProfileInfoScreen? AppTheme.textfieldBorderColor.withOpacity(.3): AppTheme.textfieldBorderColor.withOpacity(.3), width: 1.3,
                    )
                ),
                focusedErrorBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:  BorderSide(
                        width: 1.3,color:widget.isEditProfileInfoScreen? AppTheme.secondaryColor:Colors.white)
                ),
                hintText: widget.hintText,
                errorStyle:  TextStyle(fontSize: 8,color:AppTheme.secondaryColor,fontWeight: FontWeight.bold),
                errorMaxLines: 3,
                hintStyle:
                TextStyle(
                  fontWeight: FontWeight.w400,
                    fontSize: 14,  fontFamily: AppFonts.medium,color: widget.hintTextColor??AppTheme.lightGreyColor),
                suffixIcon: widget.suffixIcon,
                suffixIconColor: widget.suffixIconColor??AppTheme.lightGreyColor,
                prefixIcon: widget.prefixIcon == null
                    ? const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: SizedBox(),
                )
                    : Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      widget.prefixIcon!,color: widget.prefixIconColor??Colors.white,scale: widget.scale,

                    ),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  maxHeight: 30,
                  minHeight: 30,


                ),
              labelText: widget.fieldName, // 👈 this shows the title inside the border
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: widget.hintTextColor ?? AppTheme.darkBackgroundColor,
                fontFamily: AppFonts.medium,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ],
      );


  }
}
