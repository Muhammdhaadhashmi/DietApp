import 'package:diet/AuthenticationModule/Views/sign_in_view.dart';
import 'package:diet/Utils/spaces.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';
import '../Utils/btn.dart';
import '../Utils/dimensions.dart';
import '../Utils/text_edit_field.dart';

class Resetscreen extends StatefulWidget {
  @override
  State<Resetscreen> createState() => _ResetscreenState();
}

class _ResetscreenState extends State<Resetscreen> {
  TextEditingController controller=TextEditingController();
  bool emailvalidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Reset Screen",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColors.mainColor),),
          AddVerticalSpace(20),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextEditField(
              hintText: "Enter Your Email",
              cursorColor: AppColors.mainColor,
              textCapitalization: TextCapitalization.none,
              preffixIcon: Icon(Icons.email_outlined,color: AppColors.mainColor,),
              textEditingController: controller,
              errorText: emailvalidate ? "Email Requried" : null,
              width: Dimensions.screenWidth(context),
            ),
          ),
          AddVerticalSpace(10),
          BTN(
            width: Dimensions.screenWidth(context) - 100,
            title: "ForgotPassword",
            textColor: AppColors.white,
            color: AppColors.mainColor,
            fontSize: 15,
            onPressed: () async {
              await FirebaseAuth.instance.sendPasswordResetEmail(
                  email: controller.text).then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInView()));
              },
              );}
    ),
        ],
      ),
    );
  }
}