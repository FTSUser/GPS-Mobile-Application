import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_tracker/config/config/colors.dart';
import 'package:gps_tracker/config/config/image_path.dart';
import 'package:gps_tracker/config/config/pref_string.dart';
import 'package:gps_tracker/screens/homepage/share_location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/config/text_style.dart';
import '../../controller/auth/home_controller.dart';
import '../../utils/shared_pref/shared_preferences_service.dart';
import '../auth/login_screen.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

class HomeScreen extends StatefulWidget {

  const HomeScreen({
    Key? key,
  }) : super(key: key,);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final homeController = Get.put(HomeController());
  Timer? timer;

  LatLng? currentPostion;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  Position? position;
  var usertype;
  getUserMaker() async {
    homeController.marker.clear();
    for (int i = 0; i < homeController.userMaker.length; i++) {
      debugPrint("email ${homeController.userMaker[i]["email"]}");
      debugPrint("Receiving LAT of Get All User ${homeController.userMaker[i]["latitude"]}");
      debugPrint("Receiving LONG of Get All User ${homeController.userMaker[i]["longitude"]}");
      if(homeController.userMaker[i]["latitude"] != null && homeController.userMaker[i]["longitude"] != null){
        homeController.marker.add(Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            //await getMarkerIcon(ImagePath.profileView, Size(150.0, 150.0)),
            //for photo view marker
            //await getMarkerIcon(ImagePath.profileView, Size(150.0, 150.0)),
            zIndex: 99,
            onTap: () {},
            position:LatLng(homeController.userMaker[i]["latitude"],
                homeController.userMaker[i]["longitude"]),
            infoWindow: InfoWindow(title:
            "${homeController.userMaker[i]["firstName"]} ${homeController.userMaker[i]["lastName"]}",
                snippet:"${homeController.userMaker[i]["email"]}"
            ),
        ));
      }

    }
      setState(() {});
  }

  getAdminMaker() {
    homeController.marker.clear();
    for (int i = 0; i < homeController.admindata.length ; i++) {
      print("Checking == ${homeController.admindata[i]}");

        if(homeController.admindata[i] != null && homeController.admindata[i]["activeLocation"] == true &&homeController.admindata[i]["latitude"] != null && homeController.admindata[i]["longitude"] != null){
          // print("Receiving Lat  of Admin by user log in ===== ${homeController.admindata[i]["latitude"]}");
          // print("Receiving long of Admin by user log in ===== ${homeController.admindata[i]["longitude"]}");
         homeController.marker.add(Marker(
             markerId: MarkerId(i.toString()),
             icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
             zIndex: 99,
             onTap: () {},

             position: LatLng(homeController.admindata[i]["latitude"],homeController.admindata[i]["longitude"]),
             infoWindow:  const InfoWindow(title: "Admin",snippet: "admin@gps.tracker")
         ));
       }

    }
      setState(() {});
  }

  final _controller = Completer();
  static const CameraPosition _MyLOcation = CameraPosition(
    target: LatLng(21.2386817, 72.879405),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  // static final Marker _adminmark = Marker(
  //     markerId: MarkerId("adminmark"),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //     zIndex: 99,
  //     onTap: () {},
  //     position: LatLng(21.2403372,72.8869927),
  //   infoWindow: InfoWindow(title: "Admin Marker"),
  // );
  var locationShare;

setData()async{
  locationShare = await getDataFromLocalStorage(dataType: PrefString.boolType, prefKey:PrefString.shareLocation);
  print("Share location Home Screen ====== $locationShare}");
}
  @override
  void initState() {
    setData();
    homeController.locationSocket();
    homeController.sendLatlng();
    streamlocation();
    timer = Timer.periodic( const Duration(seconds: 10), (Timer t) {
      print("Api Called Every 10 seconds");
       homeController.sendLatlng();
      //locationShare == true ? homeController.sendLatlng():print("Not Sharing Location");
       // homeController.locationSocket();
       streamlocation();
      print("Streaming location in Map");
    });
    super.initState();
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
      // appBar: AppBar(
      //   leading:  InkWell(
      //     onTap: (){
      //       clearLocalStorage();
      //       Get.to(()=>LogInScreen());
      //     },
      //       child: Icon(Icons.clear)),
      // ),
        body: SafeArea(
          child: Stack(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  GoogleMap(
                      mapType:MapType.normal,
                      // homeController.view.value == 1
                      //     ? MapType.satellite
                      //     : homeController.view.value == 2
                      //     ? MapType.normal
                      //     : homeController.view.value == 3
                      //     ? MapType.terrain
                      //     : MapType.hybrid,
                      markers: homeController.marker,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      initialCameraPosition: _MyLOcation,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10,top: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.whiteColor
                            ),
                            height: 40,
                            width: 40,
                            child: Icon(Icons.clear,color: AppColors.primaryColor),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(()=>ShareLocationScreen())!.whenComplete(() {
                              if(locationShare == true){
                                timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
                                  print("Api Called Every 10 seconds");
                                  //homeController.locationSocket();
                                  homeController.sendLatlng();
                                  // homeController.locationSocket();
                                  streamlocation();
                                });
                              }

                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10,top: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.whiteColor
                            ),
                            height: 40,
                            width: 40,
                            child: const Icon(Icons.settings,color: AppColors.primaryColor),
                          ),
                        ),


                      ],
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.only(left: 10,top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteColor
                  ),
                  height: 40,
                  width: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: SvgPicture.asset(ImagePath.drawericon,height: 17,width: 25,color: AppColors.primaryColor,),
                  ),
                ),
              ),
            ],
          ),

        ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton.extended(
      //
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  streamlocation() async {

    usertype = await getDataFromLocalStorage(dataType: PrefString.stringType, prefKey: PrefString.userType);

    if (usertype == "Admin"){
      print("get user marker called");
       await getUserMaker();
    } else {
      print("get Admin marker called ");
      await getAdminMaker();

    }

  }


 // List<Marker>? markers; //This the list of markers is the old set of markers that were used in the onMapCreated function


// Future<ui.Image> getImageFromPath(String imagePath) async {
//   // File imageFile = File(imagePath);
//   ByteData imageData = await rootBundle.load(imagePath);
//   List<int> bytes = Uint8List.view(imageData.buffer);
//
//
//   Uint8List imageBytes = Uint8List.fromList(bytes);
//
//   final Completer<ui.Image> completer = new Completer();
//
//   ui.decodeImageFromList(imageBytes, (ui.Image img) {
//     return completer.complete(img);
//   });
//
//   return completer.future;
// }
//
//
// Future<BitmapDescriptor> getMarkerIcon(String imagePath, Size size) async {
//   final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//   final Canvas canvas = Canvas(pictureRecorder);
//
//   final Radius radius = Radius.circular(size.width / 2);
//
//   final Paint tagPaint = Paint()
//     ..color = Colors.blue;
//   final double tagWidth = 40.0;
//
//   final Paint shadowPaint = Paint()
//     ..color = Colors.blue.withAlpha(100);
//   final double shadowWidth = 15.0;
//
//   final Paint borderPaint = Paint()
//     ..color = Colors.white;
//   final double borderWidth = 3.0;
//
//   final double imageOffset = shadowWidth + borderWidth;
//
//   // Add shadow circle
//   canvas.drawRRect(
//       RRect.fromRectAndCorners(
//         Rect.fromLTWH(
//             0.0,
//             0.0,
//             size.width,
//             size.height
//         ),
//         topLeft: radius,
//         topRight: radius,
//         bottomLeft: radius,
//         bottomRight: radius,
//       ),
//       shadowPaint);
//
//   // Add border circle
//   canvas.drawRRect(
//       RRect.fromRectAndCorners(
//         Rect.fromLTWH(
//             shadowWidth,
//             shadowWidth,
//             size.width - (shadowWidth * 2),
//             size.height - (shadowWidth * 2)
//         ),
//         topLeft: radius,
//         topRight: radius,
//         bottomLeft: radius,
//         bottomRight: radius,
//       ),
//       borderPaint);
//
//   // Add tag circle
//   canvas.drawRRect(
//       RRect.fromRectAndCorners(
//         Rect.fromLTWH(
//             size.width - tagWidth,
//             0.0,
//             tagWidth,
//             tagWidth
//         ),
//         topLeft: radius,
//         topRight: radius,
//         bottomLeft: radius,
//         bottomRight: radius,
//       ),
//       tagPaint);
//
//   // Add tag text
//   TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
//   textPainter.text = TextSpan(
//     text: '1',
//     style: TextStyle(fontSize: 20.0, color: Colors.white),
//   );
//
//   textPainter.layout();
//   textPainter.paint(
//       canvas,
//       Offset(
//           size.width - tagWidth / 2 - textPainter.width / 2,
//           tagWidth / 2 - textPainter.height / 2
//       )
//   );
//
//   // Oval for the image
//   Rect oval = Rect.fromLTWH(
//       imageOffset,
//       imageOffset,
//       size.width - (imageOffset * 2),
//       size.height - (imageOffset * 2)
//   );
//
//   // Add path for oval image
//   canvas.clipPath(Path()
//     ..addOval(oval));
//
//   // Add image
//   ui.Image image = await getImageFromPath(
//       imagePath); // Alternatively use your own method to get the image
//   paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);
//
//   // Convert canvas to image
//   final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
//       size.width.toInt(),
//       size.height.toInt()
//   );
//
//   // Convert image to bytes
//   final ByteData? byteData = await markerAsImage.toByteData(
//       format: ui.ImageByteFormat.png);
//   final Uint8List uint8List = byteData!.buffer.asUint8List();
//
//   return BitmapDescriptor.fromBytes(uint8List);
// }
}


