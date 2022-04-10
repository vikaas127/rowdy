import 'package:country_code_picker/country_code_picker.dart';
import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/dialogs/progress_dialog.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/home_screen.dart';
import 'package:dating_app/screens/signup/sign_up_screen.dart';
import 'package:dating_app/screens/verification_code_screen.dart';
import 'package:dating_app/widgets/default_button.dart';
import 'package:dating_app/widgets/show_scaffold_msg.dart';
import 'package:dating_app/widgets/svg_icon.dart';
import 'package:dating_app/widgets/terms_of_service_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}
class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  // Variables
  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final _numberController = TextEditingController();
  String? _phoneCode = '+91'; // Define yor default phone code
  String _initialSelection = 'IN'; // Define yor default country code
  late AppLocalizations _i18n;
  late ProgressDialog _pr;
  bool _agreeTerms = false;
  void _setAgreeTerms(bool value) {
    setState(() {
      _agreeTerms = value;
    });
  }
  @override
  void initState() {
    super.initState();
  }
  Widget _agreePrivacy() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          children: <Widget>[

            Row(
              children: <Widget>[
                GestureDetector(
                    onTap: () => _setAgreeTerms(!_agreeTerms),
                    child: Text(_i18n.translate("i_agree_with"),
                        style: TextStyle(fontSize: 12,color: Colors.white))),
                // Terms of Service and Privacy Policy
                TermsOfServiceRow(color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double h= MediaQuery.of(context).size.height;
    /// Initialization
    _i18n = AppLocalizations.of(context);
    _pr = ProgressDialog(context, isDismissible: false);

    return Container(

      child: Scaffold( backgroundColor: APP_PRIMARY_COLOR,
          key: _scaffoldkey,
       /*   appBar: AppBar(
            title: Text(_i18n.translate("phone_number")),
          ),*/
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[ SizedBox(height: h*0.14),

                Text(_i18n.translate("sign_in_with_phone_number"),
                    textAlign: TextAlign.start, style: TextStyle(fontSize: 32,color: Colors.white)),
                SizedBox(height:  h*0.08),



                /// Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _numberController,
                        decoration: InputDecoration(hintStyle: TextStyle(color: Colors.white),
                          //  labelText: _i18n.translate("phone_number"),
                            hintText: _i18n.translate("enter_your_number"),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: Container(//color: Colors.grey,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8),
                                child: CountryCodePicker(textStyle: TextStyle(color: Colors.white),
                                    alignLeft: false,
                                    initialSelection: _initialSelection,
                                     onChanged: (country) {
                                      /// Get country code
                                      _phoneCode = country.dialCode!;
                                    }),
                              ),
                            )),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(new RegExp("[0-9]"))
                        ],
                        validator: (number) {
                          // Basic validation
                          if (number == null) {
                            return _i18n
                                .translate("please_enter_your_phone_number");
                          }
                          return null;
                        },
                      ),
                      SizedBox(height:  h*0.05),

                      Text(_i18n.translate("OR"),
                          style: TextStyle(fontSize: 15,color: Colors.white)),
                      SizedBox(height:  h*0.05),
                      SizedBox(
                        width: double.maxFinite,
                        child: Center(
                          child: InkWell(onTap: (){
                            if (_formKey.currentState!.validate()) {
                              /// Sign in
                              _signIn(context);
                            }
                          },
                            child:  Center(
                              child: Container(height: 45,width: MediaQuery.of(context).size.width*0.73,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color:  Colors.white,
                                ),child:   Center(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                        child: Image.asset('assets/2.0x/facebook.png',height: 25,

                                     // color: Colors.red,
                                   //   semanticsLabel: 'A red up arrow'
                                  ),
                                      ),
                                      Text('Login with Facebook', textAlign: TextAlign.center, style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal
                                      ),),
                                    ],
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ),
                      /*  DefaultButton(
                          child: Text('Login with facebook',
                              style: TextStyle(fontSize: 18,color: Colors.blueAccent)),
                          onPressed: () async {
                            /// Validate form
                            if (_formKey.currentState!.validate()) {
                              /// Sign in
                              _signIn(context);
                            }
                          },
                        ),*/
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: double.maxFinite,
                        child: Center(
                          child: InkWell(onTap: (){
                            if (_formKey.currentState!.validate()) {
                              /// Sign in
                              _signIn(context);
                            }
                          },
                            child:  Center(
                              child: Container(height: 45,width: MediaQuery.of(context).size.width*0.73,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color:  Colors.white,
                                ),child:   Center(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                        child: Image.asset('assets/2.0x/google.png',height: 25,

                                          // color: Colors.red,
                                          //   semanticsLabel: 'A red up arrow'
                                        ),
                                      ),
                                      Text('Login with Google', textAlign: TextAlign.center, style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal
                                      ),),
                                    ],
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ),
                        /*  DefaultButton(
                          child: Text('Login with facebook',
                              style: TextStyle(fontSize: 18,color: Colors.blueAccent)),
                          onPressed: () async {
                            /// Validate form
                            if (_formKey.currentState!.validate()) {
                              /// Sign in
                              _signIn(context);
                            }
                          },
                        ),*/
                      ),
                      SizedBox(height: 20,),
                      _agreePrivacy(),
                      SizedBox(height:  h*0.05),


                    ],
                  ),
                ),
              ],
            ),
          ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: (

            ) {    _signIn(context);
           /* Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VerificationCodeScreen(
              verificationId: '',
            ))
            );*/

        },child: Container(//color:APP_PRIMARY_COLOR ,
            child:Icon(Icons.arrow_forward,color:APP_PRIMARY_COLOR ,),
         ),

        ),
      ),

    );
  }

  /// Sign in with phone number
  void _signIn(BuildContext context) async {
    // Show progress dialog
    _pr.show(_i18n.translate("processing"));

    /// Verify user phone number
    await UserModel().verifyPhoneNumber(
        phoneNumber: _phoneCode! + _numberController.text.trim(),
        checkUserAccount: () {
          /// Auth user account
          UserModel().authUserAccount(
              homeScreen: () {
            /// Go to home screen
            Future(() {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            });
          }, signUpScreen: () {
            /// Go to sign up screen
            Future(() {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            });
          });
        },
        codeSent: (code) async {
          // Hide progreess dialog
          _pr.hide();
          // Go to verification code screen
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VerificationCodeScreen(
                    verificationId: code,
                  )));
        },
        onError: (errorType) async {
          // Hide progreess dialog
          _pr.hide();

          // Check Erro type
          if (errorType == 'invalid_number') {
              // Check error type
              final String message =
                  _i18n.translate("we_were_unable_to_verify_your_number");
              // Show error message
              // Validate context
              if (mounted) {
                showScaffoldMessage(
                    context: context, message: message, bgcolor: Colors.red);
              }
          }
        });
  }
}
