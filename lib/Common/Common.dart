import 'package:flutter/material.dart';

// import 'md5Encrypt.dart';

class ScreenInfo {
  double width;
  double height;

  ScreenInfo(this.width, this.height);
}

Color hexColor(String hexString) {
  if (int.tryParse(hexString.substring(1, 7), radix: 16) == null) {
    hexString = '#999999';
  }
  return new Color(
      int.parse(hexString.substring(1, 7), radix: 16) + 0xFF000000);
}

// ignore: non_constant_identifier_names
ScreenInfo getScreenObj(BuildContext context) {
  final size = MediaQuery.of(context).size;
  double width = size.width;
  double height = size.height;

  ScreenInfo obj = new ScreenInfo(width, height);

  return obj;
}

// String GetUUID() {
//   return Getmd5(new DateTime.now().millisecondsSinceEpoch.toString());
// }
