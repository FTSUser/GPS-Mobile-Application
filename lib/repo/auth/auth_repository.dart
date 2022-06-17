import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../config/config/api_endpoints.dart';
import '../../screens/auth/login_screen.dart';
import '../../utils/handler/http_handler/network_http.dart';
import '../../widget/loading_dialog.dart';
import '../../widget/snackbar_view.dart';

class AuthRepository {
  static Future login({
    String? password,
    String? email,
  }) async {
    showLoadingDialog();
    Map response =
        await HttpHandler.postHttpMethod(url: APIEndpoints.login, data: {
          "email": "$email", "password": "$password"
        });
    if (response["error"] == null) {
      hideLoadingDialog();
      return jsonDecode(response['body']);
    } else if (response["error"] != null) {
      hideLoadingDialog();
      var objData = jsonDecode(response['body']);
      snackbarView(title: "Error", message: "User doesn't exist", isError: true);
      return objData;
    } else {
      hideLoadingDialog();
      snackbarView(title: "Error", message: "User doesn't exist", isError: true);
      return null;
    }
  }
  static Future SignUp({
    String? firstname,
    String? lastnane,
    String? password,
    String? email,
    String? mobile,

  }) async {
    showLoadingDialog();
    print("=========================start location=========================");
    var tempData = await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high);

    print("========================latitude =${tempData.latitude}");
    print("========================logtiude =${tempData.longitude}");
    print("=========================send location=========================");
    Map response =
        await HttpHandler.postHttpMethod(url: APIEndpoints.signup, data: {
          //"userName": "$name", "password": "$password"
          "firstName": "$firstname",
          "lastName":"$lastnane",
          "email": "$email",
          "password": "$password",
          "mobile": "$mobile",
          "latitude":tempData.latitude,
          "longitude":tempData.longitude,
        });
    if (response["error"] == null) {
      hideLoadingDialog();
      return jsonDecode(response['body']);
    } else if (response["error"] != null) {
      hideLoadingDialog();
      print("erroe data${jsonDecode(response['body'])}");
      // var objData = jsonDecode(response['body']);
      snackbarView(title: "Error", message: "${jsonDecode(response['body'])["message"]}", isError: true);
       return jsonDecode(response['body']);
    } else {
      hideLoadingDialog();
      print("erroe data${jsonDecode(response['body'])}");
      snackbarView(title: "Error", message: "Error", isError: true);
      return {};
    }

  }

  static Future getUser({bool isLoader = true}) async {
    print("Get User Api Called  ");
   // if (isLoader) showLoadingDialog();
    //var userId = await getDataFromLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.userId);
    Map response = await HttpHandler.getHttpMethod(url: APIEndpoints.getUser);
    if (response["error"] == null) {
      print("Get User Api Called Sucessfully ");
     // if (isLoader) hideLoadingDialog(istrue: true);
      return jsonDecode(response['body']);
    } else if (response["error"] != null) {
      print("Get User Api Called Having Error ");
     // if (isLoader) hideLoadingDialog(istrue: true);
      if (response['error'].toString() == "401") {
        print("Get User Api Called Having 401 Error ");
      //  Get.offAll(()=> const LogInScreen());
      }
      return null;
    } else {
      print("Get User Api Called Having Undefined  Error ");
     // if (isLoader) hideLoadingDialog(istrue: true);
      return null;
    }
  }




  //
  // static Future UpdateLocation({double? lat, double?long,}) async {
  //
  //   //showLoadingDialog();
  //   var response = await HttpHandler.putHttpMethod(url:  APIEndpoints.updatelocation,
  //   data:{
  //     "latitude": lat,
  //     "longitude": long,
  //   });
  //   if (response["error"] == null) {
  //     print("update Location Api Called Sucessfully ");
  //    // hideLoadingDialog();
  //     return jsonDecode(response['body']);;
  //   } else if (response["error"] != null) {
  //     print("update Location Api Having Error ");
  //    // hideLoadingDialog();
  //     var objData = jsonDecode(response['body']);
  //     snackbarView(title: "Error", message: "Something Went Wrong", isError: true);
  //     return objData;
  //   } else {
  //     print("update Location Api Undefined  Error ");
  //     //hideLoadingDialog();
  //     snackbarView(title: "Error", message: "Error", isError: true);
  //     return null;
  //   }
  //
  //
  // }
// static Future UpdateUserLocation({double? lat, double?long,}) async {
//     showLoadingDialog();
//     var response = await HttpHandler.putHttpMethod(url:  APIEndpoints.updatelocation,
//     data:{
//       "latitude": lat,
//       "longitude": long,
//     });
//     if (response["error"] == null) {
//       hideLoadingDialog();
//       return jsonDecode(response['body']);
//     } else if (response["error"] != null) {
//       hideLoadingDialog();
//       var objData = jsonDecode(response['body']);
//       snackbarView(title: "Error", message: "Something Went Wrong", isError: true);
//       return objData;
//     } else {
//       hideLoadingDialog();
//       snackbarView(title: "Error", message: "Error", isError: true);
//       return null;
//     }
//
//
//   }



}
