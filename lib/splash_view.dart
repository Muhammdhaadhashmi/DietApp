import 'dart:async';
import 'package:diet/DashboardScreen/WorkOut.dart';
import 'package:diet/Utils/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'AuthenticationModule/Views/sign_in_view.dart';
import 'Utils/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), () {
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInView()));
      if (FirebaseAuth.instance.currentUser == null&&GetStoreData.getEmail()!=null) {
        Get.offAll(SignInView());
      } else {
        Get.offAll(WorkOut());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          "assets/logo.png",
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
