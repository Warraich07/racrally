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
    Get.snackbar(
      _getTitle(type),
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: _getBackgroundColor(type),
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      duration: const Duration(seconds: 3),
      icon: Icon(
        _getIcon(type),
        color: Colors.white,
        size: 28,
      ),
      boxShadows: [
        BoxShadow(
          color: _getBackgroundColor(type).withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
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
        return const Color(0xFF2ECC71);
      case SnackbarType.error:
        return const Color(0xFFE74C3C);
      case SnackbarType.warning:
        return const Color(0xFFF1C40F);
      case SnackbarType.info:
        return const Color(0xFF3498DB);
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