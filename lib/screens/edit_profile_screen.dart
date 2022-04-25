import 'package:dating_app/dialogs/common_dialogs.dart';
import 'package:dating_app/dialogs/progress_dialog.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/profile_screen.dart';
import 'package:dating_app/widgets/image_source_sheet.dart';
import 'package:dating_app/widgets/svg_icon.dart';
import 'package:dating_app/widgets/user_gallery.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'filter/Advancefilter_screen.dart';
import 'filter/Bottomsheet.dart';
import 'filter/Caste.dart';
import 'filter/Religion.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  List<String> marriedstatus =["Single","Single with kids","Divorced","Divorced with kids","Widowed","Widowed with kids","Seperated","Seperated with kids"];
  List<String> Smoke =["yes","No","Planning to Quit","Occasionally "];
  List<String> Education =["Graduate degree","UnderGraduate degree","In college","In grad school","High school","Vocational school","I'm not study","Quit studies  "];
  List<String> Drink =["yes","No","Planning to Quit","Occasionally "];
  List<String> Language =["Hindi","English","Telgu","Tamil","Urdhu","Bangali"];
  List<String> Rowdybaby =["A Relationship or date"," To get Marry","I'm not sure","Something Casul"];

  // Variables
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _schoolController =
      TextEditingController(text: UserModel().user.userSchool);
  final _jobController =
      TextEditingController(text: UserModel().user.userJobTitle);
  final _bioController = TextEditingController(text: UserModel().user.userBio);
  late AppLocalizations _i18n;
  late ProgressDialog _pr;

  @override
  Widget build(BuildContext context) {
    /// Initialization
    _i18n = AppLocalizations.of(context);
    _pr = ProgressDialog(context, isDismissible: false);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(elevation: 0,
        title: Text(_i18n.translate("edit_profile")),
        actions: [
          // Save changes button
          TextButton(
            child: Text(_i18n.translate("SAVE"),
            style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () {
              /// Validate form
              if (_formKey.currentState!.validate()) {
                _saveChanges();
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ScopedModelDescendant<UserModel>(
              builder: (context, child, userModel) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Profile photo
                GestureDetector(
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(UserModel().user.userProfilePhoto),
                          radius: 80,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),

                        /// Edit icon
                        Positioned(
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                          right: 0,
                          bottom: 0,
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    /// Update profile image
                    _selectImage(
                        imageUrl: UserModel().user.userProfilePhoto,
                        path: 'profile');
                  },
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(_i18n.translate("profile_photo"),
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center),
                ),

                /// Profile gallery
                Text(_i18n.translate("gallery"),
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.left),
                SizedBox(height: 5),

                /// Show gallery
                UserGallery(),

                SizedBox(height: 20),
                Divider(),
                //who are you intersted in?
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Caste()));
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text('Who are you intersted in ?', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text("I'm Intersted in women" , textAlign: TextAlign.start, style: TextStyle(
                          color:  Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),
                Divider(),
                //Caste

                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Caste()));
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text("What 's your caste?", textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('${UserModel().user.userCaste}', textAlign: TextAlign.start, style: TextStyle(
                          color:  Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),
                Divider(),
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Religion()));
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text("What 's your Religion?", textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('${UserModel().user.userReligion}', textAlign: TextAlign.start, style: TextStyle(
                          color:  Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),
                Divider(),
                //why use bby
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Religion()));
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text('Why you use rowdy baby?', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('${UserModel().user.userReligion}', textAlign: TextAlign.start, style: TextStyle(
                          color: Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),

                Divider(),
                //religion
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Religion()));
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text("What's your Height?", textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text("5'6", textAlign: TextAlign.start, style: TextStyle(
                          color: Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),
                //Marital
                Container(
                  child: Center(
                    child: ListTile(onTap: (){

                      showModalBottomSheet<void>(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return BottomSheetSwitch(
                            title: "Married Status",
                            list: marriedstatus,
                            switchValue: Status.MaritalStatus,

                          );
                        },
                      );
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text('Marital Status', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('${UserModel().user.userMarriedsatus}', textAlign: TextAlign.start, style: TextStyle(
                          color:  Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),
                Divider(),
                //Smoke
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      showModalBottomSheet<void>(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return BottomSheetSwitch(title: "Smoke",
                            list: Smoke,
                            switchValue: Status.Smoke,

                          );
                        },
                      );
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text('Do you Smoke?', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('${UserModel().user.userSmoke}', textAlign: TextAlign.start, style: TextStyle(
                          color: Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),
                //Drink
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      showModalBottomSheet<void>(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return BottomSheetSwitch(title: "Drink",
                            list: Drink,
                            switchValue: Status.Drink,

                          );
                        },
                      );
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text('Do you drink?', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('${UserModel().user.userDrink}', textAlign: TextAlign.start, style: TextStyle(
                          color:  Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),
                Divider(),
                //Language speak
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      showModalBottomSheet<void>(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return BottomSheetSwitch(title: "Langague Speaking",
                            list: Language,
                            switchValue: Status.Language,

                          );
                        },
                      );
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text('Language speak?', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('${UserModel().user.userLang.toString()}', textAlign: TextAlign.start, style: TextStyle(
                          color: Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),
                Divider(),
                //education
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      showModalBottomSheet<void>(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return BottomSheetSwitch(title: "Education",
                            list: Education,
                            switchValue: Status.Education,

                          );
                        },
                      );
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text("What's your education? ", textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('${UserModel().user.userEducation}', textAlign: TextAlign.start, style: TextStyle(
                          color: Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),
                Divider(),
                //job
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Religion()));
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text('Your Job?', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('${UserModel().user.userJobTitle}', textAlign: TextAlign.start, style: TextStyle(
                          color: Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),
                Divider(),
                //about
                Container(
                  child: Center(
                    child: ListTile(onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Religion()));
                    },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      title: Text('About Me', textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('${UserModel().user.userBio}', textAlign: TextAlign.start, style: TextStyle(
                          color: Color(0xffDE2657),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),), ),
                  ),
                ),
                Divider(),
                /// Bio field
              /*  TextFormField(
                  controller: _bioController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: _i18n.translate("bio"),
                    hintText: _i18n.translate("write_about_you"),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgIcon("assets/icons/info_icon.svg"),
                    ),
                  ),
                  validator: (bio) {
                    if (bio == null) {
                      return _i18n.translate("please_write_your_bio");
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                /// School field
                TextFormField(
                  controller: _schoolController,
                  decoration: InputDecoration(
                      labelText: _i18n.translate("school"),
                      hintText: _i18n.translate("enter_your_school_name"),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: SvgIcon("assets/icons/university_icon.svg"),
                      )),
                  validator: (school) {
                    if (school == null) {
                      return _i18n.translate("please_enter_your_school_name");
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                /// Job title field
                TextFormField(
                  controller: _jobController,
                  decoration: InputDecoration(
                      labelText: _i18n.translate("job_title"),
                      hintText: _i18n.translate("enter_your_job_title"),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgIcon("assets/icons/job_bag_icon.svg"),
                      )),
                  validator: (job) {
                    if (job == null) {
                      return _i18n.translate("please_enter_your_job_title");
                    }
                    return null;
                  },
                ),*/
                SizedBox(height: 20),
              ],
            );
          }),
        ),
      ),
    );
  }

  /// Get image from camera / gallery
  void _selectImage({required String imageUrl, required String path}) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => ImageSourceSheet(
              onImageSelected: (image) async {
                if (image != null) {
                  /// Show progress dialog
                  _pr.show(_i18n.translate("processing"));

                  /// Update profile image
                  await UserModel().updateProfileImage(
                      imageFile: image, oldImageUrl: imageUrl, path: 'profile');
                  // Hide dialog
                  _pr.hide();
                  // close modal
                  Navigator.of(context).pop();
                }
              },
            ));
  }

  /// Update profile changes for TextFormField only
  void _saveChanges() {
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
  }
}
