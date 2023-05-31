import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/DashboardScreen/WorkOut.dart';
import 'package:diet/DashboardScreen/drawer.dart';
import 'package:diet/DashboardScreen/video%20screen.dart';
import 'package:diet/DashboardScreen/weight_loss.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../AuthenticationModule/Views/sign_up_view.dart';
import '../AuthenticationModule/get_controller.dart';
import '../Utils/app_colors.dart';
import '../Utils/btn.dart';
import '../Utils/dimensions.dart';
import '../Utils/spaces.dart';
import '../Utils/text_edit_field.dart';
import '../Utils/text_view.dart';
import 'bmicalculate.dart';
import 'diet_plan.dart';

enum Gender { Male, Female }
// enum Weight { kg }
// enum Height { inches }

class WeightGain extends StatefulWidget {
  const WeightGain({Key? key}) : super(key: key);

  @override
  State<WeightGain> createState() => _WeightGainState();
}

class _WeightGainState extends State<WeightGain> {

  GetController getcontroller=Get.put(GetController());

  int pageIndex = 0;
  List days = [];

  String? text="";


  @override
  void initState() {
    super.initState();
    Bmivalue();

  }
  Bmivalue()async{
    var snap=  await FirebaseFirestore.instance
        .collection("UsersData")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    setState(() {
      double value= (snap.data() as dynamic)["bmivalue"];
      if(value<20){
        text="Excersie for Weight Gain";
      }
      else{
        text="Excersie for Weight Loss";
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildMyNavBar(context),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: TextView(
          text:  "$text",
        ),
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("WeightGain").orderBy("name")
                  .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              days = snapshot.data!.docs;
            }
            return ListView.builder(
              itemCount: days.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if(getcontroller.completedWeightGain.value.contains(days[index]["name"])) {
                      Fluttertoast.showToast(
                          msg: 'Your this day Exercise completed',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.mainColor,
                          textColor: Colors.white,
                          fontSize: 10.0);
                    }else{
                      print("${getcontroller.completedWeightGain.value}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Exercise(
                                  day: days[index]["name"],
                                ),
                          ));

                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    height: 90,
                    width: Dimensions.screenWidth(context),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.dstATop),
                            image: AssetImage("assets/cal.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade400),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/bmi.png",
                          height: 60,
                          width: 60,
                        ),
                        Text("Day ${days[index]["name"]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 13,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkOut()));
                      pageIndex = 0;
                    });
                  },
                  child: Icon(Icons.home,size: 35,)),
              SizedBox(
                height: 5,
              ),
              Text(
                "Home",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeightGain()));
                      // pageIndex = 1;
                    });
                  },
                  child: Icon(Icons.sports_gymnastics,size: 35,)),
              SizedBox(
                height: 5,
              ),
              Text(
                "Workout",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DietPlan()));

                      pageIndex = 2;
                    });
                  },
                  child: Icon(Icons.next_plan_outlined,size: 35,)),
              SizedBox(
                height: 5,
              ),
              Text(
                "Diet Plan",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BmiCalculate()));

                      pageIndex = 2;
                    });
                  },
                  child: const Icon(Icons.calculate,size: 35,)),
              SizedBox(
                height: 5,
              ),
              Text(
                "Calculator",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => drawer()));
                    pageIndex = 3;
                  });
                },
                child: Icon(Icons.person,size: 35,),),
              SizedBox(
                height: 5,
              ),
              Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
  // Container buildMyNavBar(BuildContext context) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height / 13,
  //     decoration: BoxDecoration(
  //       color: AppColors.mainColor,
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => ExerciseDaysScreen()));
  //                     pageIndex = 0;
  //                   });
  //                 },
  //                 child: Icon(Icons.sports_gymnastics,size: 35,)),
  //             SizedBox(
  //               height: 5,
  //             ),
  //             Text(
  //               "WorkOut",
  //               style: TextStyle(color: Colors.white),
  //             )
  //           ],
  //         ),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => SignUpView()));
  //                     // pageIndex = 1;
  //                   });
  //                 },
  //                 child: Icon(Icons.home,size: 35,)),
  //             SizedBox(
  //               height: 5,
  //             ),
  //             Text(
  //               "Home",
  //               style: TextStyle(color: Colors.white),
  //             )
  //           ],
  //         ),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => Diet()));
  //                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpView()));
  //                   });
  //                 },
  //                 child: Icon(Icons.next_plan_outlined,size: 35,)),
  //             SizedBox(
  //               height: 5,
  //             ),
  //             Text(
  //               "Diet Plan",
  //               style: TextStyle(color: Colors.white),
  //             )
  //           ],
  //         ),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => UpdateScreen()));
  //                   });
  //                 },
  //                 child: Icon(Icons.person,size: 35,)),
  //             SizedBox(
  //               height: 5,
  //             ),
  //             Text(
  //               "Profile",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
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
  final phone = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool agevalidate = false;
  bool heightvalidate = false;
  bool weightvalidate = false;
  final TextEditingController age = new TextEditingController();
  final TextEditingController height = new TextEditingController();
  final TextEditingController weight = new TextEditingController();
  final TextEditingController bmi = new TextEditingController();

  // Gender? gender = Gender.Male;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection("UsersData")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      setState(() {
        name.text = (value.data() as dynamic)["Name"] ?? "";
        phone.text = (value.data() as dynamic)["PhoneNumber"] ?? "";
        email.text = (value.data() as dynamic)["Email"] ?? "";
        password.text = (value.data() as dynamic)["Password"] ?? "";
        age.text = (value.data() as dynamic)["Age"] ?? "";
        height.text = (value.data() as dynamic)["Height"] ?? "";
        weight.text = (value.data() as dynamic)["Weight"] ?? "";
        bmi.text = (value.data() as dynamic)["bmivalue"].toString();
      });
    });
  }

  updatedata() async {
    double result = CalculateBMI(double.parse(height.text)* 0.3048, double.parse(weight.text));
    double w = double.parse(weight.text);
    if(w>30 || w<200){
      var data = {
        "Name": name.text,
        "PhoneNumber": phone.text,
        "Age": age.text,
        "Height": height.text,
        "Weight": weight.text,
        "bmivalue": result
      };
      // setState(() {
      //   weightvalidate=true;
      //
      // });
      await FirebaseFirestore.instance
          .collection("UsersData")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update(data);
    }
    else {
      Fluttertoast.showToast(
          msg:
          'Weight must be less than 150 and greater than 30',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.mainColor,
          textColor: Colors.white,
          fontSize: 10.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          // alignment: Alignment.topRight,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => WorkOut()));
          },
        ),
        title: TextView(text: "Profile Screen"),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<Object>(builder: (context, snapshot) {
        return Container(
          height: Dimensions.screenHeight(context),
          width: Dimensions.screenWidth(context),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AddVerticalSpace(20),
                Center(
                  child: Text(
                    "Update Profile",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                AddVerticalSpace(50),
                TextEditField(
                  cursorColor: AppColors.mainColor,
                  hintText: "Username",
                  textCapitalization: TextCapitalization.none,
                  preffixIcon: Icon(Icons.person_outline_outlined,color: AppColors.mainColor,),
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
                  cursorColor: AppColors.mainColor,
                  hintText: "Email",
                  readOnly: true,
                  textCapitalization: TextCapitalization.none,
                  preffixIcon: Icon(Icons.email_outlined,color: AppColors.mainColor,),
                  textEditingController: email,
                  errorText: emailvalidate ? "Email Requried" : null,
                  width: Dimensions.screenWidth(context),
                ),
                AddVerticalSpace(20),
                TextEditField(
                  cursorColor: AppColors.mainColor,
                  inputType: TextInputType.phone,
                  hintText: "PhoneNo",
                  maxLength: 11,
                  textCapitalization: TextCapitalization.none,
                  preffixIcon: Icon(Icons.phone,color: AppColors.mainColor,),
                  textEditingController: phone,
                  errorText: phonevalidate ? "Phone Requried" : null,
                  width: Dimensions.screenWidth(context),
                ),
                AddVerticalSpace(20),
                TextEditField(
                  cursorColor: AppColors.mainColor,
                  readOnly: true,
                  hintText: "Password",
                  textCapitalization: TextCapitalization.none,
                  preffixIcon: Icon(Icons.lock_outline,color: AppColors.mainColor,),
                  textEditingController: password,
                  errorText: passvalidate ? "Password Requried" : null,
                  width: Dimensions.screenWidth(context),
                  isPassword: true,
                ),
                AddVerticalSpace(20),
                Center(
                  child: Text(
                    "Update BMI Details",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                AddVerticalSpace(20),
                TextEditField(
                  hintText: "Age",
                  maxLength: 2,
                  cursorColor: AppColors.mainColor,
                  textCapitalization: TextCapitalization.none,
                  preffixIcon: Icon(Icons.calendar_month,color: AppColors.mainColor,),
                  textEditingController: age,
                  errorText: agevalidate ? "Age Requried" : null,
                  width: Dimensions.screenWidth(context),
                ),
                SizedBox(
                  height: 5,
                ),
                TextEditField(
                  hintText: "Height",
                  maxLength: 3,
                  cursorColor: AppColors.mainColor,
                  textCapitalization: TextCapitalization.none,
                  preffixIcon: Icon(Icons.height,color: AppColors.mainColor,),
                  textEditingController: height,
                  errorText: heightvalidate ? "Height Requried" : null,
                  width: Dimensions.screenWidth(context),
                ),
                SizedBox(
                  height: 5,
                ),
                TextEditField(
                  hintText: "Weight",
                  maxLength: 3,
                  cursorColor: AppColors.mainColor,
                  textCapitalization: TextCapitalization.none,
                  preffixIcon: Icon(Icons.monitor_weight,color: AppColors.mainColor,),
                  textEditingController: weight,
                  errorText: weightvalidate ? "Weight Requried" : null,
                  width: Dimensions.screenWidth(context),
                ),
                AddVerticalSpace(23),
                BTN(
                  width: Dimensions.screenWidth(context) - 100,
                  title: "Update Data",
                  textColor: AppColors.white,
                  color: AppColors.mainColor,
                  fontSize: 15,
                  onPressed: () {
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
                          heightvalidate = true;
                        });
                      }
                      else if (weight.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Height must be between 3 to 10',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.mainColor,
                            textColor: Colors.white,
                            fontSize: 10.0);
                        //   setState(() {
                        //     weightvalidate = true;
                        //   });
                        // }
                      }
                      // else if (weight.text.isEmpty) {
                      //   setState(() {
                      //     weightvalidate = true;
                      //   });
                      //   }
                      updatedata();
                      Fluttertoast.showToast(
                          msg: ' Your Data is Updated',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.mainColor,
                          textColor: Colors.white,
                          fontSize: 10.0);

                  }
                ),
                AddVerticalSpace(30),
              ],
            ),
          ),
        );
      }),
    );
  }
  double CalculateBMI(height, weight) {
    // double heightSquare = height;
    double result = weight / (height*height);
    return result;
  }
}
