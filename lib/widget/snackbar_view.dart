import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../config/config/colors.dart';

SnackbarController snackbarView({
  @required String? title,
  @required String? message,
  bool? isSuccess = false,
  bool? isError = false,
}) {
  
  return Get.snackbar(title!, message!,
      colorText: isSuccess == true || isError == true ? Colors.white : AppColors.blueColor,
      backgroundColor: isSuccess == true
          ? Colors.green
          : isError == true
              ? Colors.red
              : AppColors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 50));
}
