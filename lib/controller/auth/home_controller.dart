import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_tracker/config/config/api_endpoints.dart';
import 'package:gps_tracker/config/config/pref_string.dart';
import 'package:gps_tracker/repo/auth/auth_repository.dart';
import 'package:gps_tracker/repo/home/home_repo.dart';
import 'package:gps_tracker/utils/shared_pref/shared_preferences_service.dart';

import '../../model/getuser_model.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

class HomeController extends GetxController {
  Rx<Getusermodel> userData = Getusermodel().obs;

  RxList admindata = [].obs;


  //RxList getalluserData = [].obs;
  //RxList userMaker = List<dynamic>.empty().obs;
  RxSet<Marker> marker = <Marker>{}.obs;
  RxList<dynamic> userMaker = <dynamic>[].obs;
  io.Socket? socket;

  locationSocket() async {
    // var token;
    // var adminToken;'

    var commontoken = await getDataFromLocalStorage(
        dataType: PrefString.stringType, prefKey: PrefString.commonToken);
    print("Common Token  ================%%%%%%%%%% value == $commontoken");
    print("Calling");
    var usertype = await getDataFromLocalStorage(
        dataType: PrefString.stringType, prefKey: PrefString.userType);

    // if(usertype == "Admin"){
    //   print("User Is Admin ");
    //   isAdmin.value = true;
    //  adminToken = await getDataFromLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.adminToken);
    //  print("Adimn TOken    ===== $adminToken");
    // }else{
    //   print("User is Not Admin");
    //   isAdmin.value = false;
    //   token = await getDataFromLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.token);
    //   print("User TOken    ===== $token");
    // }

    // print("admin token ===== $adminToken");
    // print("User Token ======= $token");

    print("extraHeaders:{ token:$commontoken }");

    socket = io.io(APIEndpoints.socketBaseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      "extraHeaders": {"token": commontoken}
    });

    // if(usertype == "Admin"){
    //   socket = io.io(APIEndpoints.socketBaseUrl, <String, dynamic>{
    //     'transports': ['websocket'],
    //     'autoConnect': false,
    //     "extraHeaders":{
    //       "token":adminToken,
    //     }
    //   });
    // }else{
    //   socket = io.io(APIEndpoints.socketBaseUrl, <String, dynamic>{
    //     'transports': ['websocket'],
    //     'autoConnect': false,
    //     "extraHeaders":{
    //       "token":token
    //     }
    //   });
    // }

    print("Calling-------------------------------------------------------------------- ");

    if (!socket!.connected) {
      debugPrint("NOT CONNECTED TRY TO CONNECT");
      socket!.connect();
    }
    print(
        "Calling-------------------------------------33------------------------------ ");
    socket!.emit("connection", {"token": commontoken});


    socket!.onConnectError((data) => print("Socket Error == $data"));


    socket!.on("response", (data) {
      print("Call socket check == ${socket?.connected}");
      //print("socket response  ----- $data",);
      if (usertype == "Admin") {
        print("data========= $data");
        userMaker.clear();
        userMaker.assignAll(data['data']);
        log("User Data By Admin Log in  ===== $userMaker");
      } else {
        print("admin data");
        admindata.clear();
        admindata.add(data["adminData"]);
        print("admin data By User LOg in ==== $admindata");

        //log("Admin Data By User Log in  ===== ${admindata[0]["latitude"].runtimeType}");
      }
    });
  }

  sendLatlng()async{
    print(
        "=========================Sending  location Called=========================");
    var tempData = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    socket!.emit('location',
        {
          "latitude": tempData.latitude,
          "longitude": tempData.longitude,
        });
    log("Sending latitude =${tempData.latitude}");
    log("Sending longitude =${tempData.longitude}");
  }

  OnOffLocation() async {
    print("Call @@");
    var data = await HomeRepository.OnAndoffLocation();
    if (data['success'] == true) {
      print("On Off response ======= ${data["data"]}");

      // Get.back();

    }
  }

  GetLOcationInfo() async {
    try {
      var data = await HomeRepository.GetLocationInfo();
      if (data["success"] == true) {
        if(data['adminData'] != null && data['adminData']['activeLocation'] != null){
          return data['adminData']['activeLocation'];
        }else{
        return data['data']['activeLocation'];
        }
      }else{
        return null;
      }
    } catch (e) {
      return null;
    }
  }
//activeLocation

}
