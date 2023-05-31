import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/AuthenticationModule/Views/sign_in_view.dart';
import 'package:diet/DashboardScreen/start_excersie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Utils/app_colors.dart';
import '../../../Utils/btn.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/spaces.dart';
import '../../../Utils/text_edit_field.dart';
import '../../../Utils/text_view.dart';
import '../../../Utils/toast.dart';
import '../../Utils/get_storage.dart';

enum Gender { Male, Female }

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool isChecked = false;
  bool namevalidate = false;
  bool emailvalidate = false;
  bool imgvalidate = false;

  bool expvalidate = false;
  bool phonevalidate = false;
  bool skilllvalidate = false;
  bool passvalidate = false;
  bool passValid = false;
  bool priceValid = false;
  bool emailValid = false;
  final email = TextEditingController();
  final name = TextEditingController();

  bool agevalidate = false;
  bool heightvalidate = false;
  bool weightvalidate = false;
  final TextEditingController age = new TextEditingController();
  final TextEditingController height = new TextEditingController();
  final TextEditingController weight = new TextEditingController();

  final password = TextEditingController();
  final phone = TextEditingController();

  // late UserCredential authResult;
  // final FirebaseFirestore _firestore =FirebaseFirestore.instance;

  Gender? gender = Gender.Male;

  // bool isMale=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInView()));
        //       }, onPressed: (){
        //         //         FirebaseAuth.instance.signOut();
        //         //         // GetStoreData.storeE
        //         //         // mail(email: null);
        //         //          icon: Icon(Icons.logout))
        // ],
        title: TextView(text: "Create Account"),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: Dimensions.screenHeight(context),
        width: Dimensions.screenWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AddVerticalSpace(50),
              TextEditField(
                hintText: "Username",
                cursorColor: AppColors.mainColor,
                textCapitalization: TextCapitalization.none,
                preffixIcon: Icon(Icons.person_outline_outlined,
                    color: AppColors.mainColor),
                textEditingController: name,
                errorText: namevalidate ? "Username Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              // AddVerticalSpace(10),
              // TextEditField(
              //   hintText: "Email",
              //   textCapitalization: TextCapitalization.none,
              //   preffixIcon: Icon(Icons.email_outlined),
              //   textEditingController: email,
              //   errorText: emailvalidate ? "Email Requried" : null,
              //   width: Dimensions.screenWidth(context),
              // ),
              AddVerticalSpace(20),
              TextEditField(
                hintText: "Email",
                cursorColor: AppColors.mainColor,
                textCapitalization: TextCapitalization.none,
                preffixIcon: Icon(Icons.email_outlined,color: AppColors.mainColor,),
                textEditingController: email,
                errorText: emailvalidate ? "Email Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.phone,
                hintText: "PhoneNo",
                maxLength: 11,
                cursorColor: AppColors.mainColor,
                textCapitalization: TextCapitalization.none,
                preffixIcon: Icon(Icons.phone, color: AppColors.mainColor),
                textEditingController: phone,

                errorText: phonevalidate ? "Phone Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),

              TextEditField(
                hintText: "Password",
                cursorColor: AppColors.mainColor,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                    Icon(Icons.lock_outline, color: AppColors.mainColor),
                textEditingController: password,
                errorText: passvalidate ? "Password Requried" : null,
                width: Dimensions.screenWidth(context),
                isPassword: true,
              ),
              SizedBox(
                height: 8,
              ),
              Center(
                child: Text(
                  "Select Gender",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: const Text('Male'),
                    leading: Radio<Gender>(
                      value: Gender.Male,
                      groupValue: gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Female'),
                    leading: Radio<Gender>(
                      value: Gender.Female,
                      groupValue: gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Center(
                child: Text(
                  "BMI Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              // AddVerticalSpace(7),
              TextEditField(
                hintText: "Age",
                maxLength: 2,
                inputType: TextInputType.number,
                cursorColor: AppColors.mainColor,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                    Icon(Icons.calendar_month, color: AppColors.mainColor),
                textEditingController: age,
                errorText: agevalidate ? "Age Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              SizedBox(
                height: 8,
              ),
              TextEditField(
                hintText: "Height",
                maxLength: 3,
                inputType: TextInputType.number,
                cursorColor: AppColors.mainColor,
                textCapitalization: TextCapitalization.none,
                preffixIcon: Icon(Icons.height, color: AppColors.mainColor),
                textEditingController: height,
                errorText: heightvalidate ? "Height Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              SizedBox(
                height: 8,
              ),
              TextEditField(
                hintText: "Weight",
                maxLength: 3,
                inputType: TextInputType.number,
                cursorColor: AppColors.mainColor,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                    Icon(Icons.monitor_weight, color: AppColors.mainColor),
                textEditingController: weight,
                errorText: weightvalidate ? "Weight Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AddHorizontalSpace(20),
                  Checkbox(
                    activeColor: AppColors.mainColor,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  TextView(
                    text: "I accept all the Terms & Conditions",
                  ),
                  // AddHorizontalSpace(20)
                ],
              ),
              AddVerticalSpace(10),
              BTN(
                width: Dimensions.screenWidth(context) - 100,
                title: "Sign Up",
                textColor: AppColors.white,
                color: AppColors.mainColor,
                fontSize: 15,
                onPressed: () async {
                  if (name.text.isEmpty) {
                    setState(() {
                      namevalidate = true;
                    });
                  } else if (email.text.isEmpty) {
                    setState(() {
                      emailvalidate = true;
                    });
                  }
                  else if (phone.text.length!=11) {
                    Fluttertoast.showToast(
                        msg: 'Mobile Number must be of 11 digit',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColors.mainColor,
                        textColor: Colors.white,
                        fontSize: 10.0);
                    setState(() {
                      phonevalidate=true;
                    });
                    // return 'Mobile Number must be of 11 digit';
                  } else if (password.text.isEmpty) {
                    setState(() {
                      passvalidate = true;
                    });
                  }
                  else if (int.parse(age.text)<15 || int.parse(age.text)>75) {
                    Fluttertoast.showToast(
                        msg: 'Age must be greater than 15 and less than 75',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColors.mainColor,
                        textColor: Colors.white,
                        fontSize: 10.0);
                      setState(() {
                        agevalidate = true;
                      });
                    }
                  // else if(age.text.length>70){
                  //   Fluttertoast.showToast(
                  //       msg: 'Age must be less than 70',
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.CENTER,
                  //       timeInSecForIosWeb: 1,
                  //       backgroundColor: AppColors.mainColor,
                  //       textColor: Colors.white,
                  //       fontSize: 10.0);
                  // }
                  else if (double.parse(height.text)<3 || double.parse(height.text)>10) {
                    Fluttertoast.showToast(
                        msg: 'Height must be between 3 to 10',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColors.mainColor,
                        textColor: Colors.white,
                        fontSize: 10.0);
                    setState(() {
                      agevalidate = true;
                    });
                    setState(() {
                      heightvalidate = true;
                    });
                  } else if (weight.text.isEmpty) {
                    setState(() {
                      weightvalidate = true;
                    });
                  } else if (isChecked == false) {
                    FlutterSimpleToast(msg: "Agree to Terms & Conditions");
                  } else {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      )
                          .then((value) async {
                        // Get.to(gender_selection());
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        FlutterErrorToast(
                          error: 'The password provided is too weak.',
                        );
                      } else if (e.code == 'email-already-in-use') {
                        FlutterErrorToast(
                            error:
                                "The account already exists for this email.");
                      };
                    }
                    double w = double.parse(weight.text);
                    if (w>30 && w <200) {
                      await FirebaseFirestore.instance
                          .collection("UsersData")
                          .doc(email.text)
                          .set({
                        "Name": name.text,
                        "Email": email.text,
                        "Password": password.text,
                        "PhoneNumber": phone.text,
                        "Age": age.text,
                        "Height": height.text,
                        "Weight": weight.text,
                        "Gender": gender == Gender.Male ? "Male" : "Female",
                        "bmivalue": CalculateBMI(double.parse(height.text) * 0.3048, double.parse(weight.text)),});

                      setState(() {
                        weightvalidate=true;

                      });
                         GetStoreData.storeEmail(email: email.text);
                      // GetStoreData.storeEmail(email: null);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => start_excersie(
                                    email: email.text,
                                  )));


                    }
                    else {
                      Fluttertoast.showToast(
                          msg:
                              'Weight must be greater than 30 and less 200',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.mainColor,
                          textColor: Colors.white,
                          fontSize: 10.0);
                    }
                  }
                },
              ),
              AddVerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(text: "Already have an account?"),
                  AddHorizontalSpace(5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInView()));
                      // Get.back();
                    },
                    child: TextView(
                      text: "Sign In",
                      color: AppColors.mainColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              AddVerticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }

  double CalculateBMI(height, weight) {
    // double heightSquare=height*0.3048;
    double result = weight / (height * height);
    return result;
  }
}
