import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/helpers/app_helper.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/widgets/app_logo.dart';
import 'package:dating_app/models/app_model.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  // Variables
  final AppHelper _appHelper = AppHelper();

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(elevation: 0,
        title: Text(i18n.translate('about_us')),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 65),
        child:
           Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// App icon

              SizedBox(height: 10),

              /// App name
              Text(
                i18n.translate('about_us'),
                style: TextStyle(color: Color(0xffC5204C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              // slogan
             ListTile(leading: Text("Terms and Conditions", style: TextStyle(
               fontSize: 16,
               fontWeight: FontWeight.normal,
             ),),trailing: Icon(Icons.arrow_forward_ios_sharp),)
             , ListTile(leading: Text("Privacy Policy", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),),trailing: Icon(Icons.arrow_forward_ios_sharp),)

           ,   ListTile(leading: Text("Website", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),),trailing: Icon(Icons.arrow_forward_ios_sharp),)

            ],
          ),
        ),

    );
  }
}
