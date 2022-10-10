import 'package:event_calender/Pages/MainPage.dart';
import 'package:event_calender/Testing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'ResetPage.dart';
import 'SignupPage.dart';

// final FirebaseAuth _auth;
// FirebaseAuthMethods(this._auth);
// User get user => _auth.currentUser!;
Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth=FirebaseAuth.instance;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown
    // ]);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Container(
              height: 220,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,colors: [Colors.blue.shade700, Colors.blue.shade900]),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 100.0)),
                    ),
                  ),
                  Positioned(
                    right: 120,
                    left: 120,
                    top: 120,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      backgroundImage: AssetImage("assets/51432318d4acaf6e4a3b62d0f3d5ea70.gif"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("Eve Calendar", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue.shade800),),
                  SizedBox(height: 100,),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: SignInButton(
                      Buttons.googleDark,
                      text: "Sign In with Google",
                      onPressed: () async{
                       await signInWithGoogle(context);
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: SignInButton(
                      Buttons.facebook,
                      text: "Sign In with Facebook",
                      onPressed: () async{
                        await signInWithFacebook(context);
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: SignInButton(
                      Buttons.gitHub,
                      text: "Sign In with GitHub",
                      onPressed: () async{},
                    ),
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: "Enter Email",
                  //       // hintText: "Type Here",
                  //       prefixIcon: Icon(Icons.mail, color: Colors.blue.shade800, size: 25,)
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: "Enter Password",
                  //       // hintText: "Type Here",
                  //       prefixIcon: Icon(Icons.lock_sharp, color: Colors.blue.shade800, size: 25,),
                  //       suffixIcon: Icon(Icons.visibility, color: Colors.blue.shade800, size: 25,)
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     TextButton(
                  //       onPressed: (){
                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPage()));
                  //       },
                  //       child: Text("forgot ?",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                  //     )
                  //   ],
                  // ),
                  // ElevatedButton(
                  //     style: ButtonStyle(
                  //         minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                  //         backgroundColor: MaterialStateProperty.all(Colors.blue.shade800)
                  //     ),
                  //     onPressed: (){
                  //       // Constants.prefs?.setBool("loggedIn", true);
                  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                  //     },
                  //     child: Text("Log In", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),

                ],
              ),
            ),
            Spacer(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Create Account ?",style: TextStyle(fontStyle: FontStyle.italic),),
            //     TextButton(
            //         onPressed: (){
            //           Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
            //         },
            //         child: Text("SignUp",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade700),),
            //     )
            //   ],
            // ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter,colors: [Colors.blue.shade700, Colors.blue.shade900]),
                borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                        MediaQuery.of(context).size.width, 100.0)),
              ),
              child: Center(child: Text("Team Deviate", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),)),
            ),
          ],
        ),
      ),
    );
  }
Future<void> signInWithGoogle(BuildContext context) async {
  try {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');

      await _auth.signInWithPopup(googleProvider);
    } else {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
        await _auth.signInWithCredential(credential).whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage())));

        // if you want to do specific task like storing information in firestore
        // only for new users using google sign in (since there are no two options
        // for google sign in and google sign up, only one as of now),
        // do the following:

        // if (userCredential.user != null) {
        //   if (userCredential.additionalUserInfo!.isNewUser) {}
        // }
      }
    }
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
  }
}
//Todo FACEBOOK SIGN IN
  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);


      await _auth.signInWithCredential(facebookAuthCredential).whenComplete(() =>
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage()))

    );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

}
