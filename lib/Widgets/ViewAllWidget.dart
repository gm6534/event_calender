import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_calender/Services/Notification_Services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
User get user => FirebaseAuth.instance.currentUser!;
TimeOfDay? pickedTime;
class ViewAll extends StatefulWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> with TickerProviderStateMixin {

  //Todo Variables
  NotificationService notificationService = NotificationService();
  DateTime now = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  TimeOfDay? pickedTime1;
  List<String> monthName = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  List<String> yearName = [
    '2022',
    '2023',
    '2024',
    '2025',
  ];


  int notify = 0;

  //Todo Controllers
  TextEditingController updateTitleController = TextEditingController();
  TextEditingController updateDescController = TextEditingController();
  TextEditingController updatetimecontroller = TextEditingController();
  TabController? _tabController;
  final titleController = TextEditingController();
  final descpController = TextEditingController();
  final timecontroller = TextEditingController();
  // double _initSize = 0.4;
  // List<bool> isOpen = [true];
  // Stream dragStream   = (() async* {
  //    await Future<void>.delayed(Duration(seconds: 5));
  //     yield 1;
  //     await FirebaseFirestore.instance
  //         .collection("Events")
  //         .doc(user!.uid)
  //         .collection("Date")
  //         .where("date",isEqualTo: DateFormat.yMMMMd('en_US')
  //         .format(_focusedDay)).snapshots();
  //
  // })();


  //Todo initState
  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    // loadPreviousEvents();
    notificationService;//Todo Notification Data
    notificationService.androidIntializeNotification();
    _tabController = TabController(vsync: this, length: 3);
    // ;
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController?.dispose();
  }


  // Map<String,dynamic> map = {
  //   "2022-09-13": [
  //     {"eventDescp": "11", "eventTitle": "111", "time": "05:00 PM"},
  //     {"eventDescp": "22", "eventTitle": "22", "time": "05:00 PM"}
  //   ],
  //   "2022-09-30": [
  //     {"eventDescp": "22", "eventTitle": "22", "time": "05:00 PM"}
  //   ],
  //   "2022-09-20": [
  //     {"eventTitle": "ss", "eventDescp": "ss", "time": "05:00 PM"}
  //   ]
  // };




