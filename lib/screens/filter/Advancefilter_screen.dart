import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/dialogs/show_me_dialog.dart';
import 'package:dating_app/dialogs/vip_dialog.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/app_model.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/passport_screen.dart';
import 'package:dating_app/widgets/show_scaffold_msg.dart';
import 'package:dating_app/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Bottomsheet.dart';

class AdvanceFilterScreen extends StatefulWidget {
  @override
  _AdvanceFilterScreenState createState() => _AdvanceFilterScreenState();
}

class _AdvanceFilterScreenState extends State<AdvanceFilterScreen> {
  // Variables
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late RangeValues _selectedAgeRange;
  late RangeLabels _selectedAgeRangeLabels;
  late double _selectedMaxDistance;
  bool _hideProfile = false;
  late AppLocalizations _i18n;
  List<String> marriedstatus =["Single","Single with kids","Divorced","Divorced with kids","Widowed","Widowed with kids","Seperated","Seperated with kids"];
  List<String> Smoke =["yes","No","Planning to Quit","Occasionally "];
  List<String> Education =["Graduate degree","UnderGraduate degree","In college","In grad school","High school","Vocational school","I'm not study","Quit studies  "];
  List<String> Drink =["yes","No","Planning to Quit","Occasionally "];
  List<String> Language =["Hindi","English","Telgu","Tamil","Urdhu","Bangali"];
  List<String> Rowdybaby =["A Relationship or date"," To get Marry","I'm not sure","Something Casul"];

  /// Initialize user settings
  void initUserSettings() {
    // Get user settings
    final Map<String, dynamic> _userSettings = UserModel().user.userSettings!;
    // Update variables state
    setState(() {
      // Get user max distance
      _selectedMaxDistance = _userSettings[USER_MAX_DISTANCE].toDouble();

      // Get age range
      final double minAge = _userSettings[USER_MIN_AGE].toDouble();
      final double maxAge = _userSettings[USER_MAX_AGE].toDouble();

      // Set range values
      _selectedAgeRange = new RangeValues(minAge, maxAge);
      _selectedAgeRangeLabels = new RangeLabels('$minAge', '$maxAge');

      // Check profile status
      if (UserModel().user.userStatus == 'hidden') {
        _hideProfile = true;
      }
    });
  }

  String _showMeOption(AppLocalizations i18n) {
    // Variables
    final Map<String, dynamic> settings = UserModel().user.userSettings!;
    final String? showMe = settings[USER_SHOW_ME];
    // Check option
    if (showMe != null) {
      return i18n.translate(showMe);
    }
    return i18n.translate('opposite_gender');
  }

  @override
  void initState() {
    super.initState();
    initUserSettings();
  }

  // Go to Passport screen
  Future<void> _goToPassportScreen() async {
    // Get picked location result
    LocationResult? result = await Navigator.of(context).push<LocationResult?>(
        MaterialPageRoute(builder: (context) => PassportScreen()));
    // Handle the retur result
    if (result != null) {
      // Update current your location
      _updateUserLocation(true, locationResult: result);
      // Debug info
      print(
          '_goToPassportScreen() -> result: ${result.country!.name}, ${result.city!.name}');
    } else {
      print('_goToPassportScreen() -> result: empty');
    }
  }

