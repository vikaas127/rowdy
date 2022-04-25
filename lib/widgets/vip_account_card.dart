import 'package:dating_app/dialogs/vip_dialog.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/widgets/default_card_border.dart';
import 'package:flutter/material.dart';

class VipAccountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Initialization
    final i18n = AppLocalizations.of(context);

    return  ListTile(
        leading: Image.asset("assets/images/crow_badge_small.png",
            width: 35, height: 35),
        title: Text("Premium",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: Colors.black)),

        onTap: () {
          /// Show VIP dialog
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return VipDialog(



              );
            },
          );
        },

    );
  }
}
