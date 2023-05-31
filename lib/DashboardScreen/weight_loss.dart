import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/DashboardScreen/video%20screen.dart';
import 'package:diet/DashboardScreen/weight_gain.dart';
import 'package:diet/Utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../AuthenticationModule/get_controller.dart';
import '../Utils/dimensions.dart';
import '../Utils/text_view.dart';

class Exercise extends StatefulWidget {
  final int day;

  const Exercise({super.key, required this.day});

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  GetController getcontroller = Get.put(GetController());
  String? value="";
  List ex = [];


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
      if(value>20){
        text="Weight Loss";
      }
      else{
        text="Weight Gain";
      }
      // else{
      //   text="loss diet";
      // }


    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(text:  "$text",),
        backgroundColor: AppColors.mainColor,
        elevation: 0.0,
        leading: IconButton(
          // alignment: Alignment.topRight,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => WeightGain()));
          },
        ),
        // title: TextView(
        //   text: "Exercise",
        // ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("WeightGain")
              .doc("Day ${widget.day}")
              .collection("excersice")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              ex = snapshot.data!.docs;
            }
            return ListView.builder(
                itemCount: ex.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (getcontroller.completedWeightGain
                          .contains(ex[index]["name"])) {
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoPlayer(
                                  value: ex[index]["link"],
                                  name:"${widget.day}",
                                  isDietgain: false,
                                )));
                      }
                    },
                    // onTap: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer(
                    //     value: ex[index]["link"],
                    //      name:"${widget.day}",
                    //     isDietgain: false,)));
                    // },
                    // onTap: ()=> launchUrl(Uri.parse(ex[index]["link"])),
                    // child: Text(
                    //  ex[index]["name"],
                    //  style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),),
                    child:Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                           height: 90,
                      width: Dimensions.screenWidth(context),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
                              image: AssetImage("assets/cal.jpg"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade400),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "assets/bmi.png",
                              height: 60,
                              width: 65,
                            ),
                            Text(ex[index]["name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            // Text(ex[index]["link"]),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              // child: TextButton(
              //   onPressed: () //     Text(ex[index]["link"]);
              //   },  child: Text(ex[index]["link"], style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),

            );
          }
      ),

    );
  }

// body: SafeArea(

//             // Text(days[index]["name"])
//           ],
//         ),
//       ),
//     )
}