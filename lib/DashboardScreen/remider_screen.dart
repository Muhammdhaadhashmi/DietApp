import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:diet/DashboardScreen/drawer.dart';
import 'package:diet/Utils/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Utils/app_colors.dart';
import '../Utils/btn.dart';
import '../Utils/dimensions.dart';
import '../Utils/local_notification_service.dart';
import '../Utils/spaces.dart';
import '../main.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  bool timevalidate = false;
  List notifications = [];

  @override
  void initState() {
    super.initState();
  }

  String time = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => drawer()));
          },
        ),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Timer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddVerticalSpace(50),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: DateTimePicker(
                type: DateTimePickerType.time,
                cursorColor: AppColors.mainColor,
                timePickerEntryModeInput: true,
                // initialValue: "",
                //_initialValue,
                icon: Icon(
                  Icons.access_time,
                  color: AppColors.mainColor,
                  size: 40,
                ),
                timeLabelText: "Time",
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                use24HourFormat: true,
                onChanged: (value) {
                  setState(() {
                    // hours = int.parse(value.substring(0,1));
                    // mins = int.parse(value.substring(3,4));
                    time = value;
                  });
                  // print(hours);
                  // print(mins);
                },
              ),
            ),
            AddVerticalSpace(10),
            BTN(
              width: Dimensions.screenWidth(context) - 100,
              title: "Update Reminder",
              textColor: AppColors.white,
              color: AppColors.mainColor,
              fontSize: 15,
              onPressed: () async {
                // LocalNotifications().notification(
                //     "without", "without", "without");
                // var status1 = await Permission.;
                initializeService();
                await FirebaseFirestore.instance
                    .collection("UsersData")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .update({
                  "title": "Start Your Exercise",
                  "msg": "Its a time to workout",
                  "Time": time,
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      iOS: IOSInitializationSettings(),
      android: AndroidInitializationSettings("logo"),
    ),
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,
      autoStartOnBoot: true,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'Smart Workout',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,
      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,
      // you have to enable background fetch capability on xcode project
      // onBackground: onIosBackground,
    ),
  );

  service.startService();
}

Stream<DateTime> getTime() async* {
  DateTime currentTime = DateTime.now();
  while (true) {
    await Future.delayed(Duration(minutes: 1));
    yield currentTime;
  }
}

void onStart(ServiceInstance serviceInstance) {
  // FlutterSimpleToast(msg: "Its time to workout");

  getTime().listen((event) async {
    DateTime now = DateTime.now();
    print(now.minute);
    //
    // FlutterSimpleToast(msg: "${now.minute}");

    // Map timeOfDayToFirebase(TimeOfDay timeOfDay){
    //   return {
    //     'hour':timeOfDay.hour,
    //     'minute':timeOfDay.minute
    //   };
    // }

    // TimeOfDay firebaseToTimeOfDay(Map data){
    //   return TimeOfDay(
    //       hour: data['hour'],
    //       minute: data['minute']);
    // }
    //
    // var myTimeOfDayObject=TimeOfDay.now();

    await Firebase.initializeApp();
    String time = "${now.minute}";
    String title = "Start Exercise its time to workout";
    String msg = "Workout";
    // LocalNotifications().notification("hi", "hello", "Start");

    if(FirebaseAuth.instance.currentUser!=null){
      await FirebaseFirestore.instance.collection("UsersData").doc(FirebaseAuth.instance.currentUser?.email).get().then((value) {
        time = (value.data()as dynamic)["Time"]?? "";
        title = (value.data()as dynamic)["title"]?? "";
        msg = (value.data()as dynamic)["msg"]?? "";
        print(time);
        print("${now.hour}:${now.minute}");
        if (time=="${now.hour}:${now.minute}") {
          backgroundHandler(title, msg, "${now}");
        }
      });
    }
  });
}
