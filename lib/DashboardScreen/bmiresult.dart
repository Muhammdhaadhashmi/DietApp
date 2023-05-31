import 'package:diet/DashboardScreen/WorkOut.dart';
import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';
import '../Utils/btn.dart';
import '../Utils/dimensions.dart';
import '../Utils/spaces.dart';
import '../Utils/text_edit_field.dart';
import '../Utils/text_view.dart';

enum Weight { kg }
enum Height { inches }

class BmiResult extends StatefulWidget {
  double value;
  String message;

  // final String value;
  // final String Text;
  BmiResult( {Key? key,required this.value,required this.message}) : super(key: key);

  @override
  State<BmiResult> createState() => _BmiResultState();
}

class _BmiResultState extends State<BmiResult> {
  @override
  Widget build(BuildContext context) {
    // double result=double.parse(widget.value.toStringAsFixed(1));
    return Scaffold(
        appBar: AppBar(
          title: TextView(text: "BMI Result"),
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
                      AddVerticalSpace(190),
                      // Text('${widget.value}'),
                      Text("Result",style: TextStyle(color: AppColors.mainColor,fontSize: 25,fontWeight: FontWeight.bold),),
                      AddVerticalSpace(45),
                      Text("Your BMI is =  "'${widget.value.ceil()}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                      AddVerticalSpace(10),
                      Text('${widget.message}',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),),
                      AddVerticalSpace(150),
                      BTN(
                        width: Dimensions.screenWidth(context) - 100,
                        title: "Back to WorkOut",
                        textColor: AppColors.white,
                        color: AppColors.mainColor,
                        fontSize: 15, onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkOut()));
                      },
                      ),
                    ]
                ))));
  }
}