//Todo Main Scaffold
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        title: const Text("All Events", style: TextStyle(color: Colors.white),),
        bottom: TabBar(
            unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            // isScrollable: true,
            labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            indicatorColor: Colors.white,
            // indicator: BoxDecoration(shape: BoxShape.circle),
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            tabs: [
              Tab(child: Text("Day",),),
              Tab(child: Text("Month",),),
              Tab(child: Text("Year",),),
              // Tab(child: Text("By Year",),),
            ]
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: [
            //Todo By Days Listview
            Container(
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Events")
                    .doc(user.uid)
                    .collection("Date").orderBy("date", descending: true).snapshots(),
                builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){
                  switch(snapshot.connectionState){

                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: Text("Waiting for data"),);
                    default :
                      if(snapshot.hasData){

                        if(snapshot.data.docs.isNotEmpty){
                          return  Expanded(
                            child: Container(
                              child: ListView.builder(itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      DateFormat('yyyy-MM-dd').format(_focusedDay)==snapshot.data.docs[index]['date']
                                          ?
                                      Text("")
                                          :
                                      Container(
                                        color: Colors.blue.shade700,
                                        height: 30,
                                        child: Center(
                                          child:
                                          Text(snapshot.data.docs[index]['date'],
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),),
                                      ),
                                      Card(
                                        margin: EdgeInsets.zero,
                                        elevation: 3,
                                        child: ExpansionTile(

                                          trailing: const Text(""),
                                          tilePadding: EdgeInsets.zero,
                                          collapsedIconColor:
                                          Colors.white,
                                          collapsedBackgroundColor:
                                          Colors.teal,
                                          backgroundColor: Colors.teal,
                                          title: ListTile(
                                            // leading: const Icon(
                                            //   Icons.done,
                                            //   color: Colors.white,
                                            // ),
                                            title: Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                'Title:   ${snapshot.data.docs[index]['title'].toString()}',
                                                style: const TextStyle(
                                                    color:
                                                    Colors.white),
                                              ),
                                            ),
                                            subtitle: Text(
                                              'Description:   ${snapshot.data.docs[index]['description'].toString()}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            trailing: Text(
                                              "${snapshot.data.docs[index]['time']}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),

                                          children: [
                                            ColoredBox(
                                              color: Colors.teal.shade600,
                                              child: Container(
                                                  width: double.infinity,
                                                  height: 50,
                                                  child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(width: 15,),
                                                      IconButton(
                                                          onPressed: (){
                                                            String message = "Title: ${snapshot.data.docs[index]['title'].toString()}\nDescription:\n${snapshot.data.docs[index]['description'].toString()}\n${snapshot.data.docs[index]['time']}\n${snapshot.data.docs[index]['date']}";
                                                            Share.share(message);
                                                          },
                                                          icon: Icon(Icons.share_rounded, color: Colors.white,)
                                                      ),
                                                      SizedBox(width: 15,),
                                                      // Text("${snapshot.data.docs[index]['time']}", style: TextStyle(fontWeight: FontWeight.bold,
                                                      // fontSize: 15,
                                                      //   color: Colors.white
                                                      // ),),
                                                      // Spacer(),
                                                      IconButton(onPressed: (){
                                                        showDialog(context: context, builder: (context){
                                                          return updateFun(snapshot.data.docs[index].id, snapshot.data.docs[index]['title'], snapshot.data.docs[index]['description'], snapshot.data.docs[index]['time']);
                                                        });
                                                      }, icon: Icon(Icons.edit_calendar_outlined, color: Colors.white,)),
                                                      SizedBox(width: 15,),
                                                      IconButton(onPressed: (){

                                                        showDialog(context: context, builder: (context){
                                                          return deleteFun(snapshot.data.docs[index].id);
                                                        });

                                                      }, icon: Icon(Icons.delete, color: Colors.white,)),
                                                      SizedBox(width: 15,),
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }, itemCount: snapshot.data.docs.length, shrinkWrap: true
                              ),
                            ),
                          );

                        }
                        else{
                          return Center(child: Text("No Events Added Yet"),);
                        }
                      }
                      else{

                        return Center(child: Text("Some Error Occured"),);
                      }
                  }
                } ,
              ),
            ),
            //Todo By Month Listview
            ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
                itemCount: DateTime.monthsPerYear,
                itemBuilder: (context, index){
                  return TimelineTile(
                    endChild: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Events")
                          .doc(user.uid)
                          .collection("Date").where("month", isEqualTo: index+1).where("year", isEqualTo: DateTime.now().year).snapshots(),
                      builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){
                        switch(snapshot.connectionState){

                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: Text("Waiting for data"),);
                          default :
                            if(snapshot.hasData){

                              if(snapshot.data.docs.isNotEmpty){
                                return  Container(
                                  height: MediaQuery.of(context).size.height/1.5,
                                  child: ListView.builder(itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          DateFormat('yyyy-MM-dd').format(_focusedDay)==snapshot.data.docs[index]['date']
                                              ?
                                          Text("")
                                              :
                                          Card(
                                            margin: EdgeInsets.zero,
                                            elevation: 3,
                                            child: ExpansionTile(

                                              trailing: const Text(""),
                                              tilePadding: EdgeInsets.zero,
                                              collapsedIconColor:
                                              Colors.white,
                                              collapsedBackgroundColor:
                                              Colors.teal,
                                              backgroundColor: Colors.teal,
                                              title: ListTile(
                                                // leading: const Icon(
                                                //   Icons.done,
                                                //   color: Colors.white,
                                                // ),
                                                title: Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      bottom: 8.0),
                                                  child: Text(
                                                    'Title:   ${snapshot.data.docs[index]['title'].toString()}',
                                                    style: const TextStyle(
                                                        color:
                                                        Colors.white),
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  'Description:   ${snapshot.data.docs[index]['description'].toString()}',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                trailing: Text(
                                                  "${snapshot.data.docs[index]['date'].toString()}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),

                                              children: [
                                                ColoredBox(
                                                  color: Colors.teal.shade600,
                                                  child: Container(
                                                      width: double.infinity,
                                                      height: 50,
                                                      child:
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          SizedBox(width: 15,),
                                                          Text("${snapshot.data.docs[index]['time']}", style: TextStyle(fontWeight: FontWeight.bold,
                                                              fontSize: 15,
                                                              color: Colors.white
                                                          ),),
                                                          Spacer(),
                                                          IconButton(
                                                              onPressed: (){
                                                                String message = "Title: ${snapshot.data.docs[index]['title'].toString()}\nDescription:\n${snapshot.data.docs[index]['description'].toString()}\n${snapshot.data.docs[index]['time']}\n${snapshot.data.docs[index]['date']}";
                                                                Share.share(message);
                                                              },
                                                              icon: Icon(Icons.share_rounded, color: Colors.white,)
                                                          ),
                                                          SizedBox(width: 15,),
                                                          IconButton(onPressed: (){
                                                            showDialog(context: context, builder: (context){
                                                              return updateFun(snapshot.data.docs[index].id, snapshot.data.docs[index]['title'], snapshot.data.docs[index]['description'], snapshot.data.docs[index]['time']);
                                                            });

                                                          }, icon: Icon(Icons.edit_calendar_outlined, color: Colors.white,)),
                                                          SizedBox(width: 15,),
                                                          IconButton(onPressed: (){
                                                            showDialog(context: context, builder: (context){
                                                              return deleteFun(snapshot.data.docs[index].id);
                                                            });
                                                          }, icon: Icon(Icons.delete, color: Colors.white,)),
                                                          SizedBox(width: 15,),
                                                        ],
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }, itemCount: snapshot.data.docs.length, shrinkWrap: true,
                                  ),
                                );

                              }
                              else{
                                return Center(child: Text("No Events Added Yet"),);
                              }
                            }
                            else{

                              return Center(child: Text("Some Error Occured"),);
                            }
                        }
                      } ,
                    ),
                    alignment: TimelineAlign.manual,
                    lineXY: 0.1,
                    // isLast: true,
                    // isFirst: true,
                    indicatorStyle: IndicatorStyle(
                      height: 60,
                      width: 50,
                      drawGap: true,
                      indicatorXY: 1,
                      indicator: Card(
                        shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        margin: EdgeInsets.zero,
                        color: Colors.blue.shade400,
                        child: Center(child: Text((monthName[index]).toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        )),
                      ),
                    ),
                    beforeLineStyle: LineStyle(
                      color: Colors.teal.shade200,
                      thickness: 6,
                    ),
                    afterLineStyle: LineStyle(
                      thickness: 6,
                    ),
                  );
                }
            ),

            //Todo By Year Listview
            ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
                itemCount: yearName.length,
                itemBuilder: (context, index){
                  return TimelineTile(
                    endChild: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Events")
                          .doc(user.uid)
                          .collection("Date").where("year", isEqualTo: int.parse(yearName[index])).snapshots(),
                      builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){
                        switch(snapshot.connectionState){

                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: Text("Waiting for data"),);
                          default :
                            if(snapshot.hasData){

                              if(snapshot.data.docs.isNotEmpty){
                                return  Column(
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height/1.5,
                                      child: ListView.builder(itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              DateFormat('yyyy-MM-dd').format(_focusedDay)==snapshot.data.docs[index]['date']
                                                  ?
                                              Text("")
                                                  :
                                              Card(
                                                margin: EdgeInsets.zero,
                                                elevation: 3,
                                                child: ExpansionTile(

                                                  trailing: const Text(""),
                                                  tilePadding: EdgeInsets.zero,
                                                  collapsedIconColor:
                                                  Colors.white,
                                                  collapsedBackgroundColor:
                                                  Colors.teal,
                                                  backgroundColor: Colors.teal,
                                                  title: ListTile(
                                                    // leading: const Icon(
                                                    //   Icons.done,
                                                    //   color: Colors.white,
                                                    // ),
                                                    title: Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                      child: Text(
                                                        'Title:   ${snapshot.data.docs[index]['title'].toString()}',
                                                        style: const TextStyle(
                                                            color:
                                                            Colors.white),
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      'Description:   ${snapshot.data.docs[index]['description'].toString()}',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    trailing: Text(
                                                      "${snapshot.data.docs[index]['date'].toString()}",
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),

                                                  children: [
                                                    ColoredBox(
                                                      color: Colors.teal.shade600,
                                                      child: Container(
                                                          width: double.infinity,
                                                          height: 50,
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              SizedBox(width: 15,),
                                                              Text("${snapshot.data.docs[index]['time']}", style: TextStyle(fontWeight: FontWeight.bold,
                                                                  fontSize: 15,
                                                                  color: Colors.white
                                                              ),),
                                                              Spacer(),
                                                              IconButton(
                                                                  onPressed: (){
                                                                    String message = "Title: ${snapshot.data.docs[index]['title'].toString()}\nDescription:\n${snapshot.data.docs[index]['description'].toString()}\n${snapshot.data.docs[index]['time']}\n${snapshot.data.docs[index]['date']}";
                                                                    Share.share(message);
                                                                  },
                                                                  icon: Icon(Icons.share_rounded, color: Colors.white,)
                                                              ),
                                                              SizedBox(width: 15,),
                                                              IconButton(onPressed: (){
                                                                showDialog(context: context, builder: (context){
                                                                  return updateFun(snapshot.data.docs[index].id, snapshot.data.docs[index]['title'], snapshot.data.docs[index]['description'], snapshot.data.docs[index]['time']);
                                                                });
                                                              }, icon: Icon(Icons.edit_calendar_outlined, color: Colors.white,)),
                                                              SizedBox(width: 15,),
                                                              IconButton(onPressed: (){
                                                                showDialog(context: context, builder: (context){
                                                                  return deleteFun(snapshot.data.docs[index].id);
                                                                });
                                                              }, icon: Icon(Icons.delete, color: Colors.white,)),
                                                              SizedBox(width: 15,),
                                                            ],
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        );
                                      }, itemCount: snapshot.data.docs.length, shrinkWrap: true,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 4,
                                      color: Colors.blue.shade400,
                                    )
                                  ],
                                );

                              }
                              else{
                                return Center(child: Text("No Events Added Yet"),);
                              }
                            }
                            else{

                              return Center(child: Text("Some Error Occured"),);
                            }
                        }
                      } ,
                    ),
                    alignment: TimelineAlign.manual,
                    lineXY: 0.1,
                    // isLast: true,
                    // isFirst: true,
                    indicatorStyle: IndicatorStyle(
                      height: 60,
                      width: 50,
                      drawGap: true,
                      indicatorXY: 1,
                      indicator: Card(
                        shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        margin: EdgeInsets.zero,
                        color: Colors.blue.shade400,
                        child: Center(child: Text((yearName[index]).toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        )),
                      ),
                    ),
                    beforeLineStyle: LineStyle(
                      color: Colors.teal.shade200,
                      thickness: 6,
                    ),
                    afterLineStyle: LineStyle(
                      thickness: 6,
                    ),
                  );
                }
            ),
            // Center(child: Text(getFeedDataByYear().toString()),),
          ]
      ),

    );
  }

  getFeedDataByYear() async {
    var db = await FirebaseFirestore.instance
        .collection("Year")
        .doc(_focusedDay.year.toString()).collection("Month")
        .doc(_focusedDay.month.toString()).collection("Date").doc(_focusedDay.toString()).collection("Time").doc(timecontroller.text.toString())
        .get();
    setState(() {
      // allData = List.from(db.docs.map((doc) => Event.fromSnapshot(doc)));
    });
  }
  //Todo Update FireBase Fun
  Widget updateFun(String id, String title, String desc, String time){
    return AlertDialog(
      scrollable:
      true,
      elevation:
      0,
      content:
      Column(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          Text("Update Event", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue.shade700),),
          TextFormField(
            controller:
            updateTitleController,
            decoration:
            InputDecoration(hintText: "${title.toString()}"),
          ),
          TextFormField(
            controller:
            updateDescController,
            decoration:
            InputDecoration(hintText: "${desc.toString()}"),
          ),
          const SizedBox(
            height:
            30,
          ),

          ///
          TextField(
            controller:
            updatetimecontroller, //editing controller of this TextField
            decoration:  InputDecoration(
                icon: Icon(Icons.timer), //icon of text field
                labelText: "${time.toString()}" //label text of field
            ),
            readOnly:
            true, //set it true, so that user will not able to edit text
            onTap:
                () async {
              pickedTime1 = await showTimePicker(
                initialTime: TimeOfDay.now(),
                initialEntryMode: TimePickerEntryMode.inputOnly,
                context: context,
              );

              if (pickedTime1 != null) {
                print(pickedTime1!.format(context)); //output 10:51 PM
                // DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                //converting to DateTime so that we can further format on different pattern.
                // print(parsedTime); //output 1970-01-01 22:53:00.000
                // String formattedTime = DateFormat('HH:mm a').format(parsedTime);
                // print(formattedTime); //output 14:59:00
                //DateFormat() is from intl package, you can format the time on any pattern you need.

                setState(() {
                  updatetimecontroller.text = pickedTime1!.format(context); //set the value of text field.
                });
              } else {
                print("Time is not selected");
              }
            },
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed:
                () {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (_)=>EventCalendarScreen()));

              // Navigator.push(context, MaterialPageRoute(builder: (_)=>EventCalendarScreen()));
            },
            child:
            const Text("Cancel", style: TextStyle(color: Colors.red))),
        ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
            onPressed:
                () {
              FirebaseFirestore.instance.collection("Events").doc(user.uid).collection("Date").doc(id).update({

                'title': updateTitleController.text,
                'description': updateDescController.text,
                'time': updatetimecontroller.text,
              });
              // notificationService.sendSheduleNotification(notify,updatetimecontroller, updateTitleController, updateDescController);
              setState(() {
                // myEvents['time'] = updatetimecontroller.text;
                // myEvents['eventTitle'] = updateTitleController.text;
                // myEvents['eventDescp'] = updateDescController.text;
                // print(element);
                notificationService.sendSheduleNotification(notify ,DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, pickedTime1!.hour, pickedTime1!.minute),updateTitleController.text, updateDescController.text);
                updateTitleController.clear();
                updateDescController.clear();
                updatetimecontroller.clear();
              });
              // Navigator.pop(context);
              Navigator.pop(context);
            },
            child:
            const Text("Update"))
      ],
    );
  }
  Widget deleteFun(String id){
    return AlertDialog(
      content:
      Column(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning,
            color:
            Colors.red,
            size:
            40,
          ),
          const SizedBox(
            height:
            10,
          ),
          const Text(
            "Are you sure?",
            style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height:
            10,
          ),
          const Text(
            "Do you really want to delete this record?",
            style:
            TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height:
            20,
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: const Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection("Events").doc(user.uid).collection("Date").doc(id).delete();

                  // mySelectedEvents[DateFormat('yyyy-MM-dd').format(_selectedDate!)]!.removeWhere((element) => element['eventTitle'] == myEvents['eventTitle']);
                  setState(() {});
                  //Todo Notification Cancel
                  notificationService.cancelNotification();
                  Navigator.pop(context);
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

