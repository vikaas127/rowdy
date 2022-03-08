import 'package:dating_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetRefer extends StatefulWidget {



  @override
  _BottomSheetRefer createState() => _BottomSheetRefer();
}

class _BottomSheetRefer extends State<BottomSheetRefer> {


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
            child: Text("Refer a Friend",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: APP_ACCENT_COLOR),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Invite a friend and get 24% off, actually price\n 199/-, after discount subscription 160/- Rs only",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.grey),),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/couple4.png' ,height: 150,width: 150,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Send the invitation link ",style: TextStyle(fontSize: 11,fontWeight: FontWeight.normal,color: Colors.grey),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Ask your friend to get sign-up",style: TextStyle(fontSize: 11,fontWeight: FontWeight.normal,color: Colors.grey),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Auto apply of the coupon @ check out",style: TextStyle(fontSize: 11,fontWeight: FontWeight.normal,color: Colors.grey),),
          ),
          SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 50,
              child: TextFormField(
           //   controller: _nameController,
                decoration: InputDecoration(filled: true,
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
                  suffixIcon:  Container(height: 35,width: MediaQuery.of(context).size.width*0.23,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xffde2657),
                    ),child:   Center(
                      child: Text('Refer Now', textAlign: TextAlign.center, style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                      ),),
                    ),

                  ),
                  //   labelText: _i18n.translate("fullname"),
                  hintText: "https://sitechecker.pro/wh",
                  hintStyle: TextStyle(color: Colors.black),
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
          ),

      ]));}}