bool isMobile(String value) {
  value = value.replaceAll(r'[^-|\d]', '');
  return RegExp(r'^((\+86)|(86))?(1)\d{10}$').hasMatch(value) ||
      RegExp(r'^0[0-9-]{10,13}$').hasMatch(value);
}
