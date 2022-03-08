import 'dart:io';
import 'dart:ui';
import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/dialogs/common_dialogs.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/home_screen.dart';
import 'package:dating_app/widgets/image_source_sheet.dart';
import 'package:dating_app/widgets/linearprogressbar.dart';
import 'package:dating_app/widgets/processing.dart';
import 'package:dating_app/widgets/show_scaffold_msg.dart';
import 'package:dating_app/widgets/svg_icon.dart';
import 'package:dating_app/widgets/terms_of_service_row.dart';
import 'package:dating_app/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/widgets/default_button.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chips_choice/chips_choice.dart';

import '../AppQustions/dating_question.dart';
class intro_up_screen extends StatefulWidget {
  @override
  _intro_up_screenState createState() => _intro_up_screenState();
}

class _intro_up_screenState extends State<intro_up_screen> {
  // Variables
  int tag = 1;
  int taggender = 1;
  List<int> tagm = [];

  // multiple choice value
  List<String> tags = [];

  // list of string options


  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  late PageController _pageController;
  int currentIndex = 0;

  /// User Birthday info
 
 

  // End
  DateTime _initialDateTime = DateTime.now();
  String? _birthday;
  File? _imageFile;
  bool _agreeTerms = false;
  String? _selectedGender;
  List<String> _genders = ['Male', 'Female'];
  late AppLocalizations _i18n;
  int slectedIndex = 0;

  /// Set terms
  void _setAgreeTerms(bool value) {
    setState(() {
      _agreeTerms = value;
    });
  }

  /// Get image from camera / gallery
  

  late List<String> _choices;
  late int _choiceIndex;

  // Get Date time picker app locale
  DateTimePickerLocale _getDatePickerLocale() {
    // Inicial value
    DateTimePickerLocale _locale = DateTimePickerLocale.en_us;

    // Handle your Supported Languages here
    SUPPORTED_LOCALES.forEach((Locale locale) {
      switch (locale.languageCode) {
        case 'en': // English
          _locale = DateTimePickerLocale.en_us;
          break;
        case 'es': // Spanish
          _locale = DateTimePickerLocale.es;
          break;
      }
    });

    return _locale;
  }

  bool reverse = false;

  /// Display date picker.
  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text(_i18n.translate('DONE'),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Theme
                    .of(context)
                    .primaryColor)),
      ),
      minDateTime: DateTime(1920, 1, 1),
      maxDateTime: DateTime.now(),
      initialDateTime: _initialDateTime,
      dateFormat: 'yyyy-MMMM-dd',
      // Date format
      locale: _getDatePickerLocale(),
      // Set your App Locale here
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        // Get birthday info
       
      },
      onConfirm: (dateTime, List<int> index) {
        // Get birthday info
      
      },
    );
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Initialization
    _i18n = AppLocalizations.of(context);
    _birthday = "age";
  }
  @override
  void initState() {
    _pageController = PageController(
        initialPage: 0
    );
    super.initState();
  }

  Widget _widget(Widget ab) {
    return ab;
  }

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
      ) : InkWell(
        onTap: () {
          print("Get Started Now");
          //  _settingModalBottomSheet(context);
           Navigator.push(
             context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
           );

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
                              itemCount: datindQustions().Qheight.length,
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
                                              '${datindQustions()
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
                              itemCount: datindQustions().QMaritalS.length,
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
                                              '${datindQustions()
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
                              itemCount: datindQustions().QMaritalS.length,
                              itemBuilder: (context, index) {
                                return Center(

                                  child: Column(
                                    children: [
                                      Container(height:25,
                                        child: ListTile(
                                            onTap: () {
                                              setState(() {
                                                slectedIndex = index;
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
                                              '${datindQustions()
                                                  .QMaritalS[index]}',style: slectedIndex == index ?TextStyle(color:   APP_PRIMARY_COLOR,):TextStyle(color:
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
                              itemCount: datindQustions().QMaritalS.length,
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
                                              '${datindQustions()
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
                              itemCount: datindQustions().QMaritalS.length,
                              itemBuilder: (context, index) {
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          slectedIndex = index;
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
                                        '${datindQustions()
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
                              itemCount: datindQustions().QMaritalS.length,
                              itemBuilder: (context, index) {
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          slectedIndex = index;
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
                                        '${datindQustions()
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
                            controller: _jobController,

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
                            controller: _jobController,

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
