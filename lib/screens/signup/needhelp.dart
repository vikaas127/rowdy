import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/delete_account_button.dart';
import '../../widgets/sign_out_button_card.dart';

class Needhelp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return Needhelp_State();
  }

}
class Needhelp_State extends State<Needhelp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text("Need Help",style: TextStyle(fontSize: 25,color: Colors.pink,fontWeight: FontWeight.bold),),
      ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 5),
          child: Text("Contact Us",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 5 ),
          child: Text("rowdybabyofficial@gmail.com",style: TextStyle(fontSize: 15,color: Color(0xffFF6418),fontWeight: FontWeight.normal),),
        ),
SizedBox(height: MediaQuery.of(context).size.height*.50,),
      SignOutButtonCard(),
      DeleteAccountButton(),
    ],),
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,leading:IconButton(onPressed: (){
         Navigator.of(context).pop(true);
      },icon: Icon(Icons.arrow_back,color: Colors.pink,),) ,),
    );
  }
}