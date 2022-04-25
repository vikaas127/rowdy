import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/api/dislikes_api.dart';
import 'package:dating_app/api/likes_api.dart';
import 'package:dating_app/api/matches_api.dart';
import 'package:dating_app/api/visits_api.dart';
import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/datas/user.dart';
import 'package:dating_app/dialogs/its_match_dialog.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/plugins/swipe_stack/swipe_stack.dart';
import 'package:dating_app/screens/disliked_profile_screen.dart';
import 'package:dating_app/screens/profile_screen.dart';
import 'package:dating_app/widgets/cicle_button.dart';
import 'package:dating_app/widgets/no_data.dart';
import 'package:dating_app/widgets/processing.dart';
import 'package:dating_app/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/api/users_api.dart';

import '../api/notifications_api.dart';
import '../screens/filter/settings_screen.dart';
import '../screens/notifications_screen.dart';
import '../widgets/notification_counter.dart';
import '../widgets/svg_icon.dart';
// ignore: must_be_immutable
class DiscoverTab extends StatefulWidget {
  @override
  _DiscoverTabState createState() => _DiscoverTabState();
}
class _DiscoverTabState extends State<DiscoverTab> {
  // Variables
  final GlobalKey<SwipeStackState> _swipeKey = GlobalKey<SwipeStackState>();
  final LikesApi _likesApi = LikesApi();
  final DislikesApi _dislikesApi = DislikesApi();
  final MatchesApi _matchesApi = MatchesApi();
  final VisitsApi _visitsApi = VisitsApi();
  final UsersApi _usersApi = UsersApi();
  List<DocumentSnapshot>? _users;
  late AppLocalizations _i18n;
  final _notificationsApi = NotificationsApi();
  /// Get all Users
  Future<void> _loadUsers(List<DocumentSnapshot> dislikedUsers) async {
    _usersApi.getUsers(dislikedUsers: dislikedUsers).then((users) {
      // Check result
      if (users.isNotEmpty) {
        if (mounted) {
          setState(() => _users = users);
        }
      } else {
        if (mounted) {
          setState(() => _users = []);
        }
      }
      // Debug
      print('getUsers() -> ${users.length}');
      print('getDislikedUsers() -> ${dislikedUsers.length}');
    });
  }
  @override
  void initState() {
    super.initState();

    /// First: Load All Disliked Users to be filtered
    _dislikesApi
        .getDislikedUsers(withLimit: false)
        .then((List<DocumentSnapshot> dislikedUsers) async {
      /// Validate user max distance
      await UserModel().checkUserMaxDistance();

      /// Load all users
      await _loadUsers(dislikedUsers);
    });
  }
  @override
  Widget build(BuildContext context) {
    /// Initialization
    _i18n = AppLocalizations.of(context);
    return  Scaffold(
        appBar: AppBar(elevation: 0,
      title: Row(
        children: [
          Image.asset("assets/images/app_logo.png", width: 40, height: 60),

        ],
      ),
      actions: [
        IconButton(
            icon: _getNotificationCounter(),
            onPressed: () async {
              // Go to Notifications Screen
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationsScreen()));
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              child:Image.asset("assets/3.0x/filter.png",width: 40,height: 40,) ,
              onTap: () async {
                // Go to Notifications Screen
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingsScreen()));
              }),
        ),

      ],
    ),
        body:_showUsers());
  }
  Widget _getNotificationCounter() {
    // Set icon
    final icon = SvgIcon("assets/icons/bell_icon.svg", width: 33, height: 33);

    /// Handle stream
    return StreamBuilder<QuerySnapshot>(
        stream: _notificationsApi.getNotifications(),
        builder: (context, snapshot) {
          // Check result
          if (!snapshot.hasData) {
            return icon;
          } else {
            /// Get total counter to alert user
            final total = snapshot.data!.docs
                .where((doc) => doc.data()[N_READ] == false)
                .toList()
                .length;
            if (total == 0) return icon;
            return NotificationCounter(icon: icon, counter: total);
          }
        });
  }
  Widget _showUsers() {
    final _firestore = FirebaseFirestore.instance;
    Query usersQuery = _firestore.
    collection(C_USERS).where(USER_STATUS, isEqualTo: 'active').
    where(USER_LEVEL, isEqualTo: 'user');
   /* usersQuery.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print('particular user data');
        print(doc.data());
      });
    });*/

    if (_users == null) {


      return Processing(text: _i18n.translate("loading"));
    } else if (_users!.isEmpty) {
      /// No user found
      return NoData(
          svgName: 'search_icon',
          text: _i18n
              .translate("no_user_found_around_you_please_try_again_later"));
    } else {
      return Stack(
        fit: StackFit.expand,
        children: [
          /// User card list
          SwipeStack(
              key: _swipeKey,
              children: _users!.map((userDoc) {
                // Get User object
                final User user = User.fromDocument(userDoc.data()! as Map<String ,dynamic>);
                // Return user profile
                return SwiperItem(
                    builder: (SwiperPosition position, double progress) {
                  /// Return User Card
                  return ProfileCard(
                      page: 'discover', position: position, user: user);
                });
              }).toList(),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              translationInterval: 6,
              scaleInterval: 0.03,
              stackFrom: StackFrom.None,
              onEnd: () => debugPrint("onEnd"),
              onSwipe: (int index, SwiperPosition position) {
                /// Control swipe position
                switch (position) {
                  case SwiperPosition.None:
                    break;
                  case SwiperPosition.Left:

                    /// Swipe Left Dislike profile
                    _dislikesApi.dislikeUser(
                        dislikedUserId: _users![index][USER_ID],
                        onDislikeResult: (r) =>
                            debugPrint('onDislikeResult: $r'));

                    break;

                  case SwiperPosition.Right:

                    /// Swipe right and Like profile
                    _likeUser(context, clickedUserDoc: _users![index]);

                    break;
                }
              }),

          /// Swipe buttons
          Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: swipeButtons(context),
              )),
        ],
      );
    }
  }

  /// Build swipe buttons
  Widget swipeButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Rewind profiles
        ///
        /// Go to Disliked Profiles
        cicleButton(
            bgColor: Colors.white,
            padding: 8,
            icon: Icon(Icons.restore, size: 22, color: Colors.grey),
            onTap: () {
              // Go to Disliked Profiles Screen
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DislikedProfilesScreen()));
            }),

        SizedBox(width: 20),

        /// Swipe left and reject user
        cicleButton(
            bgColor: Colors.white,
            padding: 8,
            icon: Icon(Icons.close, size: 35, color: Colors.grey),
            onTap: () {
              /// Get card current index
              final cardIndex = _swipeKey.currentState!.currentIndex;

              /// Check card valid index
              if (cardIndex != -1) {
                /// Swipe left
                _swipeKey.currentState!.swipeLeft();
              }
            }),

        SizedBox(width: 20),

        /// Swipe right and like user
        cicleButton(
            bgColor: Colors.white,
            padding: 8,
            icon: Icon(Icons.favorite_border,
                size: 35, color: Theme.of(context).primaryColor),
            onTap: () async {
              /// Get card current index
              final cardIndex = _swipeKey.currentState!.currentIndex;

              /// Check card valid index
              if (cardIndex != -1) {
                /// Swipe right
                _swipeKey.currentState!.swipeRight();
              }
            }),

        SizedBox(width: 20),

        /// Go to user profile
        cicleButton(
            bgColor: Colors.white,
            padding: 8,
            icon: Icon(Icons.remove_red_eye, size: 22, color: Colors.grey),
            onTap: () {
              /// Get card current index
              final cardIndex = _swipeKey.currentState!.currentIndex;

              /// Check card valid index
              if (cardIndex != -1) {
                /// Get User object
                final User user = User.fromDocument(_users![cardIndex].data()!as Map<String ,dynamic>);

                /// Go to profile screen
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen(user: user, showButtons: false)));

                /// Increment user visits an push notification
                _visitsApi.visitUserProfile(
                  visitedUserId: user.userId,
                  userDeviceToken: user.userDeviceToken,
                  nMessage: "${UserModel().user.userFullname.split(' ')[0]}, "
                      "${_i18n.translate("visited_your_profile_click_and_see")}",
                );
              }
            }),
      ],
    );
  }

  /// Like user function
  Future<void> _likeUser(BuildContext context,
      {required DocumentSnapshot clickedUserDoc}) async {
    /// Check match first
    await _matchesApi.checkMatch(
        userId: clickedUserDoc[USER_ID],
        onMatchResult: (result) {
          if (result) {
            /// It`s match - show dialog to ask user to chat or continue playing
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return ItsMatchDialog(
                    swipeKey: _swipeKey,
                    matchedUser: User.fromDocument(clickedUserDoc.data()! as Map<String, dynamic>),
                  );
                });
          }
        });

    /// like profile
    await _likesApi.likeUser(
        likedUserId: clickedUserDoc[USER_ID],
        userDeviceToken: clickedUserDoc[USER_DEVICE_TOKEN],
        nMessage: "${UserModel().user.userFullname.split(' ')[0]}, "
            "${_i18n.translate("liked_your_profile_click_and_see")}",
        onLikeResult: (result) {
          print('likeResult: $result');
        });
  }
}
