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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/widgets/default_button.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chips_choice/chips_choice.dart';

import '../AppQustions/dating_question.dart';
import 'signintro_up_screen.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Variables
  int tag = 1;
  int taggender=1;
 List<int> tagm= [];
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
   int slectedIndex=0;
  /// Set terms
  void _setAgreeTerms(bool value) {
    setState(() {
      _agreeTerms = value;
    });
  }

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
                color: Theme.of(context).primaryColor)),
      ),
      minDateTime: DateTime(1920, 1, 1),
      maxDateTime: DateTime.now(),
      initialDateTime: _initialDateTime,
      dateFormat: 'yyyy-MMMM-dd', // Date format
      locale: _getDatePickerLocale(), // Set your App Locale here
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Initialization
    _i18n = AppLocalizations.of(context);
    _birthday = "age";
  }
  @override
  void initState() {
    _selectedGender=_genders[0];
    _pageController = PageController(
        initialPage: 0
    );
    super.initState();
  }
Widget _widget(Widget ab){
    return ab;
}

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
 double   height= MediaQuery.of(context).size.height;
 double   width= MediaQuery.of(context).size.width;
    return Scaffold
      (appBar: AppBar(backgroundColor: APP_PRIMARY_COLOR,elevation: 0,bottom:PreferredSize(
        child:  Container(height: 50,
            child: LinearProgressIndicatorApp()),

        preferredSize: Size.fromHeight(4.0)),
    ),
      bottomSheet:currentIndex != 7 ?
      Container(height: 120,
        color: APP_PRIMARY_COLOR,
    //  margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: (){
              _pageController.animateToPage(currentIndex - 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
            },
            splashColor: Colors.blue[50],
            child: currentIndex >= 1 ? Text(
              "Back",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ):Text(
              "",
              style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),

            ),),

          FlatButton(
            onPressed: (){
              print("this is slideIndex: $currentIndex");
              _pageController.animateToPage(currentIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
            },
            splashColor: Colors.blue[50],
            child:  Container(width: 50,height: 50,
              decoration: BoxDecoration(color: Colors.white,

              borderRadius: BorderRadius.all(
                  Radius.circular(25.0) //                 <--- border radius here
              ),
            ),
              //color:APP_PRIMARY_COLOR ,
              child:Icon(Icons.arrow_forward,color:APP_PRIMARY_COLOR ,),
            ),
          ),
        ],
      ),
    ): InkWell(
      onTap: (){

        setState(() { _createAccount();
       /*   Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => intro_up_screen()),
                (route) => false);*/
        //  intro_up_screen
        });
        print("Get Started Now");


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

              child:
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [


                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(_i18n.translate("fullname"),
                            textAlign: TextAlign.center,style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),

                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*0.060,),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                             //   labelText: _i18n.translate("fullname"),
                                hintText: "Enter Full Name",
                                hintStyle: TextStyle(color: Colors.white),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                               ),
                            validator: (name) {
                              // Basic validation
                              if (name?.isEmpty ?? false) {
                                return _i18n.translate("please_enter_your_fullname");
                              }
                              return null;
                            },
                          ),
                        ),
                        reverse ? Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Image.asset('assets/images/couple2.png'),
                            ),
                            SizedBox(height: 30,),
                          ],
                        ) : SizedBox(),


                      ],
                    ),
                  ),

                ),
                //gender
                Container(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(_i18n.translate("gender"),
                              textAlign: TextAlign.center,style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),

                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*0.020,),

                          /*  child:CircularCheckBox(
                                value: someBooleanValue,
                                materialTapTargetSize: MaterialTapTargetSize.padded,
                                onChanged: (bool x) {
                                  someBooleanValue = !someBooleanValue;
                                }
                            ),*/
                            ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,
                                itemCount:datindQustions().Qgenderoptions.length ,
                          itemBuilder: (context,index){
                              return Center(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(decoration:BoxDecoration(

                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0) //                 <--- border radius here
                                  ),
                                ) ,
                                  child: ListTile(style: ListTileStyle.list,
                                    onTap: (){
                                    setState(() {
                                      slectedIndex =index;
                                    });
                                  },
trailing:slectedIndex==index?Icon(Icons.check):null ,
                                    textColor: Colors.white,
                                    selected: slectedIndex==index?true:false,

                                    selectedColor: Colors.amber,
                                    tileColor: Color(0xffC5204C),

                       selectedTileColor:Colors.white,
                                    title:  Text('${datindQustions().Qgenderoptions[index]}')),
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
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Profile photo

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Add Your Photos',
                        textAlign: TextAlign.center,style: TextStyle(fontSize: 32 ,color: Colors.white,fontWeight: FontWeight.bold),


                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView(  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0
                      ),
                      //  scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Center(
                                  child: _imageFile == null
                                      ? Container(
                                    decoration: BoxDecoration( color: Colors.white,


                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0) //                 <--- border radius here
                                    ),
                                  ),
                                    height: 130,width: 100,
                                   // radius: 60,

                                    child: Padding(
                                      padding: const EdgeInsets.all(33.0),
                                      child: Container(height: 20,width: 20,
                                        child: SvgIcon("assets/icons/camera_icon.svg",
                                            width: 40, height: 40, color: Colors.amber),
                                      ),
                                    ),
                                  )
                                      : CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(_imageFile!),
                                  )),
                              onTap: () {
                                /// Get profile image
                                _getImage(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Center(
                                  child: _imageFile == null
                                      ? Container(
                                    decoration: BoxDecoration( color: Colors.white,


                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0) //                 <--- border radius here
                                      ),
                                    ),
                                    height: 130,width: 100,
                                    // radius: 60,

                                    child: Padding(
                                      padding: const EdgeInsets.all(33.0),
                                      child: Container(height: 20,width: 20,
                                        child: SvgIcon("assets/icons/camera_icon.svg",
                                            width: 40, height: 40, color: Colors.amber),
                                      ),
                                    ),
                                  )
                                      : CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(_imageFile!),
                                  )),
                              onTap: () {
                                /// Get profile image
                                _getImage(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Center(
                                  child: _imageFile == null
                                      ? Container(
                                    decoration: BoxDecoration( color: Colors.white,


                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0) //                 <--- border radius here
                                      ),
                                    ),
                                    height: 130,width: 100,
                                    // radius: 60,

                                    child: Padding(
                                      padding: const EdgeInsets.all(33.0),
                                      child: Container(height: 20,width: 20,
                                        child: SvgIcon("assets/icons/camera_icon.svg",
                                            width: 40, height: 40, color: Colors.amber),
                                      ),
                                    ),
                                  )
                                      : CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(_imageFile!),
                                  )),
                              onTap: () {
                                /// Get profile image
                                _getImage(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Center(
                                  child: _imageFile == null
                                      ? Container(
                                    decoration: BoxDecoration( color: Colors.white,


                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0) //                 <--- border radius here
                                      ),
                                    ),
                                    height: 130,width: 100,
                                    // radius: 60,

                                    child: Padding(
                                      padding: const EdgeInsets.all(33.0),
                                      child: Container(height: 20,width: 20,
                                        child: SvgIcon("assets/icons/camera_icon.svg",
                                            width: 40, height: 40, color: Colors.amber),
                                      ),
                                    ),
                                  )
                                      : CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(_imageFile!),
                                  )),
                              onTap: () {
                                /// Get profile image
                                _getImage(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Center(
                                  child: _imageFile == null
                                      ? Container(
                                    decoration: BoxDecoration( color: Colors.white,


                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0) //                 <--- border radius here
                                      ),
                                    ),
                                    height: 130,width: 100,
                                    // radius: 60,

                                    child: Padding(
                                      padding: const EdgeInsets.all(33.0),
                                      child: Container(height: 20,width: 20,
                                        child: SvgIcon("assets/icons/camera_icon.svg",
                                            width: 40, height: 40, color: Colors.amber),
                                      ),
                                    ),
                                  )
                                      : CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(_imageFile!),
                                  )),
                              onTap: () {
                                /// Get profile image
                                _getImage(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Center(
                                  child: _imageFile == null
                                      ? Container(
                                    decoration: BoxDecoration( color: Colors.white,


                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0) //                 <--- border radius here
                                      ),
                                    ),
                                    height: 130,width: 100,
                                    // radius: 60,

                                    child: Padding(
                                      padding: const EdgeInsets.all(33.0),
                                      child: Container(height: 20,width: 20,
                                        child: SvgIcon("assets/icons/camera_icon.svg",
                                            width: 40, height: 40, color: Colors.amber),
                                      ),
                                    ),
                                  )
                                      : CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(_imageFile!),
                                  )),
                              onTap: () {
                                /// Get profile image
                                _getImage(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Center(
                                  child: _imageFile == null
                                      ? Container(
                                    decoration: BoxDecoration( color: Colors.white,


                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0) //                 <--- border radius here
                                      ),
                                    ),
                                    height: 130,width: 100,
                                    // radius: 60,

                                    child: Padding(
                                      padding: const EdgeInsets.all(33.0),
                                      child: Container(height: 20,width: 20,
                                        child: SvgIcon("assets/icons/camera_icon.svg",
                                            width: 40, height: 40, color: Colors.amber),
                                      ),
                                    ),
                                  )
                                      : CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(_imageFile!),
                                  )),
                              onTap: () {
                                /// Get profile image
                                _getImage(context);
                              },
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
                //birthday
               Container(

                  child:
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("When's your bithday?",
                          textAlign: TextAlign.start,style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),


                        ),
                        SizedBox(height: 22),
                        Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.grey[350] as Color)),
                            child: ListTile(
                              leading: SvgIcon("assets/icons/calendar_icon.svg",color:APP_PRIMARY_COLOR ,),
                              title: Text(_birthday!,
                                  style: TextStyle(color:  APP_PRIMARY_COLOR)),
                              trailing: Icon(Icons.arrow_drop_down),
                              onTap: () {
                                /// Select birthday
                                _showDatePicker();
                              },
                            )),
                      ],),
                  ),
                ),
                //who are you interseted in ?
                Container(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("Who are you interseted in ?",
                          textAlign: TextAlign.center,style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),),

                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*0.020,),


                      ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,
                          itemCount:datindQustions().QIntersetd.length ,
                          itemBuilder: (context,index){
                            return Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(onTap: (){
                                setState(() {
                                  slectedIndex =index;
                                });
                              },
                                trailing:slectedIndex==index?Icon(Icons.check):null ,
                                textColor: Colors.white,
                                selected: slectedIndex==index?true:false,

                                selectedColor: Colors.amber,
                                tileColor: Color(0xffC5204C),

                                selectedTileColor:Colors.white,
                                title:  Text('${datindQustions().QIntersetd[index]}')),
                            ));

                          })




                    ],

                  ),
                )),
               //caste
                Container(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("What's your caste?",
                          textAlign: TextAlign.center,style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),

                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*0.020,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Container(height: 50,
                          child: TextFormField(
                            onChanged: onSearchCasteChanged,
                            controller: _Castesearch,
                            decoration: InputDecoration(suffixIcon: Icon(Icons.search,color: Colors.white,),
                              //   labelText: _i18n.translate("fullname"),
                              hintText: "Search Caste",
                              hintStyle: TextStyle(color: Colors.white),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),

                          ),
                        ),
                      ),
                      
                      ListView(shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          searchResultCaste.length > 0 || _Castesearch.text.isNotEmpty
                              ? searchResultCaste.length != 0  ?ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,
                              itemCount:searchResultCaste.length ,
                              itemBuilder: (context,index){
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(height:25,
                                        child: ListTile(onTap: (){
                                          setState(() {
                                            slectedIndex =index;
                                          });
                                        },
                                            trailing:slectedIndex==index?Icon(Icons.check):null ,
                                            textColor: Colors.white,
                                            selected: slectedIndex==index?true:false,

                                            selectedColor: Colors.amber,


                                            title:  Text('${searchResultCaste[index]}')),
                                      ),

                                      SizedBox(height: 8,),
                                      Divider(thickness: 0.2,color: Colors.white,)
                                    ],
                                  ),
                                ));

                              }) :
                          Container(
                            alignment: AlignmentDirectional.center,
                            margin: EdgeInsets.only(top: 250),
                            child: Text(
                            "No Data"
                                  .toString(),
                              // 'Doctor Not Found.',
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ):datindQustions().QCaste.length!=0?
                          ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,
                              itemCount:datindQustions().QCaste.length ,
                              itemBuilder: (context,index){
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(height:25,
                                        child: ListTile(onTap: (){
                                          setState(() {
                                            slectedIndex =index;
                                          });
                                        },
                                          trailing:slectedIndex==index?Icon(Icons.check):null ,
                                          textColor: Colors.white,
                                          selected: slectedIndex==index?true:false,

                                          selectedColor: Colors.amber,


                                          title:  Text('${datindQustions().QCaste[index]}')),
                                      ),

                                      SizedBox(height: 8,),
                                      Divider(thickness: 0.2,color: Colors.white,)
                                    ],
                                  ),
                                ));

                              }):
                          Container(
                            alignment: AlignmentDirectional.center,
                            margin: EdgeInsets.only(top: 250),
                            child: Text(
                              "No Data"
                                  .toString(),
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
                //religion
                Container(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("What's your Religion ?",
                          textAlign: TextAlign.start,style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),),

                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*0.020,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Container(height: 50,
                          child: TextFormField(onChanged:  onSearchReligionChanged,
                            controller: _Religionsearch,
                            decoration: InputDecoration(suffixIcon: Icon(Icons.search,color: Colors.white,),
                              //   labelText: _i18n.translate("fullname"),
                              hintText: "Search Religion",
                              hintStyle: TextStyle(color: Colors.white),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),

                          ),
                        ),
                      ),
                      ListView(scrollDirection: Axis.vertical,shrinkWrap: true,
                        children: [  searchResultReligion.length > 0 || _Religionsearch.text.isNotEmpty
                            ? searchResultReligion.length != 0  ?
                          ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,
                              itemCount:searchResultReligion.length ,
                              itemBuilder: (context,index){
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(height:25,
                                        child: ListTile(onTap: (){
                                          setState(() {
                                            slectedIndex =index;
                                          });
                                        },
                                          trailing:slectedIndex==index?Icon(Icons.check):null ,
                                          textColor: Colors.white,
                                          selected: slectedIndex==index?true:false,

                                          selectedColor: Colors.amber,



                                          title: Text('${searchResultReligion[index]}',textAlign: TextAlign.start,)),
                                      ),
                                      SizedBox(height: 8,),
                                      Divider(thickness: 0.2,color: Colors.white,)
                                    ],
                                  ),
                                ));

                              }):  Container(
            alignment: AlignmentDirectional.center,
            margin: EdgeInsets.only(top: 250),
            child: Text(
            "No Data"
                .toString(),
            // 'Doctor Not Found.',
            style: TextStyle(
            fontSize: width * 0.04,
            color: Colors.grey,
            fontWeight: FontWeight.bold),
            ),
            ):
                        datindQustions().QReligion.length!=0? ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,
                              itemCount:datindQustions().QReligion.length ,
                              itemBuilder: (context,index){
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(height:25,
                                        child: ListTile(onTap: (){
                                          setState(() {
                                            slectedIndex =index;
                                          });
                                        },
                                            trailing:slectedIndex==index?Icon(Icons.check):null ,
                                            textColor: Colors.white,
                                            selected: slectedIndex==index?true:false,

                                            selectedColor: Colors.amber,



                                            title: Text('${datindQustions().QReligion[index]}',textAlign: TextAlign.start,)),
                                      ),
                                      SizedBox(height: 8,),
                                      Divider(thickness: 0.2,color: Colors.white,)
                                    ],
                                  ),
                                ));

                              }):Container(
                          alignment: AlignmentDirectional.center,
                          margin: EdgeInsets.only(top: 250),
                          child: Text(
                            "No Data"
                                .toString(),
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
                Container(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("Why you use rowdy baby?",
                          textAlign: TextAlign.start,style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),),

                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*0.020,),


                      ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,
                          itemCount:datindQustions().QRowdybaby.length ,
                          itemBuilder: (context,index){
                            return Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(onTap: (){
                                setState(() {
                                  slectedIndex =index;
                                });
                              },
                                trailing:slectedIndex==index?Icon(Icons.check):null ,
                                textColor: Colors.white,
                                selected: slectedIndex==index?true:false,

                                selectedColor: Colors.amber,
                                tileColor: Color(0xffC5204C),

                                selectedTileColor:Colors.white,
                                title:  Text('${datindQustions().QRowdybaby[index]}')),
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

    datindQustions().QCaste.forEach((castedata) {
      if (castedata!.toLowerCase().contains(text.toLowerCase()))
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

    datindQustions().QReligion.forEach((religiondata) {
      if (religiondata!.toLowerCase().contains(text.toLowerCase()))
        searchResultReligion.add(religiondata);
    });

    setState(() {});
  }
  /// Handle Create account
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
          userPhotoFile: _imageFile!,
          userFullName: _nameController.text.trim(),
          userGender: _selectedGender!,
          userBirthDay: _userBirthDay,
          userBirthMonth: _userBirthMonth,
          userBirthYear: _userBirthYear,
          userSchool: _schoolController.text.trim(),
          userJobTitle: _jobController.text.trim(),
          userBio: _bioController.text.trim(),
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
          });

  }
  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }
  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse ?
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
              SizedBox(height: 30,),
            ],
          ) : SizedBox(),
          Text(title, style: TextStyle(
              color: primarq,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 20,),
          Text(content, textAlign: TextAlign.center, style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.w400
          ),),
          reverse ?
          Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
            ],
          ) : SizedBox(),
        ],
      ),
    );
  }
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: APP_PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(5)
      ),
    );
  }
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i<20; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
  /// Handle Agree privacy policy
  Widget _agreePrivacy() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Checkbox(
              activeColor: Theme.of(context).primaryColor,
              value: _agreeTerms,
              onChanged: (value) {
                _setAgreeTerms(value!);
              }),
          Row(
            children: <Widget>[
              GestureDetector(
                  onTap: () => _setAgreeTerms(!_agreeTerms),
                  child: Text(_i18n.translate("i_agree_with"),
                      style: TextStyle(fontSize: 16))),
              // Terms of Service and Privacy Policy
              TermsOfServiceRow(color: Colors.black),
            ],
          ),
        ],
      ),
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
}
