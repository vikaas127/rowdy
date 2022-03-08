import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/api/likes_api.dart';
import 'package:dating_app/api/visits_api.dart';
import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/datas/user.dart';
import 'package:dating_app/dialogs/vip_dialog.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/profile_screen.dart';
import 'package:dating_app/widgets/build_title.dart';
import 'package:dating_app/widgets/loading_card.dart';
import 'package:dating_app/widgets/no_data.dart';
import 'package:dating_app/widgets/processing.dart';
import 'package:dating_app/widgets/profile_card.dart';
import 'package:dating_app/widgets/svg_icon.dart';
import 'package:dating_app/widgets/users_grid.dart';
import 'package:flutter/material.dart';

class ProfileLikesScreen extends StatefulWidget {
  @override
  _ProfileLikesScreenState createState() => _ProfileLikesScreenState();
}

class _ProfileLikesScreenState extends State<ProfileLikesScreen> {
  // Variables
  final ScrollController _gridViewController = new ScrollController();
  final LikesApi _likesApi = LikesApi();
  final VisitsApi _visitsApi = VisitsApi();
  late AppLocalizations _i18n;
  List<DocumentSnapshot>? _likedMeUsers;
  late DocumentSnapshot _userLastDoc;
  bool _loadMore = true;

  /// Load more users
  void _loadMoreUsersListener() async {
    _gridViewController.addListener(() {
      if (_gridViewController.position.pixels ==
          _gridViewController.position.maxScrollExtent) {
        /// Load more users
        if (_loadMore) {
          _likesApi
              .getLikedMeUsers(loadMore: true, userLastDoc: _userLastDoc)
              .then((users) {
            /// Update users list
            if (users.isNotEmpty) {
              _updateUsersList(users);
            } else {
              setState(() => _loadMore = false);
            }
            print('load more users: ${users.length}');
          });
        } else {
          print('No more users');
        }
      }
    });
  }
  /// Update list
  void _updateUsersList(List<DocumentSnapshot> users) {
    if (mounted) {
      setState(() {
        _likedMeUsers!.addAll(users);
        if (users.isNotEmpty) {
          _userLastDoc = users.last;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _likesApi.getLikedMeUsers().then((users) {
      // Check result
      if (users.isNotEmpty) {
        if (mounted) {
          setState(() {
            _likedMeUsers = users;
            _userLastDoc = users.last;
          });
        }
      } else {
        setState(() => _likedMeUsers = []);
      }
    });

    /// Listener
    _loadMoreUsersListener();
  }

  @override
  void dispose() {
    _gridViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Initialization
    _i18n = AppLocalizations.of(context);

    return Scaffold(
        appBar: AppBar(backgroundColor:APP_ACCENT_COLOR ,
          elevation: 0,
          leading: IconButton(onPressed: () {  },icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),),),

        body: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Header Title
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
                    showDialog(context: context,
                        builder: (context) => VipDialog());
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


            /// Matches
            Expanded(child: _showProfiles())
          ],
        ));
  }

  /// Show profiles
  Widget _showProfiles() {
    if (_likedMeUsers == null) {
      return Processing(text: _i18n.translate("loading"));
    } else if (_likedMeUsers!.isEmpty) {
      // No data
      return NoData(svgName: 'heart_icon', text: _i18n.translate("no_like"));
    } else {
      /// Show users
      return UsersGrid(
        gridViewController: _gridViewController,
        itemCount: _likedMeUsers!.length + 1,

        /// Workaround for loading more
        itemBuilder: (context, index) {
          /// Validate fake index
          if (index < _likedMeUsers!.length) {
            /// Get user id
            final userId = _likedMeUsers![index][LIKED_BY_USER_ID];

            /// Load profile
            return FutureBuilder<DocumentSnapshot>(
                future: UserModel().getUser(userId),
                builder: (context, snapshot) {
                  /// Check result
                  if (!snapshot.hasData) return LoadingCard();

                  /// Get user object
                  final User user = User.fromDocument(snapshot.data!.data()!);

                  /// Show user card
                  return GestureDetector(
                    child: ProfileCard(user: user, page: 'require_vip'),
                    onTap: () {
                      /// Check vip account
                      if (UserModel().userIsVip) {
                        /// Go to profile screen - using showDialog to
                        /// prevents reloading getUser FutureBuilder
                        showDialog(context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return ProfileScreen(
                                user: user,
                                hideDislikeButton: true
                              );
                            }
                        );
                        /// Increment user visits an push notification
                        _visitsApi.visitUserProfile(
                          visitedUserId: user.userId,
                          userDeviceToken: user.userDeviceToken,
                          nMessage: "${UserModel().user.userFullname.split(' ')[0]}, "
                              "${_i18n.translate("visited_your_profile_click_and_see")}",
                        );
                      } else {
                        /// Show VIP dialog
                        showDialog(context: context, 
                          builder: (context) => VipDialog());
                      }
                    },
                  );
                });
          } else {
            return Container();
          }
        },
      );
    }
  }
}
