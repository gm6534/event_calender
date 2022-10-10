import 'package:event_calender/Testing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Widgets/ViewAllWidget.dart';
import 'Home.dart';
import 'LoginPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EveCalendar'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        actions: [
          IconButton(onPressed: (){
            deleteAccount(context).whenComplete(() =>
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage())));
          }, icon: Icon(Icons.delete_forever, size: 30,),
            tooltip: "Delete Account",
          ),
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
                      borderRadius: BorderRadius.circular(100),
                      onPressed: (){
                        logOut(context).whenComplete(() =>
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage())));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.red.shade600,
                              radius: 30,
                              child: Icon(Icons.exit_to_app_outlined, size: 35, color: Colors.white,)),
                          SizedBox(height: 10,),
                          Text("Logout", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue.shade800),),
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
      await GoogleSignIn().disconnect();
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

}
