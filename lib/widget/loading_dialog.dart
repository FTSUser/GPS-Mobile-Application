import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/config/colors.dart';
import '../config/config/image_path.dart';

void showLoadingDialog() {
  Future.delayed(Duration.zero, () {
    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(10)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      ImagePath.appLogoIconIcon,
                    )),
                const SizedBox(
                  height: 45,
                  width: 45,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  });
}

void hideLoadingDialog({bool istrue = false}) {
  Get.back(closeOverlays: istrue);
}
