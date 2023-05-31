import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/DashboardScreen/WorkOut.dart';
import 'package:diet/DashboardScreen/start_excersie.dart';
import 'package:diet/DashboardScreen/weight_gain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../AuthenticationModule/Views/sign_up_view.dart';
import '../AuthenticationModule/get_controller.dart';
import '../Utils/app_colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/text_view.dart';
import 'bmicalculate.dart';
import 'diet_gain.dart';
import 'drawer.dart';

class DietPlan extends StatefulWidget {
  const DietPlan({Key? key}) : super(key: key);

  @override
  State<DietPlan> createState() => _DietPlanState();
}

class _DietPlanState extends State<DietPlan> {
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
         text="Diet for Weight Gain";
       }
       else{
         text="Diet for weight loss";
       }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildMyNavBar(context),
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
              // title: TextView(text:  "$text",),
          title: TextView(text:  "$text",),
        ),
      body: StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection("Diet").orderBy("name")
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
                    if(getcontroller.completedDietGain.value.contains(days[index]["name"])) {
                      Fluttertoast.showToast(
                          msg: 'Your this Day exercise is done',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.mainColor,
                          textColor: Colors.white,
                          fontSize: 10.0);
                    }else{
                      print("${getcontroller.completedDietGain.value}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DietGain(
                                  day: days[index]["name"]
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
                        Text("Day ${days[index]["name"]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                        ),
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
                  child: Icon(Icons.calculate,size: 35,)),
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
}
