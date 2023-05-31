import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/DashboardScreen/WorkOut.dart';
import 'package:diet/DashboardScreen/remider_screen.dart';
import 'package:diet/DashboardScreen/weight_gain.dart';
import 'package:diet/Utils/get_storage.dart';
import 'package:diet/Utils/spaces.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../AuthenticationModule/Views/sign_in_view.dart';
import '../Utils/app_colors.dart';
import '../Utils/btn.dart';
import '../Utils/dimensions.dart';


class drawer extends StatefulWidget {

  // UserProvider userProvider;
  // drawer({required this.userProvider});
  // final String title;

  // profilescreen({Key? key, required this.title}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColors.mainColor),
            accountName: Text("${GetStoreData.getName()}"),
            accountEmail: Text("${GetStoreData.getEmail()}"),
            currentAccountPicture:SizedBox()
          ),
          ListTile(
            leading: Icon(Icons.update), title: Text("Update"),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UpdateScreen()));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.settings), title: Text("Settings"),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.notification_add), title: Text("Reminder"),
            onTap: () {
              Get.to(ReminderScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.logout), title: Text("Logout"),
            onTap: ()async{
              await FirebaseAuth.instance.signOut().then((value) =>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInView())));
              // if(FirebaseAuth.instance.currentUser == null&&GetStoreData.getEmail()==null) {
              //   Get.to(SignInView());
              //}
            },
          ),
    AddVerticalSpace(30),
    Padding(
      padding: const EdgeInsets.all(18.0),
      child: BTN(
      width: Dimensions.screenWidth(context) - 100,
      title: "Back to Workout",
      textColor: AppColors.white,
      color: AppColors.mainColor,
      fontSize: 15, onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkOut()));

      },
      ),
    ),
        ],
      ),
    );
  }
}


