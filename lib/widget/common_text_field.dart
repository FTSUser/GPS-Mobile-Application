import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_tracker/config/config/image_path.dart';

import '../config/config/colors.dart';
import '../config/config/text_style.dart';
import '../utils/valdation/textfiled_validation.dart';
Widget textView({
  @required BuildContext? context,
  @required String? hintText,
  String? titleName,
  bool obscureText = false,
  Function(String)? onFieldSubmitted,
  int? maxLength,
  Function()? suffixIconOnPress,
  TextInputType? textInputType,
  TextEditingController? controller,
  IconData? suffixIcon,
  Widget? prefixIcon,
  Color? color,
  double? horizantalMargin,
  double? verticleMargin,
  double? contentPaddingTop,
  double? contentPaddingBottom,
  String? validationMessage,
  List<TextInputFormatter>? inputFormat,
  bool needValidation = false,
  int? maxLine,
  bool isPasswordValidator = false,
  bool isEmailValidator = false,
  bool isPhoneNumberValidator = false,
  bool readOnly = false,
  String? Iconpath,
  bool? showBorder,

}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: horizantalMargin ?? 0, vertical: verticleMargin ?? 0),
    child: TextFormField(
      autofocus: false,
      autocorrect: true,
      readOnly: readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLine ?? 1,

      onFieldSubmitted: onFieldSubmitted,
      maxLength: maxLength, inputFormatters: inputFormat,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      style: AppTextStyle.regular.copyWith(fontSize: 16, color: AppColors.blackColor),
      keyboardType: textInputType ?? TextInputType.text,
      controller: controller,
      cursorColor: AppColors.primaryColor,
      validator: needValidation
          ? (value) => TextFieldValidation.validation(
              value: value ?? "",
              isPasswordValidator: isPasswordValidator,
              message: validationMessage ?? hintText,
              isEmailValidator: isEmailValidator,
              isPhoneNumberValidator: isPhoneNumberValidator)
          : null,
      onSaved: (data) {
        return;
      },
      decoration: InputDecoration(
        prefixIcon: prefixIcon == null ? null: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 9.0),
              child: prefixIcon,
            ),
          ],
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color: color,
                ),
                onPressed: suffixIconOnPress,
              )
            : null,
        counterText: '',
        fillColor: Colors.white,
        filled: true,
        contentPadding:  EdgeInsets.only(left: 8, top: contentPaddingTop ?? 14, bottom:contentPaddingBottom ?? 14, right: 0),
        isDense: true,
        hintText: hintText,
        hintStyle: AppTextStyle.regular.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.greyColor,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide:  BorderSide(
            width: 1,
            color:showBorder == false?AppColors.transparent: AppColors.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1.0
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color:showBorder == false?AppColors.transparent: AppColors.primaryColor, width: 1.0
          ),
        ),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(
            width: 1,
            color:showBorder == false?AppColors.transparent: AppColors.primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color:showBorder == false?AppColors.transparent: AppColors.primaryColor,
          ),
        ),
      ),
    ),
  );
}
