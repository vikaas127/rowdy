import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/user_model.dart';
import 'Advancefilter_screen.dart';

class BottomSheetSwitch extends StatefulWidget {
  BottomSheetSwitch({required this.switchValue,

    required this.list,
    required this.title
  });
final List<String> list;
  final Status switchValue;
  final String title;


  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {

  GroupController controller = GroupController();
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
            child: Text("${widget.title}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
          )
       ,  SimpleGroupedCheckbox<String>(
            onItemSelected: (a ){
              print(a.toString());
              setState(() {


              if(widget.switchValue==Status.Smoke){
                UserModel().updateUserData(
                    userId: UserModel().user.userId,data:
                {USER_SMOKE:a });
              }else if(widget.switchValue==Status.Drink){
                UserModel().updateUserData(
                    userId: UserModel().user.userId,data:
                {USER_DRINK:a });
              }
              else if(widget.switchValue==Status.Education){
                UserModel().updateUserData(
                    userId: UserModel().user.userId,data:
                {USER_EDUCATION:a });
              }else if(widget.switchValue==Status.MaritalStatus){
                UserModel().updateUserData(
                    userId: UserModel().user.userId,data:
                {USER_MARITAL:a });
              }
              else if(widget.switchValue==Status.Language){
                UserModel().updateUserData(
                    userId: UserModel().user.userId,data:
                {USER_LANGUAGE:[a] });
              }else if(widget.switchValue==Status.whyrowdybaby){
                UserModel().updateUserData(
                    userId: UserModel().user.userId,data:
                {USER_RELIGION:a });
              }else{

              }

              });

            },







            controller: controller,
            itemsTitle: widget.list,
            values:widget.list,
            groupStyle: GroupStyle(
                activeColor: Colors.red,
                itemTitleStyle: TextStyle(
                    fontSize: 13
                )
            ),
            checkFirstElement: false,
          )
      ]));}}