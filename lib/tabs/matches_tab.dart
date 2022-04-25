import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/api/matches_api.dart';
import 'package:dating_app/datas/user.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/chat_screen.dart';
import 'package:dating_app/widgets/build_title.dart';
import 'package:dating_app/widgets/loading_card.dart';
import 'package:dating_app/widgets/no_data.dart';
import 'package:dating_app/widgets/processing.dart';
import 'package:dating_app/widgets/profile_card.dart';
import 'package:dating_app/widgets/users_grid.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../dialogs/vip_dialog.dart';
import '../widgets/svg_icon.dart';

class MatchesTab extends StatefulWidget {
  @override
  _MatchesTabState createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  /// Variables
  final MatchesApi _matchesApi = MatchesApi();
  List<DocumentSnapshot>? _matches;
  late AppLocalizations _i18n;

  @override
  void initState() {
    super.initState();

    /// Get user matches
    _matchesApi.getMatches().then((matches) {
      if (mounted) setState(() => _matches = matches);
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Initialization
    _i18n = AppLocalizations.of(context);

    return  Scaffold(appBar: AppBar(backgroundColor:APP_ACCENT_COLOR ,
      elevation: 0,

    ),

        body:
        Column(
          children: [
            /// Header
            Container(color: APP_ACCENT_COLOR,
              height: MediaQuery.of(context).size.height*0.22,width:MediaQuery.of(context).size.width ,
              child: Column(
                children: [

                  SvgIcon("assets/4.0x/match.svg",
                      color: Colors.white, width: 30, height: 30),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_i18n.translate("users_who_liked_you",),
                        style: TextStyle(
                            fontSize: 18,
                            color:Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                  Text("Upgrade to ROWDY BABY premium to see the 12  \n people who have already SWIPED RIGHT \n on you",style: TextStyle(fontSize: 12,color: Colors.white,),),
                  SizedBox(height: 3,),
                  InkWell(onTap: (){
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return VipDialog(



                        );
                      },
                    );
                  },
                    child: Center(
                      child: Container(height: 35,width: MediaQuery.of(context).size.width*0.53,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color:  Color(0xffFFD700),
                        ),child:   Center(
                          child: Text('Upgrade to Premium', textAlign: TextAlign.center, style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),),
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            ),
            /// Show matches
            Expanded(child: _showMatches()),
          ],
        )
    );

  }

  /// Handle matches result
  Widget _showMatches() {
    /// Check result
    if (_matches == null) {
      return Processing(text: _i18n.translate("loading"));
    } else if (_matches!.isEmpty) {
      /// No match
      return NoData(
        svgName: 'heart_icon', text: _i18n.translate("no_match"));
    } else {
      /// Load matches
      return UsersGrid(
        itemCount: _matches!.length,
        itemBuilder: (context, index) {
          /// Get match doc
          final DocumentSnapshot match = _matches![index];

          /// Load profile
          return FutureBuilder<DocumentSnapshot>(
              future: UserModel().getUser(match.id),
              builder: (context, snapshot) {
                /// Check result
                if (!snapshot.hasData) return LoadingCard();

                /// Get user object
                final User user = User.fromDocument(snapshot.data!.data()! as Map<String,dynamic>);

                /// Show user card
                return GestureDetector(
                    child: ProfileCard(user: user, page: 'matches'),
                    onTap: () {
                      /// Go to chat screen
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(user: user)));
                    });
              });
        },
      );
    }
  }
}