  // Update User Location
  Future<void> _updateUserLocation(bool isPassport,
      {LocationResult? locationResult}) async {
    /// Update user location: Country & City an Geo Data

    /// Update user data
    await UserModel().updateUserLocation(
        isPassport: isPassport,
        locationResult: locationResult,
        onSuccess: () {
          // Show success message
          showScaffoldMessage(
              context: context,
              message: _i18n.translate("location_updated_successfully"));
        },
        onFail: () {
          // Show error message
          showScaffoldMessage(
              context: context,
              message:
                  _i18n.translate("we_were_unable_to_update_your_location"));
        });
  }
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    /// Initialization
    _i18n = AppLocalizations.of(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(elevation: 0,
          title: Column(crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text('Advance Filters',style: TextStyle(color: APP_PRIMARY_COLOR),),
              Text('People visible based on this filters selection ',style: TextStyle(color: Colors.grey,fontSize: 11),),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ScopedModelDescendant<UserModel>(
              builder: (context, child, userModel) {
            return Column(
              children: [




                //married
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return BottomSheetSwitch(title: "Married Status",
                    list: marriedstatus,
                    switchValue: _switchValue,
                    valueChanged: (value) {
                      _switchValue = value;
                    },
                  );
                },
              );

                    },
                      trailing: Container(decoration:BoxDecoration(color: Color(0xffDE2657),
                      border: Border.all(
                          width: 0.0
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(25.0) //                 <--- border radius here
                      ),
                    ) ,
                        child: Icon(Icons.add,color: Colors.white,)),
                      title: Text('Marital Status', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),),

                  ),
                ),
                Divider(),
                //smoke
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomSheetSwitch(title: "Smoke",
                            list: Smoke,
                            switchValue: _switchValue,
                            valueChanged: (value) {
                              _switchValue = value;
                            },
                          );
                        },
                      );
                    },
                      trailing: Container(decoration:BoxDecoration(color: Color(0xffDE2657),
                        border: Border.all(
                            width: 0.0
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(25.0) //                 <--- border radius here
                        ),
                      ) ,
                          child: Icon(Icons.add,color: Colors.white,)),
                      title: Text('Smoke', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),),

                  ),
                ),
                Divider(),
                //drink
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomSheetSwitch(title: "Drink",
                            list: Drink,
                            switchValue: _switchValue,
                            valueChanged: (value) {
                              _switchValue = value;
                            },
                          );
                        },
                      );
                    },
                      trailing: Container(decoration:BoxDecoration(color: Color(0xffDE2657),
                        border: Border.all(
                            width: 0.0
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(25.0) //                 <--- border radius here
                        ),
                      ) ,
                          child: Icon(Icons.add,color: Colors.white,)),
                      title: Text('Drink', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),),

                  ),
                ),
                Divider(),
                //Education
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomSheetSwitch(title: "Education",
                            list: Education,
                            switchValue: _switchValue,
                            valueChanged: (value) {
                              _switchValue = value;
                            },
                          );
                        },
                      );
                    },
                      trailing: Container(decoration:BoxDecoration(color: Color(0xffDE2657),
                        border: Border.all(
                            width: 0.0
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(25.0) //                 <--- border radius here
                        ),
                      ) ,
                          child: Icon(Icons.add,color: Colors.white,)),
                      title: Text('Education', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),),

                  ),
                ),
                Divider(),
                //lang
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomSheetSwitch(title: "Langague Speaking",
                            list: Language,
                            switchValue: _switchValue,
                            valueChanged: (value) {
                              _switchValue = value;
                            },
                          );
                        },
                      );
                    },
                      trailing: Container(decoration:BoxDecoration(color: Color(0xffDE2657),
                        border: Border.all(
                            width: 0.0
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(25.0) //                 <--- border radius here
                        ),
                      ) ,
                          child: Icon(Icons.add,color: Colors.white,)),
                      title: Text('Language Speaking?', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),),

                  ),
                ),
                Divider(),
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomSheetSwitch(title: "Why you use Rowdy Baby?",
                            list: Rowdybaby,
                            switchValue: _switchValue,
                            valueChanged: (value) {
                              _switchValue = value;
                            },
                          );
                        },
                      );
                    },
                      trailing: Container(decoration:BoxDecoration(color: Color(0xffDE2657),
                        border: Border.all(
                            width: 0.0
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(25.0) //                 <--- border radius here
                        ),
                      ) ,
                          child: Icon(Icons.add,color: Colors.white,)),
                      title: Text('Why you use rowdy baby?', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),),

                  ),
                ),


                Divider(),



              ],
            );
          }),
        ));
  }
}
