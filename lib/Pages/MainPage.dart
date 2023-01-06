import 'package:event_calender/Testing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'AboutPage.dart';
import 'ViewAllWidget.dart';
import 'Home.dart';
import 'LoginPage.dart';
import 'ProfilePage.dart';

class MainPage extends StatelessWidget {

  String? profilePicture1;
  String? name1;
  String? email1;
  MainPage({this.profilePicture1, this.name1, this.email1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EveCalendar'),
        // centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        actions: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              print(profilePicture1);
              print(FirebaseAuth.instance.currentUser!.photoURL);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(
                profilePicture2: profilePicture1,
                name2: name1,
                email2: email1,
              )));
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: (FirebaseAuth.instance.currentUser != null) ? getProfileImage() : getFBProfile(),
            ),
          ),
          // IconButton(onPressed: (){
          //
          // }, icon: Icon(Icons.delete_forever, size: 30,),
          //   tooltip: "Delete Account",
          // ),
          SizedBox(width: 15,)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              // width: 250,

              child: Center(
                child: Text("Select Your Choice !",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blue.shade800),),
              ),
            ),
            SizedBox(height: 30,),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height/2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    childAspectRatio: 0.9,
                    crossAxisCount: 3,
                  // mainAxisSpacing: 10,
                  // crossAxisSpacing: 10,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(100),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 30,
                              child: Icon(Icons.edit_calendar_outlined, size: 35,)),
                          SizedBox(height: 10,),
                          Text("Add", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue.shade800),),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(100),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.event_available_outlined, size: 35,)),
                          SizedBox(height: 10,),
                          Text("Events", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue.shade800),),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(100),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAll()));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.view_timeline_outlined, size: 35,)),
                          SizedBox(height: 10,),
                          Text("View All", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue.shade800),),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(100),
                      onPressed: (){},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.favorite_border_rounded, size: 35,)),
                          SizedBox(height: 10,),
                          Text("Favourite", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue.shade800),),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(100),
                      onPressed: (){},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.group_add_outlined, size: 35,)),
                          SizedBox(height: 10,),
                          Text("Connect", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue.shade800),),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(100),
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage()));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            // backgroundColor: Colors.red.shade600,
                              radius: 30,
                              child: Icon(Icons.info_outline_rounded, size: 35, color: Colors.white,)),
                          SizedBox(height: 10,),
                          Text("About", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue.shade800),),
                        ],
                      ),
                    ),
                  ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  // Future<void> logOut (BuildContext context) async{
  //   try{
  //     await GoogleSignIn().signOut();
  //     await  FirebaseAuth.instance.signOut();
  // } on FirebaseAuthException catch (e){
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
  //   }
  // }
  // Future<void> deleteAccount (BuildContext context) async{
  //   try{
  //     await GoogleSignIn().disconnect();
  //     await FirebaseAuth.instance.currentUser!.delete();
  //   } on FirebaseAuthException catch (e){
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
  //   }
  // }
  getProfileImage () {
    if(FirebaseAuth.instance.currentUser?.photoURL != null){
      return NetworkImage(FirebaseAuth.instance.currentUser!.photoURL.toString());
    }else
    {
      return NetworkImage(profilePicture1.toString());
      // NetworkImage("https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png");
    }
  }
  getFBProfile () {
    if(FacebookAuth.instance.getUserData() != null){
      return NetworkImage(profilePicture1.toString());
    }else
      {
        return NetworkImage(FirebaseAuth.instance.currentUser!.photoURL.toString());
        // NetworkImage("https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png");
      }
  }
}
