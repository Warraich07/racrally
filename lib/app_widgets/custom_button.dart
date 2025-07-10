import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:racrally/app_theme/app_theme.dart';
import 'package:racrally/constants/app_fonts.dart';
import 'package:racrally/constants/app_icons.dart';
import 'package:racrally/extensions/padding_extension.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class CustomButton extends StatefulWidget {
  const CustomButton({super.key, required this.Text, this.width, this.height, this.textSize, this.maxlines, this.onTap, this.buttonColor, this.buttonName, this.textColor, this.fontFamily, this.decoration,this.borderColor,this.isAuth,this.isGoogle,this.isOnBoarding,this.onBoardingText,this.iconPath});
  final String Text;
  final String? iconPath;
  final String? fontFamily;
  final String? buttonName;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? textSize;
  final int? maxlines;
  final Function()? onTap;
  final Color? buttonColor;
  final Color? borderColor;
  final Decoration? decoration;
  final bool? isAuth;
  final bool? isGoogle;
  final bool? isOnBoarding;
  final Widget? onBoardingText;


  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(

      onTap: widget.onTap,
      child:
      Container(
        height: widget.height??48,
        width: widget.width,
        decoration: widget.decoration??BoxDecoration(
            color: widget.buttonColor??AppTheme.secondaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1.3,color: widget.borderColor??AppTheme.secondaryColor)
        ),
        child: Center(
          child:widget.isAuth==null?Text(
            maxLines: widget.maxlines,
            widget.Text,
            style:  TextStyle(
                color: widget.textColor??AppTheme.primaryColor,
                fontSize: widget.textSize??16,
                // fontFamily: widget.fontFamily??"bold",
                fontWeight: FontWeight.w500
            ),
          ):widget.isOnBoarding==true?widget.onBoardingText: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.isGoogle==null? Image.asset(
                widget.iconPath?? AppIcons.facebook,
                height: 18,
                color:  widget.iconPath==null?null:AppTheme.primaryColor,
              ):Image.asset(
                widget.iconPath??AppIcons.google,
                height: 18,
                color:  widget.iconPath==null?null:AppTheme.primaryColor,

              ),
            Text(
              maxLines: widget.maxlines,
              widget.Text,
              style:  TextStyle(
                  color: widget.textColor??AppTheme.primaryColor,
                  fontSize: widget.textSize??16,
                  fontFamily: widget.fontFamily??AppFonts.medium,
                  fontWeight: FontWeight.w500
              ),
            ).paddingOnly(left: 5)
          ],),
        ),

      ),

    );
  }
}
