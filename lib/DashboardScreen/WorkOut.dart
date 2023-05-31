import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/DashboardScreen/diet_gain.dart';
import 'package:diet/DashboardScreen/diet_plan.dart';
import 'package:diet/DashboardScreen/drawer.dart';
import 'package:diet/DashboardScreen/start_excersie.dart';
import 'package:diet/DashboardScreen/weight_gain.dart';
import 'package:diet/Utils/app_colors.dart';
import 'package:diet/Utils/dimensions.dart';
import 'package:diet/Utils/spaces.dart';
import 'package:diet/Utils/text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../AuthenticationModule/get_controller.dart';
import '../Utils/get_storage.dart';
import 'bmicalculate.dart';

class WorkOut extends StatefulWidget {
  @override
  State<WorkOut> createState() => _WorkOutState();
}

class _WorkOutState extends State<WorkOut> {
  GetController getcontroller = Get.put(GetController());
  String name = "";
  List users = [];
  int pageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserName();
  }

  void getUserName() async {
    var email = GetStoreData.getEmail();
    var snap = await FirebaseFirestore.instance
        .collection("UsersData")
        .doc("${email}")
        .get();
    setState(() {
      name = (snap.data() as dynamic)["Name"];
      GetStoreData.storeName(name: name);
    });
    getcontroller.getCompletedDietGain(email: email);
    getcontroller.getCompletedWeightGain(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: buildMyNavBar(context),
        backgroundColor: AppColors.grey,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            Image.asset(
              "assets/workout.jpg",
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                  child: Text(
                    " Smart WorkOut",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ))
          ]),

          // Text("Heloo",style: TextStyle(color: Colors.white),),
          AddVerticalSpace(20),
          SizedBox(
            height: 100,
            width: 350,
            // color: Colors.blue,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Center(
                        child: Text(
                      "WELCOME ${name}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                  ),
                ],
              ),
            ),
            // child: StreamBuilder(
            //     stream: FirebaseFirestore.instance.collection("UsersData").snapshots(),
            //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //       if (snapshot.hasData) {
            //         return ListView.builder(
            //           itemCount: snapshot.data!.docs.length,
            //             itemBuilder: (context,i){
            //                return Container(
            //                  // width: 200,
            //                  // height: 100,
            //                   child: Padding(padding: EdgeInsets.all(18.0),
            //                   child :SingleChildScrollView(
            //                   scrollDirection: Axis.horizontal,
            //                   child:
            //                   ),
            //                   )
            //                   ),
            //                );
            //             }
            //         );
            //       }
            //       else{
            //         return CircularProgressIndicator();
            //       }
            //       //   users = snapshot.data!.docs
            //       //       .where((element) => element[""] == Text(""))
            //       //       .toList();
            //       // }
            //       // return ListView.builder(
            //       //   itemCount: users.length,
            //       //   itemBuilder: (BuildContext context, int index) {
            //       //     return Column(
            //       //       children: [],
            //       //     );
            //       //   },
            //       // );
            //     }),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20.0),
            //   child: Text(
            //     "Welcome Hassan",
            //
            //     style: TextStyle(fontSize:25,color: Colors.white),
            //   ),
            // ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(WeightGain());
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 120,
              width: Dimensions.screenWidth(context),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
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
                  TextView(
                    text: "Exercise Plan",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(DietPlan());
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 120,
              width: Dimensions.screenWidth(context),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
                      image: AssetImage("assets/dietplan.jpg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade400),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/die.png",
                    height: 60,
                    width: 60,
                  ),
                  TextView(
                    text: "Diet Plan",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ),
          ),
        ])));
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => WorkOut()));
                      pageIndex = 0;
                    });
                  },
                  child: Icon(
                    Icons.home,
                    size: 35,
                  )),
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
                  child: Icon(
                    Icons.sports_gymnastics,
                    size: 35,
                  )),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DietPlan()));

                      pageIndex = 2;
                    });
                  },
                  child: Icon(
                    Icons.next_plan_outlined,
                    size: 35,
                  )),
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
                  child: Icon(
                    Icons.calculate,
                    size: 35,
                  )),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => drawer()));
                    pageIndex = 3;
                  });
                },
                child: Icon(
                  Icons.person,
                  size: 35,
                ),
              ),
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
  // Future<void> _getUserName() async {
  //   FirebaseFirestore.instance
  //       .collection('UsersData')
  //       .doc((await FirebaseAuth.instance.currentUser!).uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       _userName = value.data['UserName'].toString();
  //     });
  //   });
  // }
}
