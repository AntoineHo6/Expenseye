class CheckTextFieldsUtil {
  static bool isStringInvalid(String arg) {
    return arg.trim().isEmpty ? true : false;
  }

  static bool isNumberStringInvalid(String arg) {
    try {
      double.parse(arg);
      return false;
    } on FormatException {
      return true;
    }
  }
}
