import 'dart:io';
import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/helpers/app_helper.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/screens/Profile/BottomSheetGetverified.dart';
import 'package:dating_app/screens/Profile/BottomSheetNeedHelp.dart';
import 'package:dating_app/screens/Profile/BottomSheetRefer.dart';
import 'package:dating_app/screens/about_us_screen.dart';
import 'package:dating_app/widgets/default_card_border.dart';
import 'package:dating_app/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class AppSectionCard extends StatelessWidget {
  // Variables
  final AppHelper _appHelper = AppHelper();
  // Text style
  final _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    /// Initialization
    final i18n = AppLocalizations.of(context);

    return Container(
     // elevation: 4.0,
    //  shape: defaultCardBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgIcon("assets/4.0x/verify.svg",color: Colors.deepOrange,),
            ),
            title: Text("Get verified", style: _textStyle),
            onTap: () {

                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return BottomSheetGetVerified(


                    );
                  },
                );

              /// Go to About us screen
              ///
            /*  Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutScreen()));*/
            },
          ),
          Divider(height: 0),
          //
          ListTile(
            leading:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgIcon("assets/4.0x/share.svg",color: Colors.deepOrange,),
            ),
            title:
            Text(i18n.translate("share_with_friends"), style: _textStyle),
            onTap: () async {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return BottomSheetRefer(


                  );
                },
              );
              /// Share app
            //  _appHelper.shareApp();
            },
          ),
          Divider(height: 0),
          ListTile(
            leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgIcon("assets/4.0x/match.svg",color: Colors.deepOrange,),
          ),
            title: Text(i18n.translate("about_us"), style: _textStyle),
            onTap: () {
              /// Go to About us screen
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutScreen()));
            },
          ),
          Divider(height: 0),
          ListTile(
            leading:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgIcon("assets/4.0x/help.svg",color: Colors.deepOrange,),
            ),
            title:
            Text("Need Help", style: _textStyle),
            onTap: () async {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return BottomSheetNeedHelp(


                  );
                },
              );
              /// Share app
             // _appHelper.shareApp();
            },
          ),
          Divider(height: 0),
          ListTile(
            leading:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgIcon("assets/icons/star_icon.svg",color: Colors.deepOrange, width: 22, height: 22),
                ),
            title: Text(
                i18n.translate(Platform.isAndroid
                    ? "rate_on_play_store"
                    : "rate_on_app_store"),
                style: _textStyle),
            onTap: () async {
              /// Rate app
              _appHelper.reviewApp();
            },
          ),
          Divider(height: 0),
          ListTile(
            leading:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgIcon("assets/icons/lock_icon.svg",color: Colors.deepOrange, width: 22, height: 22),
                ),
            title: Text(i18n.translate("privacy_policy"), style: _textStyle),
            onTap: () async {
              /// Go to privacy policy
              _appHelper.openPrivacyPage();
            },
          ),
          Divider(height: 0),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.copyright_outlined, color: Colors.deepOrange),
            ),
            title: Text(i18n.translate("terms_of_service"), style: _textStyle),
            onTap: () async {
              /// Go to privacy policy
              _appHelper.openTermsPage();
            },
          ),
        ],
      ),
    );
  }
}
