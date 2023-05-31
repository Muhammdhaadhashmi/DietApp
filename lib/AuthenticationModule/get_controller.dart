import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Utils/get_storage.dart';

class GetController extends GetxController{
  RxList completedDietGain=[].obs;
  RxList completedWeightGain=[].obs;

  void getCompletedDietGain({email})async{
    var snap=await FirebaseFirestore.instance.collection("UsersData").doc("$email").collection("CompletedDietGain").get();
    for(int i=0;i<snap.docs.length;i++){
      completedDietGain.value.add((snap.docs[i]["name"]));
    }
    print("diet list is ${completedDietGain.value}");


  }
  void storeDiet({name})async{
    var email = GetStoreData.getEmail();
    var snap=await FirebaseFirestore.instance.collection("UsersData").doc("$email").collection("CompletedDietGain").doc("${DateTime.now().millisecondsSinceEpoch}").set({
      "name":int.parse(name),
    });
    getCompletedDietGain(email: email);
  }
  void getCompletedWeightGain({email})async{
    var snap=await FirebaseFirestore.instance.collection("UsersData").doc("$email").collection("CompletedweightGain").get();
    for(int i=0;i<snap.docs.length;i++){
      completedWeightGain.value.add((snap.docs[i]["name"]));
    }
    print("diet list is ${completedWeightGain.value}");

  }
  void storeWeightGain({name})async{
    var email = GetStoreData.getEmail();

    var snap=await FirebaseFirestore.instance.collection("UsersData").doc("$email").collection("CompletedweightGain").doc("${DateTime.now().millisecondsSinceEpoch}").set({
      "name":int.parse(name),

    });
    getCompletedWeightGain(email: email);


  }

  // void storeDietGain({name})async{
  //   var email = GetStoreData.getEmail();
  //
  //   var snap=await FirebaseFirestore.instance.collection("UsersData").doc("$email").collection("CompletedDietGain").doc("${DateTime.now().millisecondsSinceEpoch}").set({
  //     "name":name,
  //
  //   });
  //   getCompletedDietGain(email: email);
  //
  //
  // }
}