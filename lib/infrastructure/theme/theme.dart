import "package:flutter/material.dart";
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

SizedBox defaultHeightSpace = SizedBox(
  height: 24,
);
SizedBox spaceHeightLarge = SizedBox(height: 24);
SizedBox spaceHeightNormal = SizedBox(height: 20);
SizedBox spaceHeightSmall = SizedBox(height: 12);
SizedBox spaceHeightExtraSmall = SizedBox(height: 8);

SizedBox defaultWidthtSpace = SizedBox(
  width: 12,
);
BorderRadius defaultBorderRadius = BorderRadius.circular(12);

class Primary {
  static const Color blue100 = Color.fromRGBO(209, 226, 249, 1);
  static const Color blue200 = Color.fromRGBO(176, 199, 232, 1);
  static const Color blue300 = Color.fromRGBO(127, 167, 223, 1);
  static const Color blue400 = Color.fromRGBO(88, 143, 222, 1);
  static const Color blue500 = Color.fromRGBO(48, 133, 254, 1);
  static const Color blue600 = Color.fromRGBO(47, 119, 222, 1);
  static const Color bg = Color.fromRGBO(242, 242, 242, 2);
  static const Color blue900 = Color.fromRGBO(120, 183, 208, 1);
  // static const Color blue700 = Color.fromRGBO(86, 104, 181, 1);
  // static const Color blue800 = Color.fromRGBO(67, 80, 140, 1);
  // static const Color blue900 = Color.fromRGBO(51, 61, 107, 1);
  static const Color black = Color(0xff353535);
  static const Color blue800 = Color.fromRGBO(34, 123, 148, 1);
  static const Color grey = Color.fromRGBO(175, 178, 183, 1);
  static const Color white = Color(0xffFEFEFE);
  static const Color background = Color(0xffFAFAFA);
  static const Color red = Color(0xffF8475E);
}

final widthScreen = Get.mediaQuery.size.width;
final heightScreen = Get.mediaQuery.size.height;


figmaFontsize(int fontSize) {
  return fontSize * 1.2;
}

class AppTextStyle {
  static TextStyle tsBigTitleBold(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(20),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle tsTitleBold(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(16),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle tsBodyRegular(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(14),
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  static TextStyle tsBodyBold(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(14),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle tsSmallRegular(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(12),
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  static TextStyle tsSmallBold(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(12),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }
}
