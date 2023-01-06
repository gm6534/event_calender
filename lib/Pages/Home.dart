// import 'dart:async';
// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:event_calender/Pages/LoginPage.dart';
// import 'package:event_calender/Services/Notification_Services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:intl/intl.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter/material.dart';
// import 'package:timeline_tile/timeline_tile.dart';
//
// import '../Modal/ListModal.dart';
//
// Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
// User get user => FirebaseAuth.instance.currentUser!;
// TimeOfDay? pickedTime;
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   //Todo Variables
//   NotificationService notificationService = NotificationService();
//   DateTime now = DateTime.now();
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDate;
//   TimeOfDay? pickedTime1;
//   Map<String, List> mySelectedEvents = {};
//   List<Event> allData = [];
//   List<String> monthName = [
//     'Jan',
//     'Feb',
//     'Mar',
//     'Apr',
//     'May',
//     'Jun',
//     'Jul',
//     'Aug',
//     'Sep',
//     'Oct',
//     'Nov',
//     'Dec',
//   ];
//   List<String> yearName = [
//     '2022',
//     '2023',
//     '2024',
//     '2025',
//   ];
//
//   int markers = 1;
//
//   int notify = 0;
//
//   //Todo Controllers
//   TextEditingController updateTitleController = TextEditingController();
//   TextEditingController updateDescController = TextEditingController();
//   TextEditingController updatetimecontroller = TextEditingController();
//   final titleController = TextEditingController();
//   final descpController = TextEditingController();
//   final timecontroller = TextEditingController();
//
//
//   //Todo initState
//   @override
//   void initState() {
//     super.initState();
//     _selectedDate = _focusedDay;
//     // loadPreviousEvents();
//     notificationService;//Todo Notification Data
//     notificationService.androidIntializeNotification();
//     // ;
//     // SystemChrome.setPreferredOrientations([
//     //   DeviceOrientation.landscapeRight,
//     //   DeviceOrientation.landscapeLeft,
//     //   DeviceOrientation.portraitUp,
//     //   DeviceOrientation.portraitDown,
//     // ]);
//
//   }
//
//
//
//   // Map<String,dynamic> map = {
//   //   "2022-09-13": [
//   //     {"eventDescp": "11", "eventTitle": "111", "time": "05:00 PM"},
//   //     {"eventDescp": "22", "eventTitle": "22", "time": "05:00 PM"}
//   //   ],
//   //   "2022-09-30": [
//   //     {"eventDescp": "22", "eventTitle": "22", "time": "05:00 PM"}
//   //   ],
//   //   "2022-09-20": [
//   //     {"eventTitle": "ss", "eventDescp": "ss", "time": "05:00 PM"}
//   //   ]
//   // };
//
//
//
//
// //Todo Main Scaffold
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: _appBarDetails(),
//         body: _layoutDetails(),
//         bottomNavigationBar: _bottomLayoutDetails(),
//         floatingActionButtonLocation: _fabLocationDetails(),
//         floatingActionButton: _fabLayoutDetails());
//   }
//
//   // List<bool> isExpanded = [true, false];
//
//   ///Todo Widgets LandScape and Portrait Layout
//
//   //Todo _showAddEventDialog
//   _showAddEventDialog() async {
//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         scrollable: true,
//         title: const Text(
//           'Add To Calender',
//           textAlign: TextAlign.center,
//         ),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: titleController,
//               textCapitalization: TextCapitalization.words,
//               decoration: const InputDecoration(
//                 labelText: 'Title',
//               ),
//             ),
//             TextField(
//               controller: descpController,
//               textCapitalization: TextCapitalization.words,
//               decoration: const InputDecoration(labelText: 'Description'),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//
//             ///
//             TextField(
//               controller: timecontroller, //editing controller of this TextField
//               decoration: const InputDecoration(
//                   icon: Icon(Icons.timer), //icon of text field
//                   labelText: "Enter Time" //label text of field
//               ),
//               readOnly:
//               true, //set it true, so that user will not able to edit text
//               onTap: () async {
//                 pickedTime = await showTimePicker(
//                   initialTime: TimeOfDay.now(),
//                   initialEntryMode: TimePickerEntryMode.inputOnly,
//                   context: context,
//                 );
//
//                 if (pickedTime != null) {
//                   print(pickedTime!.format(context)); //output 10:51 PM
//
//                   setState(() {
//                     timecontroller.text = pickedTime!
//                         .format(context); //set the value of text field.
//                   });
//                 } else {
//                   print("Time is not selected");
//
//                 }
//               },
//             )
//
//             ///
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             child: const Text('Add'),
//             onPressed: () async {
//               if (titleController.text.isEmpty &&
//                   descpController.text.isEmpty) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Required title and description'),
//                     duration: Duration(seconds: 2),
//                   ),
//                 );
//                 //Navigator.pop(context);
//                 return;
//               }
//               else if ((mySelectedEvents[DateFormat('yyyy-MM-dd')
//                   .format(_selectedDate!)] !=
//                   null) &&
//                   (mySelectedEvents[
//                   DateFormat('yyyy-MM-dd').format(_selectedDate!)]!
//                       .any((element) =>
//                   element['time'] ==
//                       timecontroller.text.toString()))) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text(
//                             " you are trying to add other event on same time")));
//                 titleController.clear();
//                 descpController.clear();
//                 timecontroller.clear();
//
//                 Navigator.pop(context);
//                 setState(() {});
//                 // log("Time Collapse");
//               } else {
//                 // User? userCredential=FirebaseAuth.instance.currentUser;
//
//
//
//                 FirebaseFirestore.instance
//                     .collection("Events") .doc(user.uid).collection("Date").doc()
//
//                 // .doc(DateTime.now().toString())
//                     .set(
//                     {
//
//                       'title': titleController.text,
//                       'description': descpController.text,
//                       'time': timecontroller.text,
//                       'month':_focusedDay.month,
//                       'year':_focusedDay.year,
//                       'createdOn':_focusedDay,
//                       'date': DateFormat.yMMMMd('en_US').format(_focusedDay)
//
//                     }
//                 );
//
//
//                 setState(() {
//                   if (mySelectedEvents[DateFormat('yyyy-MM-dd')
//                       .format(_selectedDate!)] !=
//                       null) {
//                     mySelectedEvents[
//                     DateFormat('yyyy-MM-dd').format(_selectedDate!)]
//                         ?.add({
//                       "eventTitle": titleController.text,
//                       "eventDescp": descpController.text,
//                       "time": timecontroller.text
//                     });
//
//                     notify = mySelectedEvents[
//                     DateFormat('yyyy-MM-dd')
//                         .format(_selectedDate!)]!
//                         .indexWhere((element) =>
//                     element['time'] == timecontroller.text);
//
//
//                     //Todo view all list code
//
//                     allData.add(Event(
//                         eventTitle: titleController.text,
//                         eventDescp: descpController.text,
//                         time: timecontroller.text));
//                   } else {
//                     mySelectedEvents[
//                     DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
//                       {
//                         "eventTitle": titleController.text,
//                         "eventDescp": descpController.text,
//                         "time": timecontroller.text
//                       }
//                     ];
//                   }
//                 });
//                 notificationService.sendSheduleNotification(
//                     notify,
//                     DateTime(
//                         _selectedDate!.year,
//                         _selectedDate!.month,
//                         _selectedDate!.day,
//                         pickedTime!.hour,
//                         pickedTime!.minute),
//                     titleController.text,
//                     descpController.text);
//                 print(
//                     "New Event for backend developer ${json.encode(
//                         mySelectedEvents)}");
//                 titleController.clear();
//                 descpController.clear();
//                 timecontroller.clear();
//                 Navigator.pop(context);
//                 return;
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }
//
//   //Todo _listOfDayEvents
//   List _listOfDayEvents(DateTime dateTime) {
//     if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
//       return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
//     } else {
//       return [];
//     }
//   }
//
//   // List<Event> _getEventsForDay(DateTime day) {
//   //   // Implementation example
//   //   return kEvents[day] ?? [];
//   // }
//
//
//   // //Todo loadPreviousEvents
//   // loadPreviousEvents() {
//   //   mySelectedEvents = {
//   //     "2022-09-13": [
//   //       {"eventDescp": "11", "eventTitle": "111", "time": "05:00 PM"},
//   //       {"eventDescp": "22", "eventTitle": "22", "time": "05:00 PM"}
//   //     ],
//   //     "2022-09-30": [
//   //       {"eventDescp": "22", "eventTitle": "22", "time": "05:00 PM"}
//   //     ],
//   //     "2022-09-20": [
//   //       {"eventTitle": "ss", "eventDescp": "ss", "time": "05:00 PM"}
//   //     ]
//   //   };
//   // }
//
//   //Todo dayPredicted
//   dayPredicted(DateTime _selectedDate, DateTime today) {
//     if (_selectedDate.day - today.day < 0) {
//       // (_selectedDate.day - today.day) * -1;
//
//       if (_selectedDate.day - today.day == -1) {
//         // print("yesterdat");
//         return const Text(
//           "Yesterday",
//           style: TextStyle(color: Colors.white),
//         );
//       } else {
//         // print(('${(_selectedDate.day - today.day) * -1} day(s) ago'));
//         return Text(
//           '${(_selectedDate.day - today.day) * -1} day(s) ago',
//           style: const TextStyle(color: Colors.white),
//         );
//       }
//     } else if (_selectedDate.day - today.day > 0) {
//       if (_selectedDate.day - today.day == 1) {
//         return const Text(
//           "Tomorrow",
//           style: TextStyle(color: Colors.white),
//         );
//       } else {
//         // print('in ${_selectedDate.day - today.day} day(s)');
//         return Text(
//           'in ${_selectedDate.day - today.day} day(s)',
//           style: const TextStyle(color: Colors.white),
//         );
//       }
//     } else {
//       return const Text(
//         "Today",
//         style: TextStyle(color: Colors.white),
//       );
//     }
//   }
//
//   //Todo _layoutDetails
//   Widget _layoutDetails() {
//     Orientation orientation = MediaQuery.of(context).orientation;
//     if (orientation == Orientation.portrait) {
//       ///Portrait Property
//       return Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey, width: 0.5),
//                   borderRadius: BorderRadius.circular(20)),
//               height: MediaQuery.of(context).size.height * 0.65,
//               child: TableCalendar(
//                 headerStyle: HeaderStyle(
//                   titleCentered: true,
//                   formatButtonDecoration: BoxDecoration(
//                     color: Colors.blue.shade700,
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   formatButtonTextStyle: const TextStyle(color: Colors.white),
//                   formatButtonShowsNext: false,
//                 ),
//                 firstDay: DateTime(2022),
//                 lastDay: DateTime(2025),
//                 focusedDay: _focusedDay,
//                 calendarFormat: _calendarFormat,
//                 rowHeight: 60,
//                 calendarStyle: CalendarStyle(
//                   cellMargin: EdgeInsets.zero,
//                   todayDecoration: const BoxDecoration(color: Colors.orangeAccent),
//                   selectedDecoration:
//                   BoxDecoration(color: Colors.indigo.shade500),
//                   tableBorder: const TableBorder(
//                       verticalInside: BorderSide(width: 0.2),
//                       horizontalInside: BorderSide(width: 0.2)),
//                   // rangeHighlightColor: Colors.orange,
//                   rowDecoration: const BoxDecoration(shape: BoxShape.rectangle),
//                   markersMaxCount: 1,
//                   markerSize: 15,
//                   markerDecoration: BoxDecoration(
//                       color: Colors.teal.shade500, shape: BoxShape.rectangle),
//                   markersAlignment: Alignment.bottomRight,
//                   markerMargin: const EdgeInsets.only(bottom: 20),
//                 ),
//                 startingDayOfWeek: StartingDayOfWeek.monday,
//                 weekendDays: const [DateTime.saturday, DateTime.sunday],
//                 shouldFillViewport: true,
//                 // calendarStyle: CalendarStyle(),
//                 onDaySelected: (selectedDay, focusedDay) {
//                   ///Tooltip Function
//                   //     () {
//                   //       return
//                   //       CustomTooltip();
//                   //     };
//                   ///
//
//                   if (!isSameDay(_selectedDate, selectedDay)) {
//                     // Call `setState()` when updating the selected day
//                     setState(() {
//                       _selectedDate = selectedDay;
//                       _focusedDay = focusedDay;
//                     });
//                   }
//                 },
//
//                 ///
//                 selectedDayPredicate: (day) {
//                   return isSameDay(_selectedDate, day);
//                 },
//
//                 ///
//                 onFormatChanged: (format) {
//                   if (_calendarFormat != format) {
//                     // Call `setState()` when updating calendar format
//                     setState(() {
//                       _calendarFormat = format;
//                     });
//                   }
//                 },
//                 onPageChanged: (focusedDay) {
//                   // No need to call `setState()` here
//                   _focusedDay = focusedDay;
//                 },
//                 eventLoader: _listOfDayEvents,
//               ),
//             ),
//           ),
//           // Positioned(
//           //   left: 40,
//           //   right: 40,
//           //   bottom: 70,
//           //     child: Icon(Icons.keyboard_double_arrow_up_outlined)
//           // ),
//           //Todo DraggableScrollableSheet
//           DraggableScrollableSheet(
//             // expand: true,
//             initialChildSize: 0.07,
//             minChildSize: 0.07,
//             maxChildSize: 1,
//             // expand: false,
//             builder: (context, controller) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade700,
//                   // borderRadius: const BorderRadius.only(
//                   //   topLeft: Radius.circular(20),
//                   //   topRight: Radius.circular(20),
//                   // )
//                 ),
//                 // /height: MediaQuery.of(context).size.height * 0.3,
//
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//
//                       Expanded(
//                         child: ListView(
//                           controller: controller,
//                           children: [
//                             Container(
//                               height: 80,
//                               child: Column(
//                                 children: [
//                                   const Icon(
//                                     Icons.drag_handle,
//                                     size: 40,
//                                     color: Colors.white,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 8, right: 8),
//                                     child: Row(
//                                       children: [
//                                         const Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Text(
//                                               "Events",
//                                               style: TextStyle(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.white,
//                                               ),
//                                             )),
//                                         const Spacer(),
//                                         Text(DateFormat.yMMMMd('en_US').format(_focusedDay), style: const TextStyle(
//                                             color: Colors.white)),
//
//                                       ],
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                             StreamBuilder(
//                               stream: FirebaseFirestore.instance
//                                   .collection("Events")
//                                   .doc(user!.uid)
//                                   .collection("Date")
//                                   .where("date",isEqualTo: DateFormat.yMMMMd('en_US')
//                                   .format(_focusedDay)).snapshots(),
//
//                               builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){
//
//                                 switch (snapshot.connectionState){
//                                   case ConnectionState.none:
//                                   case ConnectionState.waiting:
//                                     return Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         SizedBox(height: 160,),
//                                         CircularProgressIndicator(color: Colors.white,),
//                                         SizedBox(height: 10,),
//                                         Text("Loading....", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                                       ],
//                                     );
//
//                                   default:
//                                     if(snapshot.hasData){
//                                       if(snapshot.data.docs.isNotEmpty){
//
//                                         return Column(
//                                           children: [
//                                             Center(child: snapshot.data.docs.isEmpty
//                                                 ? const Text(
//                                               "",
//                                               style: TextStyle(fontSize: 16),
//                                             )
//                                                 :
//
//                                             snapshot.data.docs.length  ==
//                                                 1
//                                                 ?  Text("${snapshot.data.docs.length.toString()} Event in the List",
//                                                 style: TextStyle(fontSize: 16, color: Colors.white))
//                                                 : Text(
//                                                 " ${snapshot.data.docs.length} Events in the List",
//                                                 style: const TextStyle(fontSize: 16, color: Colors.white)),),
//                                             Container(
//                                               height: MediaQuery.of(context).size.height/1.5,
//                                               child: ListView.builder(itemBuilder: (context, index) {
//                                                 var id=snapshot.data.docs[index].id;
//                                                 return Padding(
//                                                   padding: const EdgeInsets.all(3.0),
//                                                   child: Card(
//                                                     margin: EdgeInsets.zero,
//                                                     elevation: 3,
//                                                     child: ExpansionTile(
//
//                                                       trailing: const Text(""),
//                                                       tilePadding: EdgeInsets.zero,
//                                                       collapsedIconColor:
//                                                       Colors.white,
//                                                       collapsedBackgroundColor:
//                                                       Colors.teal,
//                                                       backgroundColor: Colors.teal,
//                                                       title: ListTile(
//                                                         // leading: const Icon(
//                                                         //   Icons.done,
//                                                         //   color: Colors.white,
//                                                         // ),
//                                                         title: Padding(
//                                                           padding:
//                                                           const EdgeInsets.only(
//                                                               bottom: 8.0),
//                                                           child: Text(
//                                                             'Title:   ${snapshot.data.docs[index]['title'].toString()}',
//                                                             style: const TextStyle(fontWeight: FontWeight.bold,
//                                                                 fontSize: 15,
//                                                                 color: Colors.white
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         subtitle: Text(
//                                                           'Description:   ${snapshot.data.docs[index]['description'].toString()}',
//                                                           style: const TextStyle(
//                                                               color: Colors.white),
//                                                         ),
//                                                         trailing: Text("${snapshot.data.docs[index]['time']}",
//                                                           style: TextStyle(
//                                                               fontSize: 15,
//                                                               color: Colors.white
//                                                           ),),
//                                                       ),
//
//                                                       children: [
//                                                         ColoredBox(
//                                                           color: Colors.teal.shade600,
//                                                           child: Container(
//                                                               width: double.infinity,
//                                                               height: 50,
//                                                               child:
//                                                               Row(
//                                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                                 children: [
//                                                                   SizedBox(width: 15,),
//                                                                   IconButton(
//                                                                       onPressed: (){
//
//                                                                         String message = "Title: ${snapshot.data.docs[index]['title'].toString()}\nDescription:\n${snapshot.data.docs[index]['description'].toString()}\n${snapshot.data.docs[index]['time']}\n${snapshot.data.docs[index]['date']}";
//                                                                         Share.share(message);
//
//                                                                       },
//                                                                       icon: Icon(Icons.share_rounded, color: Colors.white,)
//                                                                   ),
//                                                                   SizedBox(width: 15,),
//                                                                   IconButton(onPressed: (){
//                                                                     showDialog(context: context, builder: (context){
//                                                                       return updateFun(snapshot.data.docs[index].id, snapshot.data.docs[index]['title'].toString(), snapshot.data.docs[index]['description'].toString(), snapshot.data.docs[index]['time'].toString());
//                                                                     });
//                                                                   }, icon: Icon(Icons.edit_calendar_outlined, color: Colors.white,)),
//                                                                   SizedBox(width: 15,),
//                                                                   IconButton(onPressed: (){
//
//                                                                     showDialog(context: context, builder: (context){
//                                                                       return deleteFun(snapshot.data.docs[index].id);
//                                                                     });
//
//                                                                   }, icon: Icon(Icons.delete, color: Colors.white,)),
//                                                                   SizedBox(width: 15,),
//                                                                 ],
//                                                               )),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 );
//                                               }, itemCount: snapshot.data.docs.length, shrinkWrap: true,
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       }
//                                       else{
//                                         return   Column(
//                                           children: [
//                                             const SizedBox(
//                                               height: 170,
//                                             ),
//                                             const Text(
//                                               "Click on + Button to Add Event",
//                                               style:
//                                               TextStyle(color: Colors.white),
//                                             ),
//                                           ],
//                                         );
//                                       }
//
//                                     }
//                                     else{
//                                       return const  Center(child: Text("Error Occured...."),);
//                                     }
//                                 }
//
//
//
//
//
//                               } ,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           )
//         ],
//       );
//       ///End Portrait Property
//     } else {
//       ///LAndScape Property
//       return Row(
//         children: [
//           Expanded(
//             child: Container(
//               height: 270,
//               width: 350,
//               child: TableCalendar(
//                 headerStyle: HeaderStyle(
//                   titleCentered: true,
//                   formatButtonDecoration: BoxDecoration(
//                     color: Colors.blue.shade700,
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   formatButtonTextStyle: const TextStyle(color: Colors.white),
//                   formatButtonShowsNext: false,
//                 ),
//                 firstDay: DateTime(2022),
//                 lastDay: DateTime(2023),
//                 focusedDay: _focusedDay,
//                 calendarFormat: _calendarFormat,
//                 rowHeight: 60,
//                 calendarStyle: CalendarStyle(
//                   cellMargin: EdgeInsets.zero,
//                   todayDecoration: const BoxDecoration(color: Colors.orangeAccent),
//                   selectedDecoration:
//                   BoxDecoration(color: Colors.indigo.shade500),
//                   tableBorder: const TableBorder(
//                       verticalInside: BorderSide(width: 0.2),
//                       horizontalInside: BorderSide(width: 0.2)),
//                   // rangeHighlightColor: Colors.orange,
//                   rowDecoration: const BoxDecoration(shape: BoxShape.rectangle),
//                   markersMaxCount: markers,
//                   markerSize: 15,
//                   markerDecoration: BoxDecoration(
//                       color: Colors.teal.shade500, shape: BoxShape.rectangle),
//                   markersAlignment: Alignment.bottomRight,
//                   markerMargin: const EdgeInsets.only(bottom: 20),
//                 ),
//                 startingDayOfWeek: StartingDayOfWeek.monday,
//                 weekendDays: const [DateTime.saturday, DateTime.sunday],
//                 shouldFillViewport: true,
//                 // calendarStyle: CalendarStyle(),
//                 onDaySelected: (selectedDay, focusedDay) {
//                   ///Tooltip Function
//                   //     () {
//                   //       return
//                   //       CustomTooltip();
//                   //     };
//                   ///
//
//                   if (!isSameDay(_selectedDate, selectedDay)) {
//                     // Call `setState()` when updating the selected day
//                     setState(() {
//                       _selectedDate = selectedDay;
//                       _focusedDay = focusedDay;
//                     });
//                   }
//                 },
//
//                 ///
//                 selectedDayPredicate: (day) {
//                   return isSameDay(_selectedDate, day);
//                 },
//
//                 ///
//                 onFormatChanged: (format) {
//                   if (_calendarFormat != format) {
//                     // Call `setState()` when updating calendar format
//                     setState(() {
//                       _calendarFormat = format;
//                     });
//                   }
//                 },
//                 onPageChanged: (focusedDay) {
//                   // No need to call `setState()` here
//                   _focusedDay = focusedDay;
//                 },
//                 eventLoader: _listOfDayEvents,
//               ),
//             ),
//           ),
//           mySelectedEvents[DateFormat('yyyy-MM-dd').format(_selectedDate!)] ==
//               null
//               ? Container(
//             height: 0,
//             width: 0,
//           )
//               : mySelectedEvents[
//           DateFormat('yyyy-MM-dd').format(_selectedDate!)]!
//               .length ==
//               0
//               ? Container(
//             height: 0,
//             width: 0,
//           )
//               : Expanded(
//             child: Container(
//               height: 272,
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade700,
//               ),
//               // /height: MediaQuery.of(context).size.height * 0.3,
//
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListView(
//                   children: [
//                     SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "Events",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               )),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 Align(
//                                   alignment: Alignment.bottomLeft,
//                                   child: dayPredicted(
//                                       _selectedDate!, DateTime.now()),
//
//                                   //  _selectedDate!.day - DateTime.now().day < 0
//                                   //     ? Text('${(_selectedDate!.day - DateTime.now().day) * -1} ')
//                                   //     : Text("${_selectedDate!.day - DateTime.now().day}"),
//                                 ),
//                                 const Spacer(),
//                                 Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: Text(
//                                     " ${mySelectedEvents[DateFormat('yyyy-MM-dd').format(_selectedDate!)]!.length} Events",
//                                     style: const TextStyle(
//                                         color: Colors.white),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           ..._listOfDayEvents(_selectedDate!).map(
//                                 (myEvents) => Padding(
//                               padding:
//                               const EdgeInsets.only(bottom: 8.0),
//                               child: ExpansionTile(
//                                 trailing: const SizedBox(
//                                   width: 0,
//                                 ),
//                                 tilePadding: EdgeInsets.zero,
//                                 collapsedIconColor: Colors.white,
//                                 collapsedBackgroundColor: Colors.teal,
//                                 backgroundColor: Colors.teal,
//                                 title: ListTile(
//                                   leading: const Icon(
//                                     Icons.done,
//                                     color: Colors.white,
//                                   ),
//                                   title: Padding(
//                                     padding: const EdgeInsets.only(
//                                         bottom: 8.0),
//                                     child: Text(
//                                       'Title:   ${myEvents['eventTitle']}',
//                                       style: const TextStyle(
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                   subtitle: Text(
//                                     'Description:   ${myEvents['eventDescp']}',
//                                     style: const TextStyle(
//                                         color: Colors.white),
//                                   ),
//                                   trailing: Text(
//                                     "Time\n${myEvents['time']}",
//                                     style: const TextStyle(
//                                         color: Colors.white),
//                                   ),
//                                 ),
//                                 children: [
//                                   ColoredBox(
//                                     color: Colors.teal.shade600,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment
//                                           .spaceAround,
//                                       children: [
//                                         IconButton(
//                                             onPressed: () {
//                                               ///Todo LandScape Edit Function
//                                               showDialog(
//                                                 // barrierDismissible: false,
//                                                   context: context,
//                                                   builder: (context) {
//                                                     return AlertDialog(
//                                                       scrollable:
//                                                       true,
//                                                       elevation: 0,
//                                                       content: Column(
//                                                         mainAxisSize:
//                                                         MainAxisSize
//                                                             .min,
//                                                         children: [
//                                                           Text("Update Event", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue.shade700),),
//                                                           TextFormField(
//                                                             controller:
//                                                             updateTitleController,
//                                                             decoration:
//                                                             const InputDecoration(
//                                                                 hintText: "Title"),
//                                                           ),
//                                                           TextFormField(
//                                                             controller:
//                                                             updateDescController,
//                                                             decoration:
//                                                             const InputDecoration(
//                                                                 hintText: "Description"),
//                                                           ),
//                                                           const SizedBox(
//                                                             height:
//                                                             30,
//                                                           ),
//
//                                                           ///
//                                                           TextField(
//                                                             controller:
//                                                             updatetimecontroller, //editing controller of this TextField
//                                                             decoration: const InputDecoration(
//                                                                 icon: Icon(Icons.timer), //icon of text field
//                                                                 labelText: "Enter Time" //label text of field
//                                                             ),
//                                                             readOnly:
//                                                             true, //set it true, so that user will not able to edit text
//                                                             onTap:
//                                                                 () async {
//                                                               TimeOfDay?
//                                                               pickedTime =
//                                                               await showTimePicker(
//                                                                 initialTime:
//                                                                 TimeOfDay.now(),
//                                                                 initialEntryMode:
//                                                                 TimePickerEntryMode.inputOnly,
//                                                                 context:
//                                                                 context,
//                                                               );
//
//                                                               if (pickedTime !=
//                                                                   null) {
//                                                                 print(
//                                                                     pickedTime.format(context)); //output 10:51 PM
//                                                                 // DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
//                                                                 //converting to DateTime so that we can further format on different pattern.
//                                                                 // print(parsedTime); //output 1970-01-01 22:53:00.000
//                                                                 // String formattedTime = DateFormat('HH:mm a').format(parsedTime);
//                                                                 // print(formattedTime); //output 14:59:00
//                                                                 //DateFormat() is from intl package, you can format the time on any pattern you need.
//
//                                                                 setState(
//                                                                         () {
//                                                                       updatetimecontroller.text =
//                                                                           pickedTime.format(context); //set the value of text field.
//                                                                     });
//                                                               } else {
//                                                                 print(
//                                                                     "Time is not selected");
//                                                               }
//                                                             },
//                                                           )
//                                                         ],
//                                                       ),
//                                                       actions: [
//                                                         TextButton(
//                                                             onPressed:
//                                                                 () {
//                                                               Navigator.pop(
//                                                                   context);
//                                                               // Navigator.push(context, MaterialPageRoute(builder: (_)=>EventCalendarScreen()));
//
//                                                               // Navigator.push(context, MaterialPageRoute(builder: (_)=>EventCalendarScreen()));
//                                                             },
//                                                             child: const Text(
//                                                               "Cancel", style: TextStyle(color: Colors.red),)),
//                                                         ElevatedButton(
//                                                             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
//                                                             onPressed:
//                                                                 () {
//                                                               // notificationService.sendSheduleNotification(notify, updatetimecontroller, updateTitleController, updateDescController);
//                                                               setState(
//                                                                       () {
//                                                                     myEvents['time'] =
//                                                                         updatetimecontroller.text;
//                                                                     myEvents['eventTitle'] =
//                                                                         updateTitleController.text;
//                                                                     myEvents['eventDescp'] =
//                                                                         updateDescController.text;
//                                                                     // print(element);
//                                                                     notificationService.sendSheduleNotification(notify ,DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, pickedTime1!.hour, pickedTime1!.minute),updateTitleController.text, updateDescController.text);
//                                                                     updateTitleController
//                                                                         .clear();
//                                                                     updateDescController
//                                                                         .clear();
//                                                                     updatetimecontroller
//                                                                         .clear();
//                                                                   });
//                                                               // Navigator.pop(context);
//                                                               Navigator.pop(
//                                                                   context);
//                                                             },
//                                                             child: const Text(
//                                                                 "Update"))
//                                                       ],
//                                                     );
//                                                   });
//
//                                               ///
//                                             },
//                                             icon: const Icon(
//                                               Icons
//                                                   .edit_calendar_outlined,
//                                               color: Colors.white,
//                                             )),
//                                         IconButton(
//                                             onPressed: () {
//                                               //Todo local Delete Function
//                                               showDialog(
//                                                   context: context,
//                                                   builder: (context) {
//                                                     return AlertDialog(
//                                                       content: Column(
//                                                         mainAxisSize:
//                                                         MainAxisSize
//                                                             .min,
//                                                         children: [
//                                                           const Icon(
//                                                             Icons
//                                                                 .warning,
//                                                             color: Colors
//                                                                 .red,
//                                                             size: 40,
//                                                           ),
//                                                           const SizedBox(
//                                                             height:
//                                                             10,
//                                                           ),
//                                                           const Text(
//                                                             "Are you sure?",
//                                                             style: TextStyle(
//                                                                 fontWeight: FontWeight
//                                                                     .bold,
//                                                                 fontSize:
//                                                                 20),
//                                                           ),
//                                                           const SizedBox(
//                                                             height:
//                                                             10,
//                                                           ),
//                                                           const Text(
//                                                             "Do you really want to delete this record?",
//                                                             style:
//                                                             TextStyle(
//                                                               color: Colors
//                                                                   .grey,
//                                                             ),
//                                                           ),
//                                                           const SizedBox(
//                                                             height:
//                                                             20,
//                                                           ),
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceAround,
//                                                             children: [
//                                                               ElevatedButton(
//                                                                 onPressed:
//                                                                     () {
//                                                                   Navigator.pop(context);
//                                                                 },
//                                                                 style:
//                                                                 ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
//                                                                 child:
//                                                                 const Text(
//                                                                   "No",
//                                                                   style:
//                                                                   TextStyle(color: Colors.white),
//                                                                 ),
//                                                               ),
//                                                               ElevatedButton(
//                                                                 onPressed:
//                                                                     () {
//                                                                   mySelectedEvents[DateFormat('yyyy-MM-dd').format(_selectedDate!)]!.removeWhere((element) =>
//                                                                   element['eventTitle'] ==
//                                                                       myEvents['eventTitle']);
//                                                                   setState(() {});
//                                                                   //Todo Notification Cancel 2
//                                                                   notificationService.cancelNotification();
//                                                                   Navigator.pop(context);
//                                                                 },
//                                                                 style:
//                                                                 ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
//                                                                 child:
//                                                                 const Text(
//                                                                   "Yes",
//                                                                   style:
//                                                                   TextStyle(color: Colors.white),
//                                                                 ),
//                                                               )
//                                                             ],
//                                                           )
//                                                         ],
//                                                       ),
//                                                     );
//                                                   });
//                                               // Navigator.pop(context);
//                                             },
//                                             icon: const Icon(
//                                               CupertinoIcons
//                                                   .delete_solid,
//                                               color: Colors.white,
//                                             ))
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//       ///End LandScape Property
//     }
//   }
//
//   //Todo _bottomLayoutDetails
//   Widget _bottomLayoutDetails() {
//     Orientation orientation = MediaQuery.of(context).orientation;
//     if (orientation == Orientation.portrait) {
//       return BottomAppBar(
//         elevation: 0,
//         color: Colors.blue.shade700,
//         shape: const CircularNotchedRectangle(),
//         child: Row(
//           children: [
//             const SizedBox(
//               width: 20,
//             ),
//             //Todo View all Button Portrait
//             const SizedBox(
//               height: 40,
//             )
//           ],
//         ),
//       );
//     } else {
//       return Container(
//         // color: Colors.red,
//         height: 0,
//         width: 0,
//       );
//     }
//   }
//
//   //Todo _fabLayoutDetails
//   Widget _fabLayoutDetails() {
//     Orientation orientation = MediaQuery.of(context).orientation;
//     if (orientation == Orientation.portrait) {
//       return SpeedDial(
//         activeLabel: const Text("Event"),
//         backgroundColor: Colors.orangeAccent,
//         spaceBetweenChildren: 10,
//         // shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         animatedIcon: AnimatedIcons.add_event,
//         children: [
//           // SpeedDialChild(
//           //   child: Icon(Icons.event),
//           //   label: "Event"
//           // ),
//           SpeedDialChild(
//               onTap: () {
//                 // notificationService.sendNotification("title","body");
//                 _showAddEventDialog();
//               },
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Icon(
//                 Icons.task_alt_outlined,
//                 color: Colors.blue.shade800,
//               ),
//               label: "Task"),
//           SpeedDialChild(
//               onTap: () {
//                 _showAddEventDialog();
//               },
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Icon(
//                 Icons.touch_app_outlined,
//                 color: Colors.blue.shade800,
//               ),
//               label: "Reminder"),
//           SpeedDialChild(
//               onTap: () {
//                 _showAddEventDialog();
//               },
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Icon(
//                 Icons.flag_outlined,
//                 color: Colors.blue.shade800,
//               ),
//               label: "Goal"),
//           SpeedDialChild(
//               onTap: () {
//                 _showAddEventDialog();
//               },
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Icon(
//                 Icons.event_busy_outlined,
//                 color: Colors.blue.shade800,
//               ),
//               label: "Out of office"),
//         ],
//       );
//     } else {
//       return SpeedDial(
//         direction: SpeedDialDirection.up,
//         activeLabel: const Text("Event"),
//         backgroundColor: Colors.orangeAccent,
//         spaceBetweenChildren: 10,
//         // shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         animatedIcon: AnimatedIcons.add_event,
//         children: [
//           // SpeedDialChild(
//           //   child: Icon(Icons.event),
//           //   label: "Event"
//           // ),
//           SpeedDialChild(
//               onTap: () {
//                 _showAddEventDialog();
//               },
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Icon(
//                 Icons.task_alt_outlined,
//                 color: Colors.blue.shade800,
//               ),
//               label: "Task"),
//           SpeedDialChild(
//               onTap: () {
//                 _showAddEventDialog();
//               },
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Icon(
//                 Icons.touch_app_outlined,
//                 color: Colors.blue.shade800,
//               ),
//               label: "Reminder"),
//           SpeedDialChild(
//               onTap: () {
//                 _showAddEventDialog();
//               },
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Icon(
//                 Icons.flag_outlined,
//                 color: Colors.blue.shade800,
//               ),
//               label: "Goal"),
//           SpeedDialChild(
//               onTap: () {
//                 _showAddEventDialog();
//               },
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Icon(
//                 Icons.event_busy_outlined,
//                 color: Colors.blue.shade800,
//               ),
//               label: "Out of office"),
//         ],
//       );
//     }
//   }
//   //Todo APPBar Widget
//   _appBarDetails(){
//     Orientation orientation = MediaQuery.of(context).orientation;
//     if (orientation == Orientation.portrait) {
//       return AppBar(
//         backgroundColor: Colors.blue.shade700,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text('EveCalendar'),
//       );
//     } else {
//       return AppBar(
//         backgroundColor: Colors.blue.shade700,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text('EveCalendar'),
//       );
//     }
//   }
//
//   //Todo _fabLocationDetails
//   _fabLocationDetails() {
//     Orientation orientation = MediaQuery.of(context).orientation;
//     if (orientation == Orientation.portrait) {
//       return FloatingActionButtonLocation.miniEndDocked;
//     } else {
//       return FloatingActionButtonLocation.miniEndFloat;
//     }
//   }
//
//   ///
// // uploadToFirestore() async {
// //     User? newuser=FirebaseAuth.instance.currentUser;
// //     print(user.uid);
// // DocumentReference documentReference= FirebaseFirestore.instance.collection("Date") .doc(newuser
// //     !.uid);
// //    documentReference.set(
// //       {
// //         "eventTitle": "titleController.text",
// //         "eventDescp": "descpController.text",
// //         "time": "timecontroller.text"
// //       });
// //
// // }
//   getFeedDataByYear() async {
//     var db = await FirebaseFirestore.instance
//         .collection("Year")
//         .doc(_focusedDay.year.toString()).collection("Month")
//         .doc(_focusedDay.month.toString()).collection("Date").doc(_focusedDay.toString()).collection("Time").doc(timecontroller.text.toString())
//         .get();
//     setState(() {
//       // allData = List.from(db.docs.map((doc) => Event.fromSnapshot(doc)));
//     });
//   }
//   //Todo Update FireBase Fun
//   Widget updateFun(String id, String title, String desc, String time){
//     return AlertDialog(
//       scrollable:
//       true,
//       elevation:
//       0,
//       content:
//       Column(
//         mainAxisSize:
//         MainAxisSize.min,
//         children: [
//           Text("Update Event", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue.shade700),),
//           TextFormField(
//             controller:
//             updateTitleController,
//             decoration:
//             InputDecoration(hintText: "${title.toString()}"),
//           ),
//           TextFormField(
//             controller:
//             updateDescController,
//             decoration:
//             InputDecoration(hintText: "${desc.toString()}"),
//           ),
//           const SizedBox(
//             height:
//             30,
//           ),
//
//           ///
//           TextField(
//             controller:
//             updatetimecontroller, //editing controller of this TextField
//             decoration:  InputDecoration(
//                 icon: Icon(Icons.timer), //icon of text field
//                 labelText: "${time.toString()}" //label text of field
//             ),
//             readOnly:
//             true, //set it true, so that user will not able to edit text
//             onTap:
//                 () async {
//               pickedTime1 = await showTimePicker(
//                 initialTime: TimeOfDay.now(),
//                 initialEntryMode: TimePickerEntryMode.inputOnly,
//                 context: context,
//               );
//
//               if (pickedTime1 != null) {
//                 print(pickedTime1!.format(context)); //output 10:51 PM
//                 // DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
//                 //converting to DateTime so that we can further format on different pattern.
//                 // print(parsedTime); //output 1970-01-01 22:53:00.000
//                 // String formattedTime = DateFormat('HH:mm a').format(parsedTime);
//                 // print(formattedTime); //output 14:59:00
//                 //DateFormat() is from intl package, you can format the time on any pattern you need.
//
//                 setState(() {
//                   updatetimecontroller.text = pickedTime1!.format(context); //set the value of text field.
//                 });
//               } else {
//                 print("Time is not selected");
//               }
//             },
//           )
//         ],
//       ),
//       actions: [
//         TextButton(
//             onPressed:
//                 () {
//               Navigator.pop(context);
//               // Navigator.push(context, MaterialPageRoute(builder: (_)=>EventCalendarScreen()));
//
//               // Navigator.push(context, MaterialPageRoute(builder: (_)=>EventCalendarScreen()));
//             },
//             child:
//             const Text("Cancel", style: TextStyle(color: Colors.red))),
//         ElevatedButton(
//             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
//             onPressed:
//                 () {
//               FirebaseFirestore.instance.collection("Events").doc(user.uid).collection("Date").doc(id).update({
//
//                 'title': updateTitleController.text,
//                 'description': updateDescController.text,
//                 'time': updatetimecontroller.text,
//               });
//               // notificationService.sendSheduleNotification(notify,updatetimecontroller, updateTitleController, updateDescController);
//               setState(() {
//                 // myEvents['time'] = updatetimecontroller.text;
//                 // myEvents['eventTitle'] = updateTitleController.text;
//                 // myEvents['eventDescp'] = updateDescController.text;
//                 // print(element);
//                 notificationService.sendSheduleNotification(notify ,DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, pickedTime1!.hour, pickedTime1!.minute),updateTitleController.text, updateDescController.text);
//                 updateTitleController.clear();
//                 updateDescController.clear();
//                 updatetimecontroller.clear();
//               });
//               // Navigator.pop(context);
//               Navigator.pop(context);
//             },
//             child:
//             const Text("Update"))
//       ],
//     );
//   }
//   Widget deleteFun(String id){
//     return AlertDialog(
//       content:
//       Column(
//         mainAxisSize:
//         MainAxisSize.min,
//         children: [
//           const Icon(
//             Icons.warning,
//             color:
//             Colors.red,
//             size:
//             40,
//           ),
//           const SizedBox(
//             height:
//             10,
//           ),
//           const Text(
//             "Are you sure?",
//             style:
//             TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//           const SizedBox(
//             height:
//             10,
//           ),
//           const Text(
//             "Do you really want to delete this record?",
//             style:
//             TextStyle(
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(
//             height:
//             20,
//           ),
//           Row(
//             mainAxisAlignment:
//             MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
//                 child: const Text(
//                   "No",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   FirebaseFirestore.instance.collection("Events").doc(user.uid).collection("Date").doc(id).delete();
//
//                   // mySelectedEvents[DateFormat('yyyy-MM-dd').format(_selectedDate!)]!.removeWhere((element) => element['eventTitle'] == myEvents['eventTitle']);
//                   setState(() {});
//                   //Todo Notification Cancel
//                   notificationService.cancelNotification();
//                   Navigator.pop(context);
//                 },
//                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
//                 child: const Text(
//                   "Yes",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
