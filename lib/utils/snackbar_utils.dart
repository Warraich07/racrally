import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  static void showSnackbar({
    required String message,
    required SnackbarType type,
  }) {
    // Close any existing snackbar
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    final textColor = _getTextColor(type);
    final borderColor = textColor;
    final backgroundColor = _getBackgroundColor(type);

    Get.snackbar(
      _getTitle(type),
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: textColor,
      borderRadius: 10,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      duration: const Duration(seconds: 3),
      borderColor: borderColor,
      borderWidth: 1,
      icon: Icon(
        _getIcon(type),
        color: textColor,
        size: 28,
      ),
      // boxShadows: [
      //   BoxShadow(
      //     color: textColor.withOpacity(0.2),
      //     spreadRadius: 1,
      //     blurRadius: 10,
      //     offset: const Offset(0, 3),
      //   ),
      // ],
    );
  }

  static String _getTitle(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return 'Success';
      case SnackbarType.error:
        return 'Error';
      case SnackbarType.warning:
        return 'Warning';
      case SnackbarType.info:
        return 'Information';
    }
  }

  static Color _getBackgroundColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return const Color(0xFFEDFCF2); // Light green
      case SnackbarType.error:
        return const Color(0xFFFEF3F2); // Light red
      case SnackbarType.warning:
        return const Color(0xFFFEFBE8); // Light yellow
      case SnackbarType.info:
        return const Color(0xFFE8F4FE); // Custom light blue
    }
  }

  static Color _getTextColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return const Color(0xFF2ECC71); // Green
      case SnackbarType.error:
        return const Color(0xFFE74C3C); // Red
      case SnackbarType.warning:
        return const Color(0xFFF1C40F); // Yellow
      case SnackbarType.info:
        return const Color(0xFF3498DB); // Blue
    }
  }

  static IconData _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_circle_outline;
      case SnackbarType.error:
        return Icons.error_outline;
      case SnackbarType.warning:
        return Icons.warning_amber;
      case SnackbarType.info:
        return Icons.info_outline;
    }
  }
}

enum SnackbarType { success, error, warning, info }
