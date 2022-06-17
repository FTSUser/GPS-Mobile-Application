
import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gps_tracker/screens/auth/signup.dart';
import '../../config/config/colors.dart';
import '../../config/config/image_path.dart';
import '../../config/config/text_style.dart';
import '../../controller/auth/authcontroller.dart';
import '../../widget/common_text_field.dart';
import '../../widget/custom_button.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final login = GlobalKey<FormState>();
  bool isObscureText = true;


  final authController = Get.put(AuthController());
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      // appBar: commonAppBar(
      //   isShowIcon2: true,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: login,
            child: ListView(
              children: [
                 Image.asset(ImagePath.loginLogo),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                    Text("LogIn",
                        style: AppTextStyle.regular.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                            fontSize: 24)),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: textView(
                          prefixIcon: Container(
                              height: 18,width: 17,
                              child: SvgPicture.asset(ImagePath.emialicon,fit: BoxFit.fill,)),
                          context: context,
                          //controller: authController.name,
                          hintText: "Email",
                          controller:authController.email,
                          needValidation: true,
                          isEmailValidator: true,
                          validationMessage: "Email",
                          titleName: '',
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    textView(
                        prefixIcon: SvgPicture.asset(ImagePath.lockicon,fit: BoxFit.fill,height: 18,width: 17,color: AppColors.blackColor),
                        context: context,
                        hintText: "Password",
                        controller: authController.password,
                        suffixIcon: isObscureText ? Icons.visibility_off : Icons.visibility,
                        suffixIconOnPress: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                        needValidation: true,
                        onFieldSubmitted: (v) {
                          if (login.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            authController.signIn();
                          }
                        },
                        //controller: authController.password,

                        obscureText: isObscureText,
                        validationMessage: "Password",
                        color: AppColors.greyColor,
                        titleName: ''),

                    const SizedBox(height: 30),


                    buttonView(
                        onTap: () {
                          if (login.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            authController.signIn();
                          }
                        },
                        height: 40,
                        borderRadius: 5,
                        buttonColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                        titleColor: AppColors.whiteColor,
                        context: context,
                        title: "LogIn"
                    ),
                    SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                        Get.to(()=>SignupScreen());
                        // Get.to(()=>MapScreen());
                        //Get.to(SignupScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New Gps Tracker?",style: AppTextStyle.medium.copyWith(fontSize: 14,fontWeight: FontWeight.w400)),
                          Text("SignUp",style: AppTextStyle.medium.copyWith(color: AppColors.primaryColor,fontSize: 14,fontWeight: FontWeight.w500)),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
  }
}

