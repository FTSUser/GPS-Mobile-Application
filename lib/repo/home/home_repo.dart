//
// import 'dart:convert';
//
// import '../../config/config/api_endpoints.dart';
// import '../../utils/handler/http_handler/network_http.dart';
// import '../../utils/shared_pref/shared_preferences_service.dart';
// import '../../widget/loading_dialog.dart';
//
// class HomeRepository {
//   static Future getuserInfo() async {
//     print("Get all user Api Called ===============");
//
//     //showLoadingDialog();
//     Map response = await HttpHandler.getHttpMethod(url: APIEndpoints.getUser);
//     if (response["error"] == null) {
//       print("Get all user Api Called  Sucessfully ===============");
//     //  hideLoadingDialog();
//       return jsonDecode(response['body']);
//     } else if (response["error"] != null) {
//       print("Get all user Api HAvin Error ===============");
//      // hideLoadingDialog();
//       return null;
//     } else {
//       print("Having Non Describing  Error");
//      // hideLoadingDialog();
//       return null;
//     }
//   }
//
// }


     import 'dart:convert';

import 'package:gps_tracker/widget/snackbar_view.dart';

import '../../config/config/api_endpoints.dart';
import '../../utils/handler/http_handler/network_http.dart';
import '../../widget/loading_dialog.dart';
class HomeRepository{
    static Future OnAndoffLocation() async {
        showLoadingDialog();
        var response = await HttpHandler.putHttpMethod(url: APIEndpoints.onOffloction,);
        print("Res == $response");
        if (response["error"] == null) {
            print("OnOff Location Api Called Sucessfully ");
            hideLoadingDialog();
            return jsonDecode(response['body']);
        } else if (response["error"] != null) {
            print("OnOff Location Api Having Error ");
            hideLoadingDialog();
            var objData = jsonDecode(response['body']);
            snackbarView(title: "Error", message: "Something Went Wrong", isError: true);
            return objData;
        }else{
            print("OnOff Location Api Undefined  Error ");
            hideLoadingDialog();
            snackbarView(title: "Error", message: "Error", isError: true);
            return null;
        }
    }

    static Future GetLocationInfo()async{
        // showLoadingDialog();
        var response = await HttpHandler.getHttpMethod(url:APIEndpoints.getUsersInfo);
        if(response["error"] == null){
            return  jsonDecode(response['body']);
        }else if (response["error"] != null) {
            // hideLoadingDialog();
            var objData = jsonDecode(response['body']);
            return objData;
        }else{
            // hideLoadingDialog();
            return null;
        }

    }


}


