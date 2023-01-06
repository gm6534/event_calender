import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'LoginPage.dart';

class ProfilePage extends StatelessWidget {

  String? profilePicture2;
  String? name2;
  String? email2;
  ProfilePage({this.profilePicture2, this.name2, this.email2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60,),
            CupertinoButton(
              onPressed: (){
                print(profilePicture2);
                print(name2);
                print(email2);

                print(FirebaseAuth.instance.currentUser!.photoURL);
                print(FirebaseAuth.instance.currentUser!.displayName);
                print(FirebaseAuth.instance.currentUser!.email);


              },
              child: CircleAvatar(
                radius: 70,
                backgroundImage: (FirebaseAuth.instance.currentUser != null) ? getProfileImage() : getFBProfile(),
              ),
            ),
            SizedBox(height: 60,),
            (FirebaseAuth.instance.currentUser !=null) ?
            Text("${FirebaseAuth.instance.currentUser!.displayName}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
            ) :
            Text("${name2}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
            ),
            SizedBox(height: 30,),
            (FirebaseAuth.instance.currentUser != null) ?
            Text("${FirebaseAuth.instance.currentUser!.email}",
              style: TextStyle(
                  fontSize: 17
              ),
            )
                :
            Text("${email2}",
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            Spacer(),
            CupertinoButton(
                color: Colors.orange,
                child: Container(
                    width: 110,
                    height: 20,
                    child: Text("Log Out", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
                onPressed: (){
                  logOut(context).whenComplete(() =>
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false));
                }),
            SizedBox(height: 20,),
            CupertinoButton(
                color: Colors.red.shade800,
                child: Text("Delete Account", style: TextStyle(fontWeight: FontWeight.bold),),
                onPressed: (){
                  deleteAccount(context).whenComplete(() =>
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false));
                }),
            SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }
  Future<void> logOut (BuildContext context) async{
    try{
      await GoogleSignIn().signOut();
      await  FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
  Future<void> deleteAccount (BuildContext context) async{
    try{
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
  getProfileImage () {
    if(FirebaseAuth.instance.currentUser?.photoURL != null){
      return NetworkImage(FirebaseAuth.instance.currentUser!.photoURL.toString());
    }else
    {
      return NetworkImage("https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png");
    }
  }
  getFBProfile () {
    if(FacebookAuth.instance.getUserData() != null){
      return NetworkImage(profilePicture2.toString());
    }else
    {
      return NetworkImage("https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png");
    }
  }


}
