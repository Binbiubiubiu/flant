RegExp camelizeRE = RegExp(r'-(\w)');

String camelize(String str) {
  return str.replaceAllMapped(
      camelizeRE, (Match c) => (c[1] ?? '').toUpperCase());
}

String padZero(dynamic num, {int targetLength = 2}) {
  final String str = num.toString();

  // while (str.length < targetLength) {
  //   str = '0' + str;
  // }

  return str.padLeft(targetLength, '0');
}
