import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/dialogs/common_dialogs.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/AppQustions/dating_question.dart';
import 'package:dating_app/screens/home_screen.dart';
import 'package:dating_app/widgets/image_source_sheet.dart';
import 'package:dating_app/widgets/linearprogressbar.dart';
import 'package:dating_app/widgets/processing.dart';
import 'package:dating_app/widgets/show_scaffold_msg.dart';
import 'package:dating_app/widgets/svg_icon.dart';
import 'package:dating_app/widgets/terms_of_service_row.dart';
import 'package:dating_app/widgets/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/widgets/default_button.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chips_choice/chips_choice.dart';

import '../../widgets/user_gallery.dart';
import '../AppQustions/dating_question.dart';
import 'signintro_up_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Variables
  int tag = 1;
  int taggender = 1;
  List<int> tagm = [];
  // multiple choice value
  List<String> tags = [];
  // list of string options
  TextEditingController _Castesearch = TextEditingController();
  List<String> searchResultCaste = [];
  TextEditingController _Religionsearch = TextEditingController();
  List<String> searchResultReligion = [];
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _schoolController = TextEditingController();
  final _jobController = TextEditingController();
  final _bioController = TextEditingController();
  late PageController _pageController;
  int currentIndex = 0;

  /// User Birthday info
  int _userBirthDay = 0;
  String? userCaste = Qtns().QCaste[0];
  String? userReligion = Qtns().QReligion[0];
  String? userURBB = Qtns().QRowdybaby[0];
  int _userBirthMonth = 0;
  int _userBirthYear = DateTime.now().year;
  // End
  DateTime _initialDateTime = DateTime.now();
  String? _birthday;
  File? _imageFile;
  bool _agreeTerms = false;
  String? _selectedGender;
  List<String> _genders = ['Male', 'Female'];
  late AppLocalizations _i18n;
  int slectedIndex = 0;


  /// Get image from camera / gallery
  void _getImage(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => ImageSourceSheet(
              onImageSelected: (image) {
                if (image != null) {
                  setState(() {
                    _imageFile = image;
                  });
                  // close modal
                  Navigator.of(context).pop();
                }
              },
            ));
  }
  void _updateUserBithdayInfo(DateTime date) {
    setState(() {
      // Update the inicial date
      _initialDateTime = date;
      // Set for label
      _birthday = date.toString().split(' ')[0];
      // User birthday info
      _userBirthDay = date.day;
      _userBirthMonth = date.month;
      _userBirthYear = date.year;
    });
  }
  late List<String> _choices;
  late int _choiceIndex;
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
                color: Theme.of(context).primaryColor)),
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
        _updateUserBithdayInfo(dateTime);
      },
      onConfirm: (dateTime, List<int> index) {
        // Get birthday info
        _updateUserBithdayInfo(dateTime);
      },
    );
  }
  late bool _loading;
  late double _progressValue;
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
  @override
  void initState() {
    _loading = false;
    _progressValue = 0.2;
    _selectedGender = _genders[0];
    _pageController = PageController(initialPage: 0);
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Initialization
    _i18n = AppLocalizations.of(context);
    _birthday = "age";
  }
  //update ptrogress
  void updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.1;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          t.cancel();
          return;
        }
      });
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: APP_PRIMARY_COLOR,
        elevation: 0,
        bottom: PreferredSize(
            //   resizeToAvoidBottomInset: false,
            child: Container(
                height: 50,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.amber),
                      value: _progressValue,
                    ),
                  ),
                )),
            preferredSize: Size.fromHeight(4.0)),
      ),
      bottomSheet: currentIndex != 7
          ? Container(
              height: 120,
              color: APP_PRIMARY_COLOR,
              //  margin: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _pageController.animateToPage(currentIndex - 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    splashColor: Colors.blue[50],
                    child: currentIndex >= 1
                        ? Text(
                            "Back",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )
                        : Text(
                            "",
                            style: TextStyle(
                                color: Color(0xFF0074E4),
                                fontWeight: FontWeight.w600),
                          ),
                  ),
                  FlatButton(
                    onPressed: () {
                      print("this is slideIndex: $currentIndex");
                      _pageController.animateToPage(currentIndex + 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    splashColor: Colors.blue[50],
                    child: Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                                25.0) //                 <--- border radius here
                            ),
                      ),
                      //color:APP_PRIMARY_COLOR ,
                      child: Icon(
                        Icons.arrow_forward,
                        color: APP_PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                setState(() {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => Introscreen(
                                userdata: {
                                  "userPhotoFile": _imageFile!,
                                  "userFullName": _nameController.text.trim(),
                                  "userGender": _selectedGender!,
                                  "userBirthDay": _userBirthDay,
                                  "userBirthMonth": _userBirthMonth,
                                  "userBirthYear": _userBirthYear,
                                  "userSchool": _schoolController.text.trim(),
                                  "usercaste": userCaste!,
                                  "userreligion": userReligion!,
                                  "userURBB": userURBB!
                                },
                              )),
                      (route) => false);
                  //  intro_up_screen
                });
                print("Get Started Now");
              },
              child: Container(
                height: Platform.isIOS ? 70 : 60,
                color: Color(0xffC5204C),
                alignment: Alignment.center,
                child: Text(
                  "GET STARTED NOW",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
      backgroundColor: APP_PRIMARY_COLOR,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            _i18n.translate("fullname"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.060,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              //   labelText: _i18n.translate("fullname"),
                              hintText: "Enter Full Name",
                              hintStyle: TextStyle(color: Colors.white),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (name) {
                              // Basic validation
                              if (name?.isEmpty ?? false) {
                                return _i18n
                                    .translate("please_enter_your_fullname");
                              }
                              return null;
                            },
                          ),
                        ),
                        reverse
                            ? Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Image.asset(
                                        'assets/images/couple2.png'),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
                //gender
                Container(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          _i18n.translate("gender"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),

                      /*  child:CircularCheckBox(
                                value: someBooleanValue,
                                materialTapTargetSize: MaterialTapTargetSize.padded,
                                onChanged: (bool x) {
                                  someBooleanValue = !someBooleanValue;
                                }
                            ),*/
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: Qtns().Qgenderoptions.length,
                          itemBuilder: (context, index) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                ),
                                child: ListTile(
                                    style: ListTileStyle.list,
                                    onTap: () {
                                      setState(() {
                                        slectedIndex = index;
                                      });
                                    },
                                    trailing: slectedIndex == index
                                        ? Icon(Icons.check)
                                        : null,
                                    textColor: Colors.white,
                                    selected:
                                        slectedIndex == index ? true : false,
                                    selectedColor: Colors.amber,
                                    tileColor: Color(0xffC5204C),
                                    selectedTileColor: Colors.white,
                                    title: Text(
                                        '${Qtns().Qgenderoptions[index]}')),
                              ),
                            ));
                          })
                      /* ChipsChoice<int>.single(choiceStyle: C2ChoiceStyle(color: Colors.blueAccent),
                              crossAxisAlignment: CrossAxisAlignment.center,
                              direction: Axis.vertical,
                              spinnerSize: 20,
                              wrapped: true,
                              value: taggender,
                              onChanged: (val) => setState(() { taggender = val;
                              _selectedGender=datindQustions().Qgenderoptions[val];}),
                              choiceItems: C2Choice.listFrom<int, String>(
                                source: datindQustions().Qgenderoptions,
                                value: (i, v) => i,
                                label: (i, v) => v,
                                tooltip: (i, v) => v,
                              ),

                            ),*/
                    ],
                  ),
                )),
                //photo
                UserGallerysign(),
                //birthday

                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "When's your bithday?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 22),
                        Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    color: Colors.grey[350] as Color)),
                            child: ListTile(
                              leading: SvgIcon(
                                "assets/icons/calendar_icon.svg",
                                color: APP_PRIMARY_COLOR,
                              ),
                              title: Text(_birthday!,
                                  style: TextStyle(color: APP_PRIMARY_COLOR)),
                              trailing: Icon(Icons.arrow_drop_down),
                              onTap: () {
                                /// Select birthday
                                _showDatePicker();
                              },
                            )),
                      ],
                    ),
                  ),
                ),
                //who are you interseted in ?
                Container(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Who are you interseted in ?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: Qtns().QIntersetd.length,
                          itemBuilder: (context, index) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      slectedIndex = index;
                                    });
                                  },
                                  trailing: slectedIndex == index
                                      ? Icon(Icons.check)
                                      : null,
                                  textColor: Colors.white,
                                  selected:
                                      slectedIndex == index ? true : false,
                                  selectedColor: Colors.amber,
                                  tileColor: Color(0xffC5204C),
                                  selectedTileColor: Colors.white,
                                  title: Text('${Qtns().QIntersetd[index]}')),
                            ));
                          })
                    ],
                  ),
                )),
                //caste
                Container(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "What's your caste?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Container(
                          height: 50,
                          child: TextFormField(
                            onChanged: onSearchCasteChanged,
                            controller: _Castesearch,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              //   labelText: _i18n.translate("fullname"),
                              hintText: "Search Caste",
                              hintStyle: TextStyle(color: Colors.white),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          searchResultCaste.length > 0 ||
                                  _Castesearch.text.isNotEmpty
                              ? searchResultCaste.length != 0
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: searchResultCaste.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 25,
                                                child: ListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        slectedIndex = index;
                                                        userCaste =
                                                            searchResultCaste[
                                                                index];
                                                      });
                                                    },
                                                    trailing:
                                                        slectedIndex == index
                                                            ? Icon(Icons.check)
                                                            : null,
                                                    textColor: Colors.white,
                                                    selected:
                                                        slectedIndex == index
                                                            ? true
                                                            : false,
                                                    selectedColor: Colors.amber,
                                                    title: Text(
                                                        '${searchResultCaste[index]}')),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Divider(
                                                thickness: 0.2,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ));
                                      })
                                  : Container(
                                      alignment: AlignmentDirectional.center,
                                      margin: EdgeInsets.only(top: 250),
                                      child: Text(
                                        "No Data".toString(),
                                        // 'Doctor Not Found.',
                                        style: TextStyle(
                                            fontSize: width * 0.04,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                              : Qtns().QCaste.length != 0
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: Qtns().QCaste.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 25,
                                                child: ListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        slectedIndex = index;
                                                        userCaste = Qtns()
                                                            .QCaste[index];
                                                      });
                                                    },
                                                    trailing:
                                                        slectedIndex == index
                                                            ? Icon(Icons.check)
                                                            : null,
                                                    textColor: Colors.white,
                                                    selected:
                                                        slectedIndex == index
                                                            ? true
                                                            : false,
                                                    selectedColor: Colors.amber,
                                                    title: Text(
                                                        '${Qtns().QCaste[index]}')),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Divider(
                                                thickness: 0.2,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ));
                                      })
                                  : Container(
                                      alignment: AlignmentDirectional.center,
                                      margin: EdgeInsets.only(top: 250),
                                      child: Text(
                                        "No Data".toString(),
                                        // 'Doctor Not Found.',
                                        style: TextStyle(
                                            fontSize: width * 0.04,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                        ],
                      )
                    ],
                  ),
                )),
                //Religion
                Container(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "What's your Religion ?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Container(
                          height: 50,
                          child: TextFormField(
                            onChanged: onSearchReligionChanged,
                            controller: _Religionsearch,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              //   labelText: _i18n.translate("fullname"),
                              hintText: "Search Religion",
                              hintStyle: TextStyle(color: Colors.white),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ),
                      ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          searchResultReligion.length > 0 ||
                                  _Religionsearch.text.isNotEmpty
                              ? searchResultReligion.length != 0
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: searchResultReligion.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 25,
                                                child: ListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        slectedIndex = index;
                                                        userReligion =
                                                            searchResultReligion[
                                                                index];
                                                      });
                                                    },
                                                    trailing:
                                                        slectedIndex == index
                                                            ? Icon(Icons.check)
                                                            : null,
                                                    textColor: Colors.white,
                                                    selected:
                                                        slectedIndex == index
                                                            ? true
                                                            : false,
                                                    selectedColor: Colors.amber,
                                                    title: Text(
                                                      '${searchResultReligion[index]}',
                                                      textAlign:
                                                          TextAlign.start,
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Divider(
                                                thickness: 0.2,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ));
                                      })
                                  : Container(
                                      alignment: AlignmentDirectional.center,
                                      margin: EdgeInsets.only(top: 250),
                                      child: Text(
                                        "No Data".toString(),
                                        // 'Doctor Not Found.',
                                        style: TextStyle(
                                            fontSize: width * 0.04,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                              : Qtns().QReligion.length != 0
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: Qtns().QReligion.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 25,
                                                child: ListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        slectedIndex = index;
                                                        userReligion = Qtns()
                                                            .QReligion[index];
                                                      });
                                                    },
                                                    trailing:
                                                        slectedIndex == index
                                                            ? Icon(Icons.check)
                                                            : null,
                                                    textColor: Colors.white,
                                                    selected:
                                                        slectedIndex == index
                                                            ? true
                                                            : false,
                                                    selectedColor: Colors.amber,
                                                    title: Text(
                                                      '${Qtns().QReligion[index]}',
                                                      textAlign:
                                                          TextAlign.start,
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Divider(
                                                thickness: 0.2,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ));
                                      })
                                  : Container(
                                      alignment: AlignmentDirectional.center,
                                      margin: EdgeInsets.only(top: 250),
                                      child: Text(
                                        "No Data".toString(),
                                        // 'Doctor Not Found.',
                                        style: TextStyle(
                                            fontSize: width * 0.04,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                        ],
                      )
                    ],
                  ),
                )),
                //
                Container(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Why you use rowdy baby?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: Qtns().QRowdybaby.length,
                          itemBuilder: (context, index) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      slectedIndex = index;
                                      userURBB = Qtns().QRowdybaby[index];
                                    });
                                  },
                                  trailing: slectedIndex == index
                                      ? Icon(Icons.check)
                                      : null,
                                  textColor: Colors.white,
                                  selected:
                                      slectedIndex == index ? true : false,
                                  selectedColor: Colors.amber,
                                  tileColor: Color(0xffC5204C),
                                  selectedTileColor: Colors.white,
                                  title: Text('${Qtns().QRowdybaby[index]}')),
                            ));
                          })
                    ],
                  ),
                )),
                //job
              ],
            ),
          ],
        );
      }),
    );
  }

  onSearchCasteChanged(String text) async {
    searchResultCaste.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    Qtns().QCaste.forEach((castedata) {
      if (castedata.toLowerCase().contains(text.toLowerCase()))
        searchResultCaste.add(castedata);
    });

    setState(() {});
  }

  onSearchReligionChanged(String text) async {
    searchResultReligion.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    Qtns().QReligion.forEach((religiondata) {
      if (religiondata.toLowerCase().contains(text.toLowerCase()))
        searchResultReligion.add(religiondata);
    });

    setState(() {});
  }

  /// Handle Create account

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              : SizedBox(),
          Text(
            title,
            style: TextStyle(
                color: primarq, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          reverse
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }


}
