import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/DashboardScreen/weight_gain.dart';
import 'package:diet/HomeModule/homeview.dart';
import 'package:diet/Utils/spaces.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Utils/app_colors.dart';
import '../Utils/btn.dart';
import '../Utils/dimensions.dart';
import '../Utils/text_view.dart';
import '../Utils/toast.dart';
import 'WorkOut.dart';

class start_excersie extends StatefulWidget {
  final email;
  const start_excersie({Key? key, this.email}) : super(key: key);

  @override
  State<start_excersie> createState() => _start_excersieState();
}

class _start_excersieState extends State<start_excersie> {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List bmi = [];
  late double _bmi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(FirebaseAuth.instance.currentUser!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(text: "Start Excersie"),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 400,
              width: 400,
              // color: Colors.blue,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("UsersData")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      bmi = snapshot.data!.docs
                          .where((element) =>
                              element["Email"] ==
                              FirebaseAuth.instance.currentUser!.email)
                          .toList();
                    }
                    return ListView.builder(
                      itemCount: bmi.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Column(
                            children: [
                              AddVerticalSpace(60),
                              Text("BMI Result",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                             AddVerticalSpace(200),
                              Text(" BMI is : ${bmi[index]["bmivalue"].ceil()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                              AddVerticalSpace(25),
                              bmi[index]["bmivalue"] < 20 ? Text("You are a under weighted",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                                  :SizedBox(),
                              // bmi[index]["bmivalue"] >=20?  Text("You are normal",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),):SizedBox(),
                              bmi[index]["bmivalue"]>20?Text("You are over weight",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),):SizedBox(),
                              // Text("")
                              // bmi[index]["bmivalue"] < 18 ? Text("You are a under weighted",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),) : SizedBox(),
                              // bmi[index]["bmivalue"] > 18 &&  bmi[index]["bmivalue"]==20  ? Text("You are normal",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),) : SizedBox(),
                              // bmi[index]["bmivalue"] >=20 ? Text("You are over weight",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),) : SizedBox(),
                            // ],
                          ],
                          ),
                        );
                      },
                    );
                  }),
            ),
            AddVerticalSpace(70),
        BTN(
          width: Dimensions.screenWidth(context) - 100,
          title: "Start Exercise",
          textColor: AppColors.white,
          color: AppColors.mainColor,
          fontSize: 15,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkOut()));
            },
        ),
          ],
        ),
      ),
    );
  }
}

