import 'package:dating_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.all(8.0),
            child: Text("Need Help",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: APP_ACCENT_COLOR),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("We will respond you as soon as possible",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.grey),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
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
                hintText: "your email id",
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(maxLines: 8,
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
            padding: const EdgeInsets.all(18.0),
            child: Container(height: 45,width: MediaQuery.of(context).size.width*0.73,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color(0xffde2657),
              ),child:   Center(
                child: Text('Send', textAlign: TextAlign.center, style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400
                ),),
              ),

            ),
          ),

      ]));}}