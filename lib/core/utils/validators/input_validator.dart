class InputValidator {
  bool validateEmail(String email) {
    RegExp emailExpression = RegExp(r"");
    return emailExpression.hasMatch(email);
  }

  bool validatePhone(String phone) {
    RegExp phoneExpression = RegExp(r"");
    return phoneExpression.hasMatch(phone);
  }
}
