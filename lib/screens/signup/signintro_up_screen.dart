import 'dart:io';
import 'dart:ui';
import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/dialogs/common_dialogs.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/home_screen.dart';
import 'package:dating_app/widgets/linearprogressbar.dart';
import 'package:dating_app/widgets/processing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../AppQustions/dating_question.dart';

class Introscreen extends StatefulWidget {
  final   Map<String ,dynamic>   userdata;
  const Introscreen({Key? key, required this.userdata,}) : super(key: key);
  @override
  createState() => _Intro_up_screenState();
}

class _Intro_up_screenState extends State<Introscreen> {
  // Variables
  int tag = 1;
  int taggender = 1;
  List<int> tagm = [];
  // multiple choice value
  List<String> tags = [];
  // list of string options
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;
  int currentIndex = 0;
  /// User Birthday info
 
 
  // End
  String? _selectedGender;
  List<String> _genders = ['Male', 'Female'];
  late AppLocalizations _i18n;
  int slectedIndex = 0;

  /// Set terms


  /// Get image from camera / gallery
  

  late List<String> _choices;
  late int _choiceIndex;

  final userBioController = TextEditingController();
  final jobController = TextEditingController();

  bool reverse = false;

  /// Display date picker.

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Initialization
    _i18n = AppLocalizations.of(context);

  }
  @override
  void initState() {
widget.userdata;
    _pageController = PageController(
        initialPage: 0

    );
    super.initState();
  }

  Widget _widget(Widget ab) {
    return ab;
  }
 String? userMarriedSatus= Qtns().QMaritalS[0];
  List<String>?  userLanguage=[];
  String? userEducation=Qtns().QIntersetd[0];
  String? userHeight=Qtns().Qheight[0];
  String? usersmoke=Qtns().QSmoke[0];
  String? userdrink=Qtns().QMaritalS[0];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold
      (
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0, bottom: PreferredSize(
          child: Container(height: 50,
              child: LinearProgressIndicatorApp()),

          preferredSize: Size.fromHeight(4.0)),
      ),
      bottomSheet: currentIndex != 8 ? Container(height:120,
        color: Colors.white,
        //margin: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                _pageController.animateToPage(
                    currentIndex - 1, duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              splashColor: Colors.blue[50],
              child: currentIndex >= 1 ? Text(
                "Skip",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ) : Text(
                "",
                style: TextStyle(
                    color: Color(0xFF0074E4), fontWeight: FontWeight.w600),

              ),),

            FlatButton(
              onPressed: () {
                print("this is slideIndex: $currentIndex");
                _pageController.animateToPage(
                    currentIndex + 1, duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              splashColor: Colors.blue[50],
              child: Container(height: 50,width: 50,
                decoration: BoxDecoration(color:Colors.amber,

                borderRadius: BorderRadius.all(
                    Radius.circular(25.0) //                 <--- border radius here
                ),
              ),
                child: Icon(Icons.arrow_forward, color:Colors.white,),
              ),
            ),
          ],
        ),
      ) :
      InkWell(
        onTap: () {
          print("Get Started Now");
          //  _settingModalBottomSheet(context);
          _createAccount();



        },
        child: Container(
          height: Platform.isIOS ? 70 : 60,
          color:  Color(0xffC5204C),
          alignment: Alignment.center,
          child: Text(
            "GET STARTED NOW",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      backgroundColor: Colors.white,
      key: _scaffoldKey,

      body: ScopedModelDescendant<UserModel>(
          builder: (context, child, userModel) {
            /// Check loading status
            if (userModel.isLoading) return Processing();
            return Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                PageView(
                  onPageChanged: (int page) {
                    setState(() {
                      currentIndex = page;
                    });
                  },
                  controller: _pageController,
                  children: <Widget>[
                    //name
                    Container(

                      child:
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/4.0x/Rowdycon.png',width: 80,height: 80,),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text("Attractive choices, keep it up",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 25,
                                    color: Color(0xffC5204C),
                                    fontWeight: FontWeight.bold),),

                            ),

                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text("your baby need your little more \ndetails like your height, smoke,\ndrink etc...",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),),

                            ),
                            SizedBox(height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.060,),





                          ],
                        ),
                      ),

                    ),
                    //Height
                    Container(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text("What's your height ?",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 30,
                                  color:   Color(0xffC5204C),
                                  fontWeight: FontWeight.bold),),

                          ),

                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.020,),


                          ListView.builder(
                              shrinkWrap: true, scrollDirection: Axis.vertical,
                              itemCount: Qtns().Qheight.length,
                              itemBuilder: (context, index) {
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:Column(
                                    children: [
                                      Container(height:20,
                                        child: ListTile(
                                            onTap: () {
                                              setState(() {
                                                slectedIndex = index;
                                                userHeight=Qtns().Qheight[index];
                                              });
                                            },
                                            trailing: slectedIndex == index ? Icon(
                                                Icons.check) : null,
                                            textColor: Colors.white,
                                            selected: slectedIndex == index
                                                ? true
                                                : false,

                                            selectedColor: APP_PRIMARY_COLOR,
                                            // tileColor: Color(0xffC5204C),


                                            title:  Text(
                                              '${Qtns()
                                                  .Qheight[index]}',style: TextStyle(color: Colors.black),)),
                                      ),

                                      SizedBox(height: 10,),
                                      Divider()
                                    ],
                                  ),
                                ),
                                );
                              })



                        ],

                      ),
                    )),
                    //who are you interseted in ?
                    Container(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text("Marital status",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 35,
                                  color: Color(0xffC5204C),
                                  fontWeight: FontWeight.bold),),

                          ),

                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.020,),


                          ListView.builder(
                              shrinkWrap: true, scrollDirection: Axis.vertical,
                              itemCount: Qtns().QMaritalS.length,
                              itemBuilder: (context, index) {
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(height: 25,
                                        child: ListTile(
                                            onTap: () {
                                              setState(() {
                                                slectedIndex = index;
                                                userMarriedSatus=Qtns().QMaritalS[index];
                                              });
                                            },
                                            trailing: slectedIndex == index ? Icon(
                                                Icons.check) : null,
                                            textColor: Colors.white,
                                            selected: slectedIndex == index
                                                ? true
                                                : false,

                                            selectedColor: Colors.amber,
                                            // tileColor: Color(0xffC5204C),


                                            title:  Text(
                                              '${Qtns()
                                                  .QMaritalS[index]}',style: TextStyle(color: Colors.black),)),
                                      ),
                                      SizedBox(height: 5,),
                                      Divider()
                                    ],
                                  ),),
                                );
                              })


                        ],

                      ),
                    )),
