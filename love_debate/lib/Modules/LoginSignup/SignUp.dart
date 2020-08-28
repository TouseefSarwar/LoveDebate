
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app_push_notifications/Modules/LoginSignup/SocialSignUpInfo.dart';
import 'package:app_push_notifications/Modules/Preferences/PreferencesOnBoarding.dart';
import 'package:app_push_notifications/Screens/TabBarcontroller.dart';
import 'package:app_push_notifications/Utils/Constants/SharedPref.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Utils/Designables/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
import '../../Utils/Globals/Fonts.dart';
import 'SUPersonalInfo.dart';
import 'package:apple_sign_in/apple_sign_in.dart';



class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState(); 
}

class _SignUpState extends State<SignUp> {

  bool isloading = false;
  SharedPref prf = SharedPref();

  //Apple SignIn
  final _firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/userinfo.profile",
//        "https://www.googleapis.com/auth/user.birthday.read",
//        "https://www.googleapis.com/auth/user.gender.read",
      ]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Platform.isIOS){
      AppleSignIn.onCredentialRevoked.listen((_) {
        print("Credentials revoked");
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width; 

    double _signupButtonwidth=_width/0.75;
    double _signupButtonHeight=_height/1.4;
    return Scaffold(
      appBar:  CustomAppbar.setNavigation(""),
      body:(!isloading)? Container(
        height: _height,
        width: _width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TopSection(_height),
              BottomSection(_height, _signupButtonwidth,context,_signupButtonHeight),
            ],
          ),
        ),
      ) : Center(child: Loading(),),
    );
  }

  Container BottomSection(double height, double width,BuildContext context,double _signupButtonheight) {
    return Container(
      height: (50/100)* height,
      // color: Colors.white,
      child: Column(
        children: <Widget>[
          // SizedBox(height: 18,),
          SignupMethod(context,_signupButtonheight,"email", width,'Continue with Email',true,GlobalColors.firstColor,'images/mail.png',Colors.white),
          SignupMethod(context,_signupButtonheight, "fb",width,'Continue with Facebook',true,Color(0xff0072CD),'images/icons8-facebook-f-48.png',Colors.white),
          SignupMethod(context,_signupButtonheight,"google", width,'Continue with Google',true,Colors.white,'images/googleicon.png',Colors.black),
          (Platform.isIOS)?Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: AppleSignInButton(
              style: ButtonStyle.black,
              type: ButtonType.continueButton,
              onPressed: appleLogIn,
            ),
          ): Container(),



          Expanded(
            child: Container(
//            height:((50/100)*height),
              width: width,
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.body1.copyWith(fontSize: GlobalFont.textFontSize,),
                        children: <TextSpan>[
                          TextSpan(text: 'Login', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
                        ],
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container TopSection(double _height) {
    return Container(
      height:(35/100)*_height ,
      //color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
              height: 220,
              width: 220,
              child: Image.asset("images/LoveDebatelogo.png")
          )

        ],
      ),
    );
  }

  InkWell SignupMethod(BuildContext context,double height,String socialtype, double width,String text,bool isIcon,Color bgColor,String image,Color textcolor) {
    return InkWell(
      onTap: (){
        if(socialtype == "fb"){
          _faceBooklogin();
        }else if (socialtype == "google"){
            _googleSignIn();
        }else if(socialtype == "email"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SUPersonalInfo()),
          );
        }

      },
      child: Container(
        height: 55,
        margin: EdgeInsets.only(left: 12, right: 12,bottom: 12),
        child: Card(
          elevation: 7,
          color: bgColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 16,),
              Container(
                child:  bgColor ==GlobalColors.firstColor ? Image.asset(image,fit: BoxFit.fitWidth,color: Colors.white ) :Image.asset(image,fit: BoxFit.fitWidth,),
                width: 16.0,
                height: 16.0,  // borde width
              ),
              SizedBox(width: 4,),
              Container(
                width: 220,
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 18,
                        color: textcolor ,
                        fontWeight: FontWeight.w600
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );

  }


  ///Apple Login
  appleLogIn() async{
      // if(await AppleSignIn.isAvailable()) {
        final AuthorizationResult result = await
        AppleSignIn.performRequests([
          AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
        ]);
        switch (result.status) {
          case AuthorizationStatus.authorized:
            print(result.credential.user);
            //All the required credentials

            final AppleIdCredential _auth = result.credential;
            final OAuthProvider oAuthProvider = new OAuthProvider(providerId: "apple.com");

            final AuthCredential credential = oAuthProvider.getCredential(
              idToken: String.fromCharCodes(_auth.identityToken),
              accessToken: String.fromCharCodes(_auth.authorizationCode),
            );

            await _firebaseAuth.signInWithCredential(credential);

            // update the user information
            if (_auth.fullName != null) {
              _firebaseAuth.currentUser().then( (value) async {
                UserUpdateInfo user = UserUpdateInfo();
                print("Email: ${_auth.email}");
                print("User: ${_auth.user}");
                print('${_auth.fullName.givenName}');
                print('${_auth.fullName.familyName}');
                Map<String, dynamic> body;
                if (_auth.email ==null){
                  body = {
                    'APPLE_SID' : _auth.user.toString(),
                    'first_name' : _auth.fullName.givenName.toString(),
                    'last_name' : _auth.fullName.familyName.toString(),
                  };
                }else{
                  body = {
                    'APPLE_SID' : _auth.user.toString(),
                    'first_name' : _auth.fullName.givenName.toString(),
                    'last_name' : _auth.fullName.familyName.toString(),
                    'email' : _auth.email.toString(),
                  };
                }
                await value.updateProfile(user);
                isloading =true;
                setState(() {
                  SocialSignUp(body);
                });

              });
            }

          break;
          case AuthorizationStatus.error:
            GFunction.showError("Sign in failed: ${result.error.localizedDescription}", context);
            // print("Sign in failed: ${result.error.localizedDescription}");
            break;
          case AuthorizationStatus.cancelled:
            print('User cancelled');
            break;
        }
      // }else{
      //   print('Apple SignIn is not available for your device');
      // }
  }



  ///Google SignUp
  Future<void> _googleSignIn() async {

    try {
//      GoogleSignIn _googleSignIn = GoogleSignIn(
//          scopes: <String>[
//            'email',
//            "https://www.googleapis.com/auth/userinfo.email",
//            "https://www.googleapis.com/auth/userinfo.profile",
//            "https://www.googleapis.com/auth/user.birthday.read",
//            "https://www.googleapis.com/auth/user.gender.read",
//
//          ]
//
//      );
      GoogleSignInAccount data = await googleSignIn.signIn() ?? null;
//      GoogleSignInAccount data = await googleSignIn.signIn();

      print(data.toString());
      isloading = true;
      setState(() {
        if (data != null) {
          Map<String, dynamic> body = {
            'GOOGLE_SID' :data.id ,
            'first_name' : data.displayName.split(" ")[0],
            'last_name' : data.displayName.split(" ")[1],
            'email' : data.email,
          };
          SocialSignUp(body);
        }else{
          isloading = false;
          googleSignIn.signOut();
          setState(() {});
        }
      });
    } catch (error) {
      print(error);
    }
  }

  ///Facebook signup
  Future<Null> _faceBooklogin() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webOnly;
    final _result = await facebookLogin.logIn(['email','public_profile']);
    final token = _result.accessToken.token;
    if (token == null){
      facebookLogin.logOut();
    }else{
      isloading = true;
      setState(() {});
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
      final profile = jsonDecode(graphResponse.body);
      if (profile['error'] != null){
        isloading = false;
        setState(() {});
        GFunction.showError(profile['error']['message'], context);
      }else{
        switch (_result.status) {
          case FacebookLoginStatus.loggedIn:
            Map<String, dynamic> body;
            if (profile['email'] == null){
              body = {
                'FB_SID' : profile['id'].toString(),
                'first_name' : profile['first_name'].toString(),
                'last_name' : profile['last_name'].toString(),
              };
            }else{
              body = {
                'FB_SID' : profile['id'].toString(),
                'first_name' : profile['first_name'].toString(),
                'last_name' : profile['last_name'].toString(),
                'email' : profile['email'].toString(),
              };
            }

          SocialSignUp(body);
            break;
          case FacebookLoginStatus.cancelledByUser:
            GFunction.showError('Login cancelled by the user.', context);
            break;
          case FacebookLoginStatus.error:
            GFunction.showError("Something went wrong with the login process.\nHeres the error Facebook gave us: ${_result.errorMessage}", context);
            break;
        }
      }

    }
  }

  ///ApiCall Social Login/SignUp.
  SocialSignUp(Map<String, dynamic> body){

    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: false, url: WebService.login,body: body,isFormData: false).then(
              (response) async {
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);

              if(responseJson.containsKey('success')) {
                print('Response=====> ${responseJson['success']}');
                print('Response=====> ${responseJson['success']["user"]}');
                isloading = false;
                if(responseJson['success']['already_exist'] == false){
                  UserSession.authToken =  responseJson["success"]["token"] == null? "": "Bearer ${responseJson["success"]["token"]}";
                  await prf.set(UserSession.authTokenkey,UserSession.authToken);
                  Navigator.push(context, CupertinoPageRoute(fullscreenDialog: true,builder: (context) => SocialSignUpForm(
                    email: responseJson['success']['user']['email'].toString(),
                    firstName: responseJson['success']['user']['name'].toString().split(' ').first,
                    lastName: responseJson['success']['user']['name'].toString().split(' ')[1],
                  )));
                }else{
                  if( responseJson['success']['user']['onboading_status'].toString() == '0'){
                    UserSession.authToken =  responseJson["success"]["token"] == null? "": "Bearer ${responseJson["success"]["token"]}";
                    await prf.saveSocketId(socketId: responseJson['success']['user']['soc_id']);
                    // await prf.set(UserSession.authTokenkey,UserSession.authToken);
                    await prf.set(UserSession.signUp,true);
                    await prf.set(UserSession.name,responseJson['success']['user']['name'].toString());
                    UserSession.isSignup = await prf.getBy(UserSession.signUp);
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => PreferencesOnBoarding()));
                  }else{
                    UserSession.authToken =  responseJson["success"]["token"] == null? "": "Bearer ${responseJson["success"]["token"]}";
                    await prf.set(UserSession.authTokenkey,UserSession.authToken);
                    await prf.set(UserSession.signUp,true);
                    await prf.set(UserSession.name,responseJson['success']['user']['name'].toString());
                    UserSession.isSignup = await prf.getBy(UserSession.signUp);
                    await prf.remove(UserSession.answers);
                    await prf.remove(UserSession.question);
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                  }

                }

//                Navigator.push(context, CupertinoPageRoute(fullscreenDialog: true,builder: (context) => TabBarControllerPage()) );

              } else{}
            }else if (response.statusCode == 401){
              isloading = false;
              setState(() {});
              GFunction.showError(jsonDecode(response.body)["error"].toString(), context);
            }else{
              isloading = false;
              GFunction.showError(response.reasonPhrase.toString(), context);
            }
          });
    } on FetchDataException catch(e) {
      setState(() {
        GFunction.showError(e.toString(), context);
      });
    }
  }

}
