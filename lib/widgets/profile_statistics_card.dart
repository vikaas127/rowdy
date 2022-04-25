import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/disliked_profile_screen.dart';
import 'package:dating_app/screens/profile_likes_screen.dart';
import 'package:dating_app/screens/profile_visits_screen.dart';
import 'package:dating_app/widgets/default_card_border.dart';
import 'package:dating_app/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileStatisticsCard extends StatelessWidget {
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
      //elevation: 4.0,

    //  shape: defaultCardBorder(),
      child: Column(
        children: [
          ListTile(
            leading: SvgPicture.asset("assets/profile/like.svg",),
            title: Text("Liked by you", style: _textStyle),
            trailing: _counter(context, UserModel().user.userTotalLikes),
            onTap: () {
              /// Go to profile likes screen
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ProfileLikesScreen()));
            },
          ),

          Divider(height: 0),
          ListTile(
            leading: SvgPicture.asset("assets/profile/cross.svg",),
            title: Text("Rejected by you", style: _textStyle),
            trailing: _counter(context, UserModel().user.userTotalDisliked),
            onTap: () {
              /// Go to disliked profile screen
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => DislikedProfilesScreen()));
            },
          ),
          Divider(height: 0),
          ListTile(
            leading: SvgPicture.asset("assets/profile/like.svg",),
            title: Text("see who liked you", style: _textStyle),
            trailing: _counter(context, UserModel().user.userTotalVisits),
            onTap: () {
              /// Go to profile visits screen
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ProfileVisitsScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget _counter(BuildContext context, int value) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor, //.withAlpha(85),
          shape: BoxShape.circle),
      padding: const EdgeInsets.all(6.0),
      child: Text(value.toString(), style: TextStyle(color: Colors.white)));
  }
}
