import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_tracker/config/config/colors.dart';
import 'package:gps_tracker/config/config/pref_string.dart';
import 'package:gps_tracker/controller/auth/home_controller.dart';
import 'package:gps_tracker/screens/auth/login_screen.dart';
import 'package:gps_tracker/utils/shared_pref/shared_preferences_service.dart';

class ShareLocationScreen extends StatefulWidget {
  const ShareLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShareLocationScreen> createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  final homecontroller = Get.put(HomeController());

  bool? loc;

  String? type;

  @override
  void initState() {
    loc = null;
    super.initState();
    getuselocationinfo();
  }

  @override
  Widget build(BuildContext context) {
    print("Type LOC == $loc");
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
              )),
          title: Text("Settings"),
        ),
        body: loc == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  ListTile(
                    title: type == "Admin"
                        ? Text("Show your Location to User")
                        : Text("Show your Location to Admin"),
                    trailing: Switch(
                      activeColor: AppColors.primaryColor,
                      value: loc!,
                      onChanged: (value) async {
                        // loc =! loc;
                        loc = value;
                        await homecontroller.OnOffLocation();
                        setState(() {});
                        // print("Location Varible ==== $loc");
                        // setDataToLocalStorage(dataType: PrefString.boolType, prefKey: PrefString.shareLocation,boolData:loc);
                        // setState(() {});
                      },
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      Get.dialog(
                        AlertDialog(
                          content: Container(
                            height: 90,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Do you want to Logout?"),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print('yes selected');
                                          clearLocalStorage();
                                          Get.offAll(() => LogInScreen());
                                        },
                                        child: Text("Yes"),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red.shade800),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        print('no selected');
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("No",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    title: Text("Log out"),
                    trailing: Icon(Icons.logout),
                  )
                ],
              ));
  }



  getuselocationinfo()async{
    loc = null;
    type = await getDataFromLocalStorage(
        dataType: PrefString.stringType, prefKey: PrefString.userType);
    loc = await homecontroller.GetLOcationInfo();
    print("Loc  == $loc");
    if (loc == null) {
      Get.snackbar("Error", "Something went wrong please try again");
      Navigator.of(context).pop();
    }
    setState(() {});
  }


}
