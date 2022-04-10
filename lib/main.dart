import 'dart:io';
import 'package:country_code_picker/country_localizations.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/models/app_model.dart';
import 'package:dating_app/screens/Call/components/CallService.dart';
import 'package:dating_app/screens/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/constants/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/Call/components/NotificationService.dart';
import 'screens/Call/models/Language.dart';
import 'screens/Call/utilites/AppConstants.dart';
CallService callService = CallService();
NotificationService notificationService = NotificationService();
//endregion
late AppLocalizations? appLocalizations;
late Language? language;
List<Language> languages = Language.getLanguages();
//region MobX Objects
//AppStore appStore = AppStore();
//AppSettingStore appSettingStore = AppSettingStore();
//endregion
late MessageType? messageType;
//region Default Settings
int mChatFontSize = 16;
int mAdShowCount = 0;
String mSelectedImage = "assets/default_wallpaper.png";
bool mIsEnterKey = false;
List<String?> postViewedList = [];
Database? localDbInstance;
void main() async {
  // For play billing library 2.0 on Android, it is mandatory to call
  // [enablePendingPurchases](https://developer.android.com/reference/com/android/billingclient/api/BillingClient.Builder.html#enablependingpurchases)
  // as part of initializing the app.
  InAppPurchaseConnection.enablePendingPurchases();
  // Initialized before calling runApp to init firebase app
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize firebase app
  await Firebase.initializeApp();
  // Initialize Google Mobile Ads SDK

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  /// Check iOS device
  if (Platform.isIOS) {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true,);
  }

  runApp(MyApp());
}

// Define the Navigator global key state to be used when the build context is not available!
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: AppModel(),
      child: ScopedModel<UserModel>(
        model: UserModel(),
          child: MaterialApp(
          navigatorKey: navigatorKey,
          title: APP_NAME,
          debugShowCheckedModeBanner: false,

          /// Setup translations
          localizationsDelegates: [
            // AppLocalizations is where the lang translations is loaded
            AppLocalizations.delegate,
            CountryLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: SUPPORTED_LOCALES,

          /// Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode) {
                return supportedLocale;
              }
            }

            /// If the locale of the device is not supported, use the first one
            /// from the list (English, in this case).
            return supportedLocales.first;
          },
          home: SplashScreen(),
          theme: _appTheme(),
        ),
      ),
    );
  }
}
/// App theme
ThemeData _appTheme() {
  return ThemeData(textTheme:TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
    button: TextStyle(color: Colors.black),
    caption: TextStyle(color: Colors.black),
    subtitle1: TextStyle(color: Colors.white,fontSize: 14,), // <-- that's the one
    headline1: TextStyle(color: Colors.black),
    headline2: TextStyle(color: Colors.black),
    headline3: TextStyle(color: Colors.black),
    headline4: TextStyle(color: Colors.black),
    headline5: TextStyle(color: Colors.black),
    headline6: TextStyle(color: Colors.black,fontSize: 12),
  ),
    primaryTextTheme: TextTheme(),
    indicatorColor: Color(0xffDE2657),
    checkboxTheme:CheckboxThemeData() ,
    fontFamily: 'PangramSans',
    primaryColor: Color(0xffDE2657),
    accentColor: APP_ACCENT_COLOR,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
hintStyle: TextStyle(color: Colors.white),
      labelStyle: TextStyle(color: Colors.white),
      filled: true,
      hoverColor: Color(0xffC5204C),
      fillColor: Color(0xffC5204C),
        errorStyle: TextStyle(fontSize: 16),
      focusedBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Color(0xffC5204C),
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Color(0xffC5204C),
          width: 2.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Color(0xffC5204C),
          width: 2.0,
        ),
      ),
        focusColor:  Color(0xffC5204C) ,
        border: OutlineInputBorder(
          borderSide: BorderSide(
          color:  Color(0xffC5204C),
        ),
          borderRadius: BorderRadius.circular(8),
        ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: Platform.isIOS ? 0 : 4.0,
      iconTheme: IconThemeData(color: Color(0xffC5204C)),
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.grey, fontSize: 18),
      ),
    ),
  );
}
