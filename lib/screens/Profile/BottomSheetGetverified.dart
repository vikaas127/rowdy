import 'package:dating_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetGetVerified extends StatefulWidget {



  @override
  _BottomSheetGetVerified createState() => _BottomSheetGetVerified();
}

class _BottomSheetGetVerified extends State<BottomSheetGetVerified> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(shrinkWrap: true,scrollDirection: Axis.vertical,
        children:[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Get Verified",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: APP_ACCENT_COLOR),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Add more trusted and believed to your profile",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Open your camera and take a selfie.\n we'll match it with your profile photos and give \n your profile a blue verified tick.\n you selfie will not be displayed on your profile",style: TextStyle(fontSize: 11,fontWeight: FontWeight.normal,color: Colors.grey),),
          ),
          SizedBox(height: 60,),
          Center(
            child: Container(height: 45,width: MediaQuery.of(context).size.width*0.73,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color:  Colors.blue,
              ),child:   Center(
                child: Text('Get verified', textAlign: TextAlign.center, style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),),
              ),

            ),
          ),

      ]));}}