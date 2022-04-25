import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/sign_in_screen.dart';
import 'package:dating_app/widgets/default_card_border.dart';
import 'package:dating_app/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class SignOutButtonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    return Padding(
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
        child: ListTile(
          leading:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SvgIcon("assets/4.0x/logout.svg",color:APP_PRIMARY_COLOR ,),
          ),
          title: Text(i18n.translate("sign_out"), style: TextStyle(fontSize: 18,color: Colors.black)),

          onTap: () {
    showDialog(
    context: context,
    builder: (context) {
    return AlertDialog(
        title: Text('Are you sure you want logout?',style:
          TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        content:Container(height: 70,
            child: Column(
          children: [
Row(
  children: [
    Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlatButton(child: Text("No",style: TextStyle(fontSize: 18, color: Color(0xffDE2657,)),),
              onPressed:(){
                Navigator.of(context).pop(false);
              }),
        ],
      ),
    ),
    FlatButton(child: Text("Yes",style: TextStyle(fontSize: 18, color: Color(0xffFF6418,)),),
        onPressed:(){
          UserModel().signOut().then((_) {
            /// Go to login screen
            Future(() {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            });
          });
    }),
  ],
)
        ]))
    );

              //  return



              },
            );
            // Log out button

          },
        ),
      ),
    );
  }
}
