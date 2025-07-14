class CustomValidator {
  static String? email(String? value) {
    if (value!.isEmpty) {
      return ' Email address is required';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return ' Please enter valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value!.isEmpty) {
      return 'Enter password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  static String? newPassword(String? value) {
    if (value!.isEmpty) {
      return 'Enter new password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }


  static String? oldPassword(String? value) {
    if (value!.isEmpty) {
      return 'Enter old password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static String? confirmPassword(String? value, String oldPassword) {
    if (value!.isEmpty) {
      return ' Confirm password is required';
    } else if (value.length < 8) {
      return ' Password must be at least 8 characters';
    }
    else if (value != oldPassword) {
      return ' Confirm password is not matched';
    }
    return null;
  }

  static String? firstName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your First Name';
    }
    return null;
  }

  static String? otp(String? value) {
    if (value!.isEmpty) {
      return 'Please enter otp';
    }
    if (value.length<4) {
      return 'Please enter valid otp';
    }
    return null;
  }

  static String? lastName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your Last Name';
    }
    return null;
  }
  static String? isEmptyFirstName(String? value) {
    // Check if the value is empty
    if (value!.isEmpty) {
      return "First name is required";
    }

    // Check if the value contains any digits
    if (RegExp(r'[0-9]').hasMatch(value)) {
      return "First name cannot contain numbers";  // Add this message in Languages
    }

    return null;
  }


  static String? isEmptySubscriptionCode(String? value) {
    if (value!.isEmpty) {
      return 'Please enter subscription code';
    }
    return null;
  }
  static String? selectGenderRange(String? value) {
    // Ensure value is not null or empty
    if (value == null || value.isEmpty) {
      return 'Please select gender';
    }

    // Check if the input contains any digits
    final RegExp numberRegex = RegExp(r'[0-9]');
    if (numberRegex.hasMatch(value)) {
      return 'Gender cannot contain numbers';
    }

    return null; // No errors
  }
}
