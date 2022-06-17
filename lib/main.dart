import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_tracker/config/config/image_path.dart';
import 'package:gps_tracker/config/config/text_style.dart';
import 'package:gps_tracker/screens/splash/splash_screen.dart';
import 'package:gps_tracker/widget/custom_button.dart';
import 'package:gps_tracker/widget/snackbar_view.dart';
import 'package:permission_handler/permission_handler.dart';

import 'config/config/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
  //   runApp(MyApp());
  // });
  setAppOrientationVertical();
  runApp(const MyApp());
}
void setAppOrientationVertical(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_UpdateConnectionState);
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    takepermission();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'GpsTracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        fontFamily: 'PtSans',
        primarySwatch: const MaterialColor(
          0xff625FFD,
          <int, Color>{
            50: Color(0xff625FFD),
            100: Color(0xff625FFD),
            200: Color(0xff625FFD),
            300: Color(0xff625FFD),
            400: Color(0xff625FFD),
            500: Color(0xff625FFD),
            600: Color(0xff625FFD),
            700: Color(0xff625FFD),
            800: Color(0xff625FFD),
            900: Color(0xff625FFD),
          },
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
      ),
      // home: const SplashScreen(),
      home: SplashScreen(),
    );
  }

  // Future<String> checkPermissions() async {
  //   PermissionStatus whenInUse = await Permission.locationWhenInUse.status;
  //   if (whenInUse == PermissionStatus.granted) return "when_in_use";
  //
  //   PermissionStatus always = await Permission.locationAlways.status;
  //   if (always == PermissionStatus.granted) return "always";
  // }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  takepermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      print("permision is not enabled ");
    } else {
      print("permision is not enabled ");
    }
    var status = await Permission.location.status;
    if (status.isGranted) {
      print("Lcation Permission Is Grnted ");
    } else if (status.isDenied) {
      print("Lcation Permission Is Denied ");
    }
    Map<Permission, PermissionStatus> _status = await [
      Permission.location,
    ].request();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on
    PlatformException {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _UpdateConnectionState(result);
  }

  Future<void> _UpdateConnectionState(
    ConnectivityResult result,
  ) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      showStatus(
        result,
        true,
      );
    } else {
      showStatus(
        result,
        false,
      );
    }
  }

  void showStatus(
    ConnectivityResult result,
    bool status,
  ) {
    status == true
        ? Get.back()
        : Future.delayed(
            Duration.zero,
            () => Get.dialog(
              Material(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                color: AppColors.transparent,
                child: WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: Center(
                    child: Container(
                     height:Get.height/2.6,
                      width: Get.width,
                      margin: const EdgeInsets.all(16,),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12,),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No Connection",style: AppTextStyle.bold,).paddingOnly(top: 8),
                          Image.asset(ImagePath.noInternateIcon,height: 200,width: 200,),
                          Container(
                            height: 25,
                            width: 25,
                            margin: EdgeInsets.only(bottom: 20),
                            child: CircularProgressIndicator(),
                          )
                          // Container(
                          //   margin: EdgeInsets.symmetric(horizontal: 16),
                          //   child: buttonView(
                          //     height: 40,
                          //     borderColor: AppColors.primaryColor,
                          //     context: context,
                          //     titleColor: AppColors.whiteColor,
                          //     buttonColor: AppColors.primaryColor,
                          //     title: "Retry",
                          //     onTap: () {
                          //       status == true ? Get.back() : snackbarView(
                          //           isError: true,
                          //           title: "GPS TRACKER",
                          //           message: "No network connection!",
                          //         isSuccess: status,
                          //       );
                          //       ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
                          //     },
                          //   ).paddingOnly(top: 20)
                          // ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

}
