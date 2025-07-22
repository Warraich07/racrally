import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../app_theme/app_theme.dart'; // assuming you're using sizer

class CustomToggleBar extends StatelessWidget {
  final List<String> items;
  final int selectedIndex;
  final void Function(int index) onTap;

  const CustomToggleBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(items.length, (index) {
        final isSelected = index == selectedIndex;
        return GestureDetector(

          onTap: () => onTap(index),
          child: Container(
            height: 32,
            width: 28.w,
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.extraLightGreyColor : null,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color:isSelected?
                AppTheme.darkGreyColor:
                AppTheme.darkGreyColor.withOpacity(0.1),
              ),
            ),
            child: Center(
              child: Text(
                items[index],
                style: AppTheme.bodyExtraSmallWeight600Style.copyWith(
                  color: isSelected
                      ? AppTheme.darkBackgroundColor
                      : AppTheme.darkGreyColor,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
