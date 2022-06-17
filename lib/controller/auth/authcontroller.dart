
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gps_tracker/screens/homepage/home_screen.dart';
import 'package:gps_tracker/widget/loading_dialog.dart';
import '../../config/config/pref_string.dart';
import '../../repo/auth/auth_repository.dart';
import '../../utils/shared_pref/shared_preferences_service.dart';
import '../../widget/snackbar_view.dart';


class AuthController extends GetxController {

  final email = TextEditingController();
  final password = TextEditingController();
  final signupPassword = TextEditingController();
  final signupEmail = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final phone = TextEditingController();
  final mobile = TextEditingController();




  signUp() async {
    var response = await AuthRepository.SignUp(
        email: signupEmail.text,
        password: signupPassword.text,
        firstname: firstname.text,
        lastnane: lastname.text,
        mobile: phone.text,

    );
    print("Response of signup ========== $response");
    if(response == null){
      snackbarView(
          title: "SignUp", message: response["message"], isSuccess: true);
    } else if (response['success'] == true) {
      setDataToLocalStorage(
          dataType: PrefString.stringType,
          prefKey: PrefString.userId,
          stringData: response['data']['id']);
      setDataToLocalStorage(dataType:PrefString.stringType , prefKey:PrefString.commonToken,stringData:response['data']['token'] );
      var uid = await getDataFromLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.userId);
      print("User Id ====== $uid");
      Get.offAll(() => HomeScreen());
      snackbarView(
          title: "SignUp", message: "SignUp successfully", isSuccess: true);
    }else{

    }
  }

  signIn() async {
    // admin credential
    // email: admin@gps.tracker,
    // mobile: 9988776655
    // password: Gpsadmin@9999
    var response = await AuthRepository.login(
        email: email.text, password: password.text);
    if (response['success'] == true) {
      setDataToLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.userType, stringData: response['data']['userType']);
      var userType = await getDataFromLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.userType);
      print("User Type =======  $userType");
      setDataToLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.commonToken, stringData: response['data']['token']);
      var commonToken = await getDataFromLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.commonToken);
      print("Common token ====== $commonToken");
      // if (userType == "Admin") {
      //   print("Admin Loged In ");
      //   setDataToLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.adminToken, stringData: response['data']['token']);
      //   var admintoken = await getDataFromLocalStorage(
      //       dataType: PrefString.stringType, prefKey: PrefString.adminToken);
      //   print("Admin TOken ============ $admintoken");
      // } else {
      //   setDataToLocalStorage(dataType: PrefString.stringType,
      //       prefKey: PrefString.token,
      //       stringData: response['data']['token']);
      //   var token = await getDataFromLocalStorage(
      //       dataType: PrefString.stringType, prefKey: PrefString.token);
      //   print("TOken ============ $token");
      // }
      setDataToLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.userId, stringData: response['data']['id']);
      var uid = await getDataFromLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.userId);
      print("User Id ====== $uid");
      if (userType == "User") {
        Get.offAll(() => HomeScreen());
        snackbarView(
            title: "LogIn", message: "LogIn  successfully", isSuccess: true);
      }else{
        Get.offAll(() => HomeScreen());
        snackbarView(
            title: "LogIn", message: "LogIn  successfully", isSuccess: true);
      }
    }


    // Future<bool> updateUserData() async {
    //   var data = await AuthRepository.updateIsTenete(
    //       email: email.text,
    //       tenetUserName: name.text,
    //       phone: phone.text,
    //       isTenete: selectIndex.value == 0 ? true : false);
    //
    //   if (data['result'] == 0) {
    //     Get.back();
    //     await setDataToLocalStorage(dataType: PrefString.boolType, prefKey: PrefString.isView, boolData: true);
    //     return true;
    //   }
    //   return false;
    // }

  }
}
