import 'package:flutter/cupertino.dart';

import 'colors.dart';

class AppTextStyle{
  static TextStyle regular = const TextStyle(
    fontWeight: FontWeight.normal,
    color: AppColors.blackColor,
    fontSize: 17,
    fontFamily: "Poppins",
    letterSpacing: 0.5,
  );
  static TextStyle medium = const TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
    fontSize: 18,
    fontFamily: "Poppins",
    letterSpacing: 0.5,
  );
  static TextStyle bold = const TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
    fontSize: 18,
    fontFamily: "Poppins",
    letterSpacing: 0.5,
  );
}