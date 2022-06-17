
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:gps_tracker/screens/auth/login_screen.dart';
import '../../config/config/colors.dart';
import '../../config/config/image_path.dart';
import '../../config/config/text_style.dart';
import '../../controller/auth/authcontroller.dart';
import '../../widget/common_text_field.dart';
import '../../widget/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<SignupScreen> {
  final signup = GlobalKey<FormState>();
  final authcontroller = Get.put(AuthController());

  bool isObscureText = true;

  // final authController = Get.put(AuthController());
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(milliseconds: 20),(){
      _scrollController.animateTo(0.0, duration: const Duration(seconds: 3), curve: Curves.elasticOut);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      // appBar: commonAppBar(
      //   isShowIcon2: true,
      // ),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: signup,
            child: ListView(
              controller: _scrollController,
              children: [
                Image.asset(ImagePath.loginLogo),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sign up",
                        style: AppTextStyle.regular.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                            fontSize: 24)),
                    const SizedBox(
                      height: 20,
                    ),
                    textView(
                      prefixIcon: SvgPicture.asset(ImagePath.profileicon,),
                      context: context,
                      //controller: authController.name,
                      hintText: "First name",
                      controller: authcontroller.firstname,
                      needValidation: true,
                      validationMessage: "First name",
                      titleName: '',
                    ),
                    const SizedBox(
                      height: 10,
                    ), textView(
                      prefixIcon: SvgPicture.asset(ImagePath.profileicon,),
                      context: context,
                      //controller: authController.name,
                      hintText: "Last name",
                      controller: authcontroller.lastname,
                      needValidation: true,
                      validationMessage: "Last name",
                      titleName: '',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: textView(
                          prefixIcon: Container(
                              height: 18,width: 17,
                              child: SvgPicture.asset(ImagePath.emialicon,fit: BoxFit.fill,color: AppColors.greyColor,)),
                          context: context,
                          //controller: authController.name,
                          hintText: "Example@gmail.com",
                          controller:authcontroller.signupEmail,
                          needValidation: true,
                          isEmailValidator: true,
                          validationMessage: "Email",
                          titleName: '',
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              // border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(18)
                          ),
                          margin: EdgeInsets.only(bottom: 8),

                          child: CountryCodePicker(
                            onChanged:print,
                            initialSelection: 'IN',
                            favorite: ['+91','IN'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0,left: 5),
                            child: textView(
                              showBorder: false,
                              textInputType: TextInputType.number,
                              contentPaddingTop: 18,
                              contentPaddingBottom: 18,
                              context: context,
                              //controller: authController.name,
                              hintText: "00000 00000",
                              controller:authcontroller.phone,
                              needValidation: true,
                              validationMessage: "Number",
                              titleName: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                    textView(
                        prefixIcon: SvgPicture.asset(ImagePath.lockicon,fit: BoxFit.fill,height: 18,width: 17,),
                        context: context,
                        hintText: "Password",
                        controller: authcontroller.signupPassword,
                        suffixIcon: isObscureText ? Icons.visibility_off : Icons.visibility,
                        suffixIconOnPress: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                        needValidation: true,
                        onFieldSubmitted: (v) {
                          if (signup.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                           authcontroller.signUp();
                          }
                        },
                        //controller: authController.password,
                        isPasswordValidator: true,
                        obscureText: isObscureText,
                        validationMessage: "Password",
                        color: AppColors.greyColor,
                        titleName: ''),

                    const SizedBox(height: 30),


                    buttonView(
                        onTap: () {
                          if (signup.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                           authcontroller.signUp();
                          }
                        },
                        height: 40,
                        borderRadius: 5,
                        buttonColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                        titleColor: AppColors.whiteColor,
                        context: context,
                        title: "Sign up"
                    ),
                    SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                        Get.to(()=>LogInScreen());
                        // Get.to(()=>MapScreen());
                        //Get.to(SignupScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New Gps Tracker?",style: AppTextStyle.medium.copyWith(fontSize: 14,fontWeight: FontWeight.w400)),
                          Text("Login",style: AppTextStyle.medium.copyWith(color: AppColors.primaryColor,fontSize: 15,fontWeight: FontWeight.w500)),

                        ],
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   child: Form(
      //     key: signup,
      //     child: ListView(
      //       controller: _scrollController,
      //       physics: MediaQuery.of(context).viewInsets.bottom > 0 ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
      //       children: [
      //         SizedBox(
      //           height: Get.height / 8.5,
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Image.asset(
      //               ImagePath.appIcon,
      //               height: 80,
      //             ),
      //             const SizedBox(width: 10),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text("GpsTracker",
      //                     style: AppTextStyle.regular.copyWith(
      //                         fontWeight: FontWeight.w700,
      //                         color: AppColors.primaryColor,
      //                         fontSize: 22)),
      //                 Text("We Track You",
      //                     style: AppTextStyle.regular.copyWith(
      //                         fontWeight: FontWeight.w600,
      //                         color: AppColors.blackColor,
      //                         fontSize: 18)),
      //               ],
      //             ),
      //           ],
      //         ),
      //         const SizedBox(
      //           height: 40,
      //         ),
      //         Container(
      //           height: MediaQuery.of(context).viewInsets.bottom > 0 ? MediaQuery.of(context).size.height / 2 : MediaQuery.of(context).size.height,
      //           // margin: EdgeInsets.symmetric(horizontal: 8),
      //           color: AppColors.grey,
      //           child: Padding(
      //             padding: const EdgeInsets.only(left: 20, right: 20),
      //             child: SingleChildScrollView(
      //               physics: NeverScrollableScrollPhysics(),
      //               child: Column(
      //                 children: [
      //                   const SizedBox(
      //                     height: 20,
      //                   ),
      //                   Text("Signup",
      //                       style: AppTextStyle.regular.copyWith(
      //                           fontWeight: FontWeight.w700,
      //                           color: AppColors.primaryColor,
      //                           fontSize: 22)),
      //                   const SizedBox(
      //                     height: 20,
      //                   ),
      //                   Container(
      //                       child: textView(
      //                         context: context,
      //                         //controller: authController.name,
      //                         hintText: "FirstName",
      //                         controller: authcontroller.firstname,
      //                         needValidation: true,
      //                         validationMessage: "FirstName",
      //                         titleName: '',
      //                       )),
      //                   const SizedBox(
      //                     height: 10,
      //                   ), Container(
      //                       child: textView(
      //                         context: context,
      //                         //controller: authController.name,
      //                         hintText: "Lastname",
      //                         controller: authcontroller.lastname,
      //                         needValidation: true,
      //                         validationMessage: "Lastname",
      //                         titleName: '',
      //                       )),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   Container(
      //                       child: textView(
      //                         context: context,
      //                         //controller: authController.name,
      //                         hintText: "Email",
      //                         needValidation: true,
      //                         controller: authcontroller.email,
      //                         validationMessage: "Email",
      //                         titleName: '',
      //                       )),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   Container(
      //                       child: textView(
      //                         context: context,
      //                         //controller: authController.name,
      //                         hintText: "mobile",
      //                         textInputType: TextInputType.number,
      //                         needValidation: true,
      //                         controller: authcontroller.phone,
      //                         validationMessage: "mobile",
      //                         titleName: '',
      //                       )),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   textView(
      //                       context: context,
      //                       hintText: "Password",
      //                       controller: authcontroller.password,
      //                       suffixIcon: isObscureText ? Icons.visibility_off : Icons.visibility,
      //                       suffixIconOnPress: () {
      //                         setState(() {
      //                           isObscureText = !isObscureText;
      //                         });
      //                       },
      //                       needValidation: true,
      //                       onFieldSubmitted: (v) {
      //                         if (signup.currentState!.validate()) {
      //                           FocusScope.of(context).unfocus();
      //                           authcontroller.signUp();
      //                         }
      //                       },
      //                       //controller: authController.password,
      //                       isPasswordValidator: true,
      //                       obscureText: isObscureText,
      //                       validationMessage: "Password",
      //                       color: AppColors.greyColor,
      //                       titleName: '',
      //                   ),
      //
      //                   const SizedBox(height: 30),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       buttonView(
      //                           onTap: () {
      //                             if (signup.currentState!.validate()) {
      //                               FocusScope.of(context).unfocus();
      //                               authcontroller.signUp();
      //
      //                             }
      //                           },
      //
      //                           height: 40,
      //                           borderRadius: 5,
      //                           buttonColor: AppColors.primaryColor,
      //                           borderColor: AppColors.primaryColor,
      //                           titleColor: AppColors.whiteColor,
      //                           context: context,
      //                           title: "SignUp"
      //                       ),
      //                     ],
      //                   ),
      //                   SizedBox(height: 30,),
      //                   InkWell(
      //                     onTap: (){
      //                       Get.to(LogInScreen(),transition: Transition.leftToRightWithFade,);
      //                     },
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         Text("Already have an account?",style: AppTextStyle.medium.copyWith(fontSize: 16)),
      //                         Text("Log In",style: AppTextStyle.medium.copyWith(color: AppColors.primaryColor,fontSize: 16)),
      //
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

}