//caste
                    //Do you Smoke  ?
                    Container(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text("Do you smoke?",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 35,
                                  color: Color(0xffC5204C),
                                  fontWeight: FontWeight.bold),),

                          ),

                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.020,),


                          ListView.builder(
                              shrinkWrap: true, scrollDirection: Axis.vertical,
                              itemCount: Qtns().QSmoke.length,
                              itemBuilder: (context, index) {
                                return Center(

                                  child: Column(
                                    children: [
                                      Container(height:25,
                                        child: ListTile(
                                            onTap: () {
                                              setState(() {
                                                slectedIndex = index;
                                                usersmoke=Qtns().QSmoke[index];
                                              });
                                            },
                                            trailing: slectedIndex == index ? Icon(
                                                Icons.check) : null,
                                            textColor: Colors.white,
                                            selected: slectedIndex == index
                                                ? true
                                                : false,

                                            selectedColor: APP_PRIMARY_COLOR,
                                            // tileColor: Color(0xffC5204C),


                                            title:  Text(
                                              '${Qtns()
                                                  .QSmoke[index]}',style: slectedIndex == index ?TextStyle(color:   APP_PRIMARY_COLOR,):TextStyle(color:
                                            Colors.black,),
                                            )),
                                      ),
                                      SizedBox(height: 8,),
                                      Divider()
                                    ],
                                  ),
                                );
                              })


                        ],

                      ),
                    )),
                    Container(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text("Do you drink?",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 35,
                                  color: Color(0xffC5204C),
                                  fontWeight: FontWeight.bold),),

                          ),

                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.020,),


                          ListView.builder(
                              shrinkWrap: true, scrollDirection: Axis.vertical,
                              itemCount: Qtns().QMaritalS.length,
                              itemBuilder: (context, index) {
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    children: [
                                      Container(height:25,
                                        child: ListTile(
                                            onTap: () {
                                              setState(() {
                                                slectedIndex = index;
                                               userdrink= Qtns().QMaritalS[index];
                                              });
                                            },
                                            trailing: slectedIndex == index ? Icon(
                                                Icons.check) : null,
                                            textColor: Colors.white,
                                            selected: slectedIndex == index
                                                ? true
                                                : false,

                                            selectedColor: APP_PRIMARY_COLOR,
                                            // tileColor: Color(0xffC5204C),


                                            title:  Text(
                                              '${Qtns()
                                                  .QMaritalS[index]}',style: slectedIndex == index ?TextStyle(color: APP_PRIMARY_COLOR):TextStyle(color: Colors.black),)),
                                      ),
                                      SizedBox(height: 8,),
                                      Divider()
                                    ],
                                  ),),
                                );
                              })


                        ],

                      ),
                    )),
                    Container(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text("Languages speak? ",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 35,
                                  color: Color(0xffC5204C),
                                  fontWeight: FontWeight.bold),),

                          ),

                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.020,),


                          ListView.builder(
                              shrinkWrap: true, scrollDirection: Axis.vertical,
                              itemCount: Qtns().QMaritalS.length,
                              itemBuilder: (context, index) {
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          slectedIndex = index;
                                          userLanguage= [Qtns().QMaritalS[index]];
                                        });
                                      },
                                      trailing: slectedIndex == index ? Icon(
                                          Icons.check) : null,
                                      textColor: Colors.white,
                                      selected: slectedIndex == index
                                          ? true
                                          : false,

                                      selectedColor: APP_PRIMARY_COLOR,
                                      // tileColor: Color(0xffC5204C),


                                      title:  Text(
                                        '${Qtns()
                                            .QMaritalS[index]}',style: slectedIndex == index ?TextStyle(color:   APP_PRIMARY_COLOR,):TextStyle(color:
                                      Colors.black,),)),),
                                );
                              })


                        ],

                      ),
                    )),
                    Container(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text("What's your education? ",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 35,
                                  color: Color(0xffC5204C),
                                  fontWeight: FontWeight.bold),),

                          ),

                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.020,),


                          ListView.builder(
                              shrinkWrap: true, scrollDirection: Axis.vertical,
                              itemCount: Qtns().QMaritalS.length,
                              itemBuilder: (context, index) {
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          slectedIndex = index;
                                          userEducation= Qtns().QMaritalS[index];
                                        });
                                      },
                                      trailing: slectedIndex == index ? Icon(
                                          Icons.check) : null,
                                      textColor: Colors.white,
                                      selected: slectedIndex == index
                                          ? true
                                          : false,

                                      selectedColor: APP_PRIMARY_COLOR,
                                      // tileColor: Color(0xffC5204C),


                                      title:  Text(
                                        '${Qtns()
                                            .QMaritalS[index]}',style: slectedIndex == index ?TextStyle(color: APP_PRIMARY_COLOR):TextStyle(color: Colors.black),)),),
                                );
                              })


                        ],

                      ),
                    )),
                    //job
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text("Your job ",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 35,
                                  color: Color(0xffC5204C),
                                  fontWeight: FontWeight.bold),),

                          ),

                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.020,),

                          TextFormField(
                            controller: jobController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(

                              filled: true,
                              hoverColor: Color(0xffC5204C),

                              errorStyle: TextStyle(fontSize: 16),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color:  Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color:  Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              focusColor:  Color(0xffC5204C) ,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:   Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),



                                fillColor: Colors.black12,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),

                                hintText: "ex : Software Engineer",
                                hintStyle: TextStyle(color: Colors.grey),
                                floatingLabelBehavior: FloatingLabelBehavior.always,

                            ),
                          ),
                        ],
                      ),
                    ),
                    //Bio
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text("About me ",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 35,
                                  color: Color(0xffC5204C),
                                  fontWeight: FontWeight.bold),),

                          ),

                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.020,),

                          TextFormField(maxLines: 10,
                            maxLength: 300,
                            style: TextStyle(color: Colors.black),
                            controller: userBioController,

                            decoration: InputDecoration(

                              filled: true,
                              hoverColor: Colors.black12,

                              errorStyle: TextStyle(fontSize: 16),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                  width: 2.0,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                  width: 2.0,
                                ),
                              ),
                              focusColor: Colors.black12,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:  Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),



                              fillColor: Colors.black12,
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),

                              hintText: "Type Here",
                              hintStyle: TextStyle(color: Colors.grey),
                              floatingLabelBehavior: FloatingLabelBehavior.always,

                            ),
                          ),
                        ],
                      ),
                    ),

                  ],

                ),


              ],
            );
          }),
    );
  }
  void _createAccount() async {
    /// check image file
    /*  if (_imageFile == null) {
      // Show error message
      showScaffoldMessage(
          context: context,
          message: _i18n.translate("please_select_your_profile_photo"),
          bgcolor: Colors.red);
      // validate terms
    } else if (!_agreeTerms) {
      // Show error message
      showScaffoldMessage(
          context: context,
          message: _i18n.translate("you_must_agree_to_our_privacy_policy"),
          bgcolor: Colors.red);

      /// Validate form
    } else if (UserModel().calculateUserAge(_initialDateTime) < 18) {
      // Show error message
      showScaffoldMessage(
          context: context,
          duration: Duration(seconds: 7),
          message: _i18n.translate(
              "only_18_years_old_and_above_are_allowed_to_create_an_account"),
          bgcolor: Colors.red);
    } *//*else if (*//**//*!_formKey.currentState!.validate()*//**//*) {
    }*//*
    else {*/
    /// Call all input onSaved method
    //  _formKey.currentState!.save();

    /// Call sign up method
    UserModel().signUp(
        userPhotoFile:widget.userdata['userPhotoFile'],
        userFullName: widget.userdata['userFullName'],
        userGender: widget.userdata['userGender'],
        userBirthDay: widget.userdata['userBirthDay'],
        userBirthMonth: widget.userdata['userBirthMonth'],
        userBirthYear: widget.userdata['userBirthYear'],
        userSchool: widget.userdata['userSchool'],
        userJobTitle:jobController.text ,
        userBio: userBioController.text,
        userMarriedSatus: userMarriedSatus!,
        userReligion: widget.userdata['userreligion'],
        userURBB:  widget.userdata['userURBB'],
        userLanguage: userLanguage!,
        userEducation: userEducation!,
        userHeight: userHeight!,
        usersmoke: usersmoke!,
        userdrink: userdrink!,
        userCaste: widget.userdata['usercaste'],
        onSuccess: () async {
          // Show success message
          successDialog(context,
              message: _i18n
                  .translate("your_account_has_been_created_successfully"),
              positiveAction: () {
                // Execute action
                _goToHomeScreen();
              });
        },
        onFail: (error) {
          // Debug error
          debugPrint(error);
          // Show error message
          errorDialog(context,
              message: _i18n.translate("an_error_occurred_while_creating_your_account"));
        },
       );

  }
  void _goToHomeScreen() {
    /// Go to home screen
    Future(() {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false);
    });
  }
  /*void _saveChanges() {
    /// Update uer profile
    UserModel().updateProfile(
        userSchool: _schoolController.text.trim(),
        userJobTitle: _jobController.text.trim(),
        userBio: _bioController.text.trim(),
        onSuccess: () {
          /// Show success message
          successDialog(context,
              message: _i18n.translate("profile_updated_successfully"),
              positiveAction: () {
                /// Close dialog
                Navigator.of(context).pop();

                /// Go to profilescreen
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen(user: UserModel().user, showButtons: false)));
              });
        },
        onFail: (error) {
          // Debug error
          debugPrint(error);
          // Show error message
          errorDialog(context,
              message: _i18n
                  .translate("an_error_occurred_while_updating_your_profile"));
        });
  }*/
}
