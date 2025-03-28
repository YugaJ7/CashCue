class PasswordValidator {
  static bool hasMinLength(String password) {
    return password.length >= 8;
  }

  static bool hasUpperLower(String password) {
    return RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumberOrSymbol(String password) {
    return RegExp(r'(?=.*\d)|(?=.*[!@#\$%^&*(),.?":{}|<>])').hasMatch(password);
  }

  static String? validatePassword(String password) {
    List<String> errors = [];

    if (!hasMinLength(password)) {
      errors.add('- At least 8 characters');
    }
    if (!hasUpperLower(password)) {
      errors.add('- Both uppercase and lowercase letters');
    }
    if (!hasNumberOrSymbol(password)) {
      errors.add('- At least one number or symbol');
    }

    return errors.isEmpty ? null : errors.join('\n');
  }
}
