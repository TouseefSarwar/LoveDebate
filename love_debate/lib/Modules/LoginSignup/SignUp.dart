
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovedebate/Modules/LoginSignup/SocialSignUpInfo.dart';
import 'package:lovedebate/Modules/Preferences/PreferencesOnBoarding.dart';
import 'package:lovedebate/Screens/TabBarcontroller.dart';
import 'package:lovedebate/Utils/Constants/SharedPref.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'package:lovedebate/Utils/Controllers/Loader.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:lovedebate/Utils/Globals/GlobalFunctions.dart';
import 'package:lovedebate/Utils/Globals/UserSession.dart';
import '../../Utils/Globals/Fonts.dart';
import 'SUPersonalInfo.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isloading = false;
  SharedPref prf = SharedPref();

  var result;
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';
  final GoogleSignIn googleSignIn = GoogleSignIn();
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
          SignupMethod(context,_signupButtonheight,"email", width,'Sign Up with Email',true,GlobalColors.firstColor,'images/mail.png',Colors.white),
          SignupMethod(context,_signupButtonheight, "fb",width,'Sign Up with Facebook',true,Color(0xff0072CD),'images/icons8-facebook-f-48.png',Colors.white),
          SignupMethod(context,_signupButtonheight,"google", width,'Sign Up with Google',true,Colors.white,'images/googleicon.png',Colors.black),
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
            children: <Widget>[
              Container(
                child:  bgColor ==GlobalColors.firstColor ? Image.asset(image,fit: BoxFit.fitWidth,color: Colors.white ) :Image.asset(image,fit: BoxFit.fitWidth,),
                width: 25.0,
                height: 25.0,  // borde width
              ),
              SizedBox(width: 12,),
              Container(
                  width: 200,
                  // color: Colors.yellow,
                  child: Text(text,style: TextStyle(fontSize: 18,color: textcolor),)),
            ],
          ),
        ),
      ),
    );

  }

  ///Google SignUp
  Future<void> _googleSignIn() async {

    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
          scopes: <String>[
            'email',
            "https://www.googleapis.com/auth/userinfo.email",
            "https://www.googleapis.com/auth/userinfo.profile"
          ]

      );
      GoogleSignInAccount data = await googleSignIn.signIn() ?? null;

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
//
    final facebookLogin = FacebookLogin();

    final _result = await facebookLogin.logIn(['email','public_profile',]);
    final token = _result.accessToken.token;
    if (token == null){
      facebookLogin.logOut();
    }else{

      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
//    final graphResponse = await http.get(
//        'https://graph.facebook.com/v2.12/me?&access_token=${token}');
      // final graph=await
      final profile = jsonDecode(graphResponse.body);
      print(jsonDecode(graphResponse.body));
      switch (_result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = _result.accessToken;

//        final token = result.accessToken.token;
//        final graphResponse = await http.get(
//            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
//        final profile = JSON.decode(graphResponse.body);
//        print(profile['name'].toString());
//        print(profile['user_mobile_no'].toString());
//        print(profile['user_gender'].toString());
//        print(profile['name'].toString());
//        print(profile['name'].toString());
//       print(result.accessToken);
//        print(result.status);
//        print(result.accessToken.token);
          //print(result.accessToken.permissions[1].toString());
//        print(result.accessToken.userId);
//        first_name=data.displayName.split(" ")[0];
//        last_name=data.displayName.split(" ")[1];
//        email=data.email;
//        social_login_type="google";
//        social_login_id=data.id;
//        print(first_name+"  "+last_name);
//        print(profile["name"]);
//        print(profile["email"]);
//        print(profile['id'].toString());
//        print(profile['first_name'].toString());
//        print(profile['last_name'].toString());
//        print("email");
//        print(profile['email'].toString());
//        print(profile.toString());
//        first_name=profile['first_name'].toString();
//        last_name=profile['last_name'].toString();
//        email=profile['email'].toString();
//        social_login_id=profile['id'].toString();
//        social_login_type='fb';
//        email="shadyrecordslp99@gmail.com";
//        print(first_name+""+last_name+''+email+''+social_login_id+''+social_login_type);
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

  ///ApiCall Social Login/SignUp.
  SocialSignUp(Map<String, dynamic> body){

    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: false, url: WebService.login,body: body,isFormData: false).then(
              (response) async {
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              if(responseJson.containsKey('success')) {

                if(responseJson['success']['already_exist'] == false){
                  UserSession.token =  responseJson["success"]["token"] == null? "": "Bearer ${responseJson["success"]["token"]}";
                  await prf.set(UserSession.tokenkey,UserSession.token);
                  Navigator.push(context, CupertinoPageRoute(fullscreenDialog: true,builder: (context) => SocialSignUpForm(
                    email: responseJson['success']['user']['email'].toString(),
                    firstName: responseJson['success']['user']['name'].toString().split(' ').first,
                    lastName: responseJson['success']['user']['name'].toString().split(' ')[1],
                  )));
                }else{
                  if( responseJson['success']['user']['onboading_status'].toString() == '0'){
                    UserSession.token =  responseJson["success"]["token"] == null? "": "Bearer ${responseJson["success"]["token"]}";
                    await prf.set(UserSession.tokenkey,UserSession.token);
                    await prf.set(UserSession.signUp,true);
                    UserSession.isSignup = await prf.getBy(UserSession.signUp);
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => PreferencesOnBoarding()));
                  }else{
                    UserSession.token =  responseJson["success"]["token"] == null? "": "Bearer ${responseJson["success"]["token"]}";
                    await prf.set(UserSession.tokenkey,UserSession.token);
                    await prf.set(UserSession.signUp,true);
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
