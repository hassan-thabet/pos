extension VaildateString on String {
  bool get isValidString {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidNumber{
    final phoneRegExp = RegExp(r"^[0-9]");
    return phoneRegExp.hasMatch(this);
  }

}