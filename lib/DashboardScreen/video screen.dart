import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/Utils/app_colors.dart';
import 'package:diet/Utils/spaces.dart';
import 'package:diet/Utils/text_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../AuthenticationModule/get_controller.dart';
import '../Utils/btn.dart';
import '../Utils/dimensions.dart';

class VideoPlayer extends StatefulWidget {
  final String value,name;bool isDietgain;

   VideoPlayer({Key? key, required this.value, required this.name,required this.isDietgain}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  GetController getcontroller=Get.put(GetController());



  // final videoUrl="";

   late YoutubePlayerController _controller;
   // final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String videoID=YoutubePlayer.convertUrlToId(widget.value)!;
    _controller=YoutubePlayerController(
        initialVideoId:videoID,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        useHybridComposition: false,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(text: "Watch Video",),
        backgroundColor:AppColors.mainColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(controller: _controller,
            showVideoProgressIndicator: true,
            onReady: ()=>debugPrint('Ready'),
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: ProgressBarColors(
                  playedColor: Colors.green,
                  handleColor: AppColors.mainColor,
                ),
              ),
              PlaybackSpeedButton(
              ),
            ],
          ),
      AddVerticalSpace(15),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: BTN(
          width: Dimensions.screenWidth(context) - 100,
          title: "Your Exercise Completed",
          textColor: AppColors.white,
          color: AppColors.mainColor,
          fontSize: 15, onPressed: (){
          if(widget.isDietgain==true) {
            getcontroller.storeDiet(name: widget.name);
          }else{
            getcontroller.storeWeightGain(name: widget.name);

          }
          Fluttertoast.showToast(
              msg: 'Your Exercise Completed',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.mainColor,
              textColor: Colors.white,
              fontSize: 10.0);
        },
        ),
      ),
        ],
      ),
    );
  }
}
