import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/AuthenticationModule/Views/sign_in_view.dart';
import 'package:diet/DashboardScreen/WorkOut.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Utils/app_colors.dart';
import '../../../Utils/btn.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/spaces.dart';
import '../../../Utils/text_edit_field.dart';
import '../../../Utils/text_view.dart';
import 'bmiresult.dart';

enum Weight { kg }
enum Height { inches }

class BmiCalculate extends StatefulWidget {


  const BmiCalculate({super.key});

  @override
  State<BmiCalculate> createState() => _BmiCalculateState();
}

class _BmiCalculateState extends State<BmiCalculate> {
  String? result="";
  double? height=0;
  double? weight=0;

  List bmi = [];
  String? text="";

  // double? _result;

  bool agevalidate = false;
  bool heightvalidate = false;
  bool weightvalidate = false;

  final TextEditingController agecontroller = new TextEditingController();
  final TextEditingController heightcontroller = new TextEditingController();
  final TextEditingController weightcontroller = new TextEditingController();
  // late UserCredential authResult;
  // final FirebaseFirestore _firestore =FirebaseFirestore.instance;

  // bool isMale=false;
  // Weight? weight = Weight.kg;
  // Height? height = Height.inches;
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
        title: TextView(text: "Calculate Your BMI"),
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
              Center(
                child: Text(
                  "BMI Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              AddVerticalSpace(45),
              TextEditField(
                hintText: "Age",
                maxLength: 2,
                inputType: TextInputType.number,
                cursorColor: AppColors.mainColor,
                textCapitalization: TextCapitalization.none,
                preffixIcon: Icon(
                  Icons.calendar_month,
                  color: AppColors.mainColor,
                ),
                textEditingController: agecontroller,
                errorText: agevalidate==false ? "Age Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(25),
              TextEditField(
                hintText: "Height",
                inputType: TextInputType.number,
                maxLength: 3,
                cursorColor: AppColors.mainColor,
                textCapitalization: TextCapitalization.none,
                preffixIcon: Icon(
                  Icons.height,
                  color: AppColors.mainColor,
                ),
                textEditingController: heightcontroller,
                errorText: heightvalidate==false ? "Height Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(25),
              TextEditField(
                hintText: "Weight",
                maxLength: 3,
                inputType: TextInputType.number,
                cursorColor: AppColors.mainColor,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.monitor_weight, color: AppColors.mainColor),
                textEditingController: weightcontroller,
                errorText: weightvalidate ==false? "Weight Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(25),
              BTN(
                width: Dimensions.screenWidth(context) - 100,
                title: "Calculate",
                textColor: AppColors.white,
                color: AppColors.mainColor,
                fontSize: 15,
                onPressed: () {
                  if (int.parse(agecontroller.text)>15&& int.parse(agecontroller.text)<75) {
                    setState(() {
                      agevalidate = true;
                    });
                  }
                  if (double.parse(heightcontroller.text)>3.0) {
                   if(double.parse(heightcontroller.text)<10.0) {
                        print("My BMI");
                        setState(() {
                          heightvalidate = true;
                        });
                      }
                    }  if (!weightcontroller.text.isEmpty) {
                    print("user weight");
                    setState(() {
                      weightvalidate = true;
                    });
                  }
                 if(heightvalidate == true && weightvalidate == true){
                   height=double.parse(heightcontroller.value.text)*0.3048;
                   weight=double.parse(weightcontroller.value.text);
                   double rsl= CalculateBMI(height!,weight!);
                   if(rsl<18.0){
                     text= "you are  under weight";
                     setState(() {

                     });
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>BmiResult(
                         value: rsl, message: '$text'
                     )));
                   } else if(rsl>18.0 && rsl<=20.0){
                     text=" you are normal";
                     setState(() {

                     });
                     print(text);
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>BmiResult(
                         value: rsl, message: '$text'
                     )));
                   } else{
                     text=" you are over  weight";
                     setState(() {

                     });
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>BmiResult(
                         value: rsl, message: '$text'
                     )));
                     print(text);
                   }

                 }
                },
              ),
              AddVerticalSpace(20),
            ],
          ),
        ),
      )
    );
  }
  CalculateBMI( double height, double weight,) {
    double finalresult=weight/(height*height);
    // String bmi=finalresult.toStringAsFixed(2);

    return finalresult;
  }
}
