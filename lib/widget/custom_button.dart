import 'package:flutter/material.dart';


import '../config/config/colors.dart';
import '../config/config/text_style.dart';

Widget buttonView(
    {@required BuildContext? context,
    @required String? title,
    //double? width,
    double? height,
    Color? titleColor,
    Color? buttonColor,
    Color? borderColor,
    Function()? onTap,
    double? borderRadius}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: height ?? 50,
      //width: width ?? 50,
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: buttonColor ?? AppColors.unSelectedBlueColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 15),
        border: Border.all(color: borderColor ?? AppColors.grey, width: 1),
      ),
      child: Center(
        child: Text(
          title!,
          style: AppTextStyle.regular.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: titleColor ?? AppColors.blueColor,
          ),
        ),
      ),
    ),
  );
}
