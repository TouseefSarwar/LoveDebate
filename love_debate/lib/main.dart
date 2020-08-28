import 'package:app_push_notifications/Modules/Chat/ChatBloc/chatBloc.dart';
import 'package:app_push_notifications/Modules/PreMatches/Rounds/Rounds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Modules/LoginSignup/SocialSignUpInfo.dart';
import 'Modules/Chat/ChatBloc/blocProvider.dart';
import 'Modules/LoginSignup/Login.dart';
import 'package:app_push_notifications/Screens/SplashScreen.dart';
import 'Screens/TabBarcontroller.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

void main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      bloc: ChatBloc(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
          ),
          home:  SplashScreen(),
          routes: {
            '/Login': (BuildContext context) =>  Login(),
            '/TabBarControllerPage' : (BuildContext context) => TabBarControllerPage(),
            '/SocialSignUp' : (BuildContext context) => SocialSignUpForm(),
            '/Rounds' : (BuildContext context) => Rounds(),
          }
      ),
    );
  }

}

class AppleSignInAvailable {
  AppleSignInAvailable(this.isAvailable);
  final bool isAvailable;

  static Future<AppleSignInAvailable> check() async {
    return AppleSignInAvailable(await AppleSignIn.isAvailable());
  }
}