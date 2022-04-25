import 'package:dating_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../sign_in_screen.dart';

class BottomSheetNeedHelp extends StatefulWidget {



  @override
  _BottomSheetNeedHelp createState() => _BottomSheetNeedHelp();
}

class _BottomSheetNeedHelp extends State<BottomSheetNeedHelp> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: 600,
      child: ListView(shrinkWrap: true,scrollDirection: Axis.vertical,
        children:[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
            child: Text("Reason",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: APP_ACCENT_COLOR),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
            child: Text("If you delete permanently account your loose your chat, requests etc..",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextFormField(maxLines: 6,
              style: TextStyle(color: Colors.black),
              //   controller: _nameController,
              decoration: InputDecoration(
                hoverColor: Color(0xffC5204C),
                fillColor: Colors.white,
                errorStyle: TextStyle(fontSize: 16),
                focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                focusColor:  Color(0xffC5204C) ,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:  Color(0xffC5204C),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                //   labelText: _i18n.translate("fullname"),
                hintText: "type your query",
                hintStyle: TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              validator: (name) {
                // Basic validation
                if (name?.isEmpty ?? false) {
                  return "share";
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 10,),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
    child: Container(width: MediaQuery.of(context).size.width*0.86,
    height: 55,
    decoration: BoxDecoration(color: Color(0xffDE2657),
    border: Border.all(color: Color(0xffDE2657),
    width: 1.0
    ),
    borderRadius: BorderRadius.all(
    Radius.circular(5.0) //                 <--- border radius here
    ),
    ),
    // clipBehavior: Clip.antiAlias,
    // elevation: 4.0,
    //  shape: defaultCardBorder(),
    child:  FlatButton(child: Text("Cancel",style: TextStyle(fontSize: 18, color: Colors.white),),
              onPressed:(){
                Navigator.of(context).pop(false);
              }),)),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
    child: Container(width: MediaQuery.of(context).size.width*0.86,
    height: 55,
    decoration: BoxDecoration(
    border: Border.all(color: Colors.grey,
    width: 1.0
    ),
    borderRadius: BorderRadius.all(
    Radius.circular(5.0) //                 <--- border radius here
    ),
    ),
    // clipBehavior: Clip.antiAlias,
    // elevation: 4.0,
    //  shape: defaultCardBorder(),
    child:   FlatButton(child: Text("Confirm Delete Account",style: TextStyle(fontSize: 18, color: Colors.grey,)),
              onPressed:(){
                UserModel().signOut().then((_) {
                  /// Go to login screen
                  Future(() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignInScreen()));
                  });
                });
              }),),),




      ]));}}