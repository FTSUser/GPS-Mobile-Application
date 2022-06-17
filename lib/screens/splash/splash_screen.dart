import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_tracker/config/config/colors.dart';
import 'package:gps_tracker/config/config/image_path.dart';
import 'package:gps_tracker/config/config/pref_string.dart';
import 'package:gps_tracker/screens/auth/login_screen.dart';
import 'package:gps_tracker/screens/auth/signup.dart';
import 'package:gps_tracker/screens/homepage/home_screen.dart';
import 'package:gps_tracker/utils/shared_pref/shared_preferences_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  setData()async{
    var uid = await getDataFromLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.userId);
    print("uid ======= $uid");
    Timer(const Duration(seconds: 3),(){
      if(uid != null){
        Get.offAll(() =>HomeScreen());
      }else{
        Get.offAll(() =>const LogInScreen());
      }
    });

  }
  @override
  void initState() {
    setData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body:Center(
        child:Image.asset(ImagePath.appLogo,fit: BoxFit.fill,),
      ),
    );
  }
}
