// import 'dart:convert';
// import 'package:event_calender/Widgets/Meetings.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter/material.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDate;
//
//   Map<String, List> mySelectedEvents = {};
//
//   TextEditingController updateTitleController = TextEditingController();
//   TextEditingController updateDescController = TextEditingController();
//   TextEditingController updatetimecontroller = TextEditingController();
//
//   final titleController = TextEditingController();
//   final descpController = TextEditingController();
//   final timecontroller = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _selectedDate = _focusedDay;
//
//     // loadPreviousEvents();
//   }
//
//   // loadPreviousEvents() {
//   //   mySelectedEvents = {
//   //     "2022-09-13": [
//   //       {"eventDescp": "11", "eventTitle": "111","time" : "05:00 PM"},
//   //       {"eventDescp": "22", "eventTitle": "22","time" : "05:00 PM"}
//   //     ],
//   //     "2022-09-30": [
//   //       {"eventDescp": "22", "eventTitle": "22","time" : "05:00 PM"}
//   //     ],
//   //     "2022-09-20": [
//   //       {"eventTitle": "ss", "eventDescp": "ss","time" : "05:00 PM"}
//   //
//   //     ]
//   //   };
//   // }
//
//   List _listOfDayEvents(DateTime dateTime) {
//     if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
//       return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
//     } else {
//       return [];
//     }
//   }
//
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
//             SizedBox(
//               height: 30,
//             ),
//
//             ///
//             TextField(
//               controller: timecontroller, //editing controller of this TextField
//               decoration: InputDecoration(
//                   icon: Icon(Icons.timer), //icon of text field
//                   labelText: "Enter Time" //label text of field
//                   ),
//               readOnly:
//                   true, //set it true, so that user will not able to edit text
//               onTap: () async {
//                 TimeOfDay? pickedTime = await showTimePicker(
//                   initialTime: TimeOfDay.now(),
//                   initialEntryMode: TimePickerEntryMode.inputOnly,
//                   context: context,
//                 );
//
//                 if (pickedTime != null) {
//                   print(pickedTime.format(context)); //output 10:51 PM
//
//                   setState(() {
//                     timecontroller.text = pickedTime
//                         .format(context); //set the value of text field.
//                   });
//                 } else {
//                   print("Time is not selected");
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
//             onPressed: () {
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
//               } else {
//                 print(titleController.text);
//                 print(descpController.text);
//
//                 setState(() {
//                   if (mySelectedEvents[
//                           DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
//                       null) {
//                     mySelectedEvents[
//                             DateFormat('yyyy-MM-dd').format(_selectedDate!)]
//                         ?.add({
//                       "eventTitle": titleController.text,
//                       "eventDescp": descpController.text,
//                       "time": timecontroller.text,
//                     });
//                   } else {
//                     mySelectedEvents[
//                         DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
//                       {
//                         "eventTitle": titleController.text,
//                         "eventDescp": descpController.text,
//                         "time": timecontroller.text,
//                       }
//                     ];
//                   }
//                 });
//
//                 print(
//                     "New Event for backend developer ${json.encode(mySelectedEvents)}");
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           backgroundColor: Colors.blue.shade700,
//           elevation: 0,
//           centerTitle: true,
//           title: const Text('Event Calendar App'),
//         ),
//         body: _layoutDetails(),
//         bottomNavigationBar: _bottomLayoutDetails(),
//         floatingActionButtonLocation: _fabLocationDetails(),
//         floatingActionButton: _fabLayoutDetails()
//
//     );
//   }
// ///Widgets LandScape and Portrait Layout
//
//   Widget _fabLayoutDetails(){
//     Orientation orientation = MediaQuery.of(context).orientation;
//     if(orientation == Orientation.portrait){
//       return SpeedDial(
//         activeLabel: Text("Event"),
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
//
//     }else{
//       return SpeedDial(
//         direction: SpeedDialDirection.up,
//         activeLabel: Text("Event"),
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
//
//    _fabLocationDetails(){
//     Orientation orientation = MediaQuery.of(context).orientation;
//     if(orientation == Orientation.portrait){
//       return FloatingActionButtonLocation.miniEndDocked;
//
//     }else{
//       return FloatingActionButtonLocation.miniEndFloat;
//     }
//   }
//
//   Widget _bottomLayoutDetails(){
//     Orientation orientation = MediaQuery.of(context).orientation;
//     if(orientation == Orientation.portrait){
//       return BottomAppBar(
//         elevation: 0,
//         color: Colors.blue.shade700,
//         shape: CircularNotchedRectangle(),
//         child: Row(
//           children: [
//             SizedBox(
//               height: 40,
//             )
//           ],
//         ),
//       );
//     }else{
//       return Container(
//         // color: Colors.red,
//         height: 0,
//         width: 0,
//       );
//     }
//   }
//
//   Widget _layoutDetails() {
//     Orientation orientation = MediaQuery.of(context).orientation;
//     if (orientation == Orientation.portrait) {
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
//                   formatButtonTextStyle: TextStyle(color: Colors.white),
//                   formatButtonShowsNext: false,
//                 ),
//                 firstDay: DateTime(2022),
//                 lastDay: DateTime(2023),
//                 focusedDay: _focusedDay,
//                 calendarFormat: _calendarFormat,
//                 rowHeight: 60,
//                 calendarStyle: CalendarStyle(
//                   cellMargin: EdgeInsets.zero,
//                   todayDecoration: BoxDecoration(color: Colors.orangeAccent),
//                   selectedDecoration:
//                       BoxDecoration(color: Colors.indigo.shade500),
//                   tableBorder: TableBorder(
//                       verticalInside: BorderSide(width: 0.2),
//                       horizontalInside: BorderSide(width: 0.2)),
//                   // rangeHighlightColor: Colors.orange,
//                   rowDecoration: BoxDecoration(shape: BoxShape.rectangle),
//                   markersMaxCount: 1,
//                   markerSize: 15,
//                   markerDecoration: BoxDecoration(
//                       color: Colors.teal.shade500, shape: BoxShape.rectangle),
//                   markersAlignment: Alignment.bottomRight,
//                   markerMargin: EdgeInsets.only(bottom: 20),
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
//           DraggableScrollableSheet(
//             // expand: true,
//             initialChildSize: 0.07,
//             minChildSize: 0.07,
//             maxChildSize: 0.86,
//             // expand: false,
//             builder: (context, controller) {
//               return Container(
//                 decoration: BoxDecoration(
//                     color: Colors.blue.shade700,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     )),
//                 // /height: MediaQuery.of(context).size.height * 0.3,
//
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListView(
//                     controller: controller,
//                     children: [
//                       SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.drag_handle,
//                               size: 40,
//                               color: Colors.white,
//                             ),
//                             Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   "Events",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 )),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Align(
//                                     alignment: Alignment.bottomLeft,
//                                     child: dayPredicted(
//                                         _selectedDate!, DateTime.now()),
//
//                                     //  _selectedDate!.day - DateTime.now().day < 0
//                                     //     ? Text('${(_selectedDate!.day - DateTime.now().day) * -1} ')
//                                     //     : Text("${_selectedDate!.day - DateTime.now().day}"),
//                                   ),
//                                   Spacer(),
//                                   Align(
//                                     alignment: Alignment.bottomRight,
//                                     child: mySelectedEvents[DateFormat(
//                                                     'yyyy-MM-dd')
//                                                 .format(_selectedDate!)] ==
//                                             null
//                                         ? Text(
//                                             "Click on + Button to Add Event",
//                                             style: TextStyle(
//                                                 color: Colors.white),
//                                           )
//                                         : Text(
//                                             " ${mySelectedEvents[DateFormat('yyyy-MM-dd').format(_selectedDate!)]!.length} Events",
//                                             style: TextStyle(
//                                                 color: Colors.white),
//                                           ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             ..._listOfDayEvents(_selectedDate!).map(
//                               (myEvents) => Padding(
//                                 padding: const EdgeInsets.only(bottom: 8.0),
//                                 child: ExpansionPanelList(
//                                   children: [
//                                     ExpansionPanel(
//                                       isExpanded: true,
//                                       backgroundColor: Colors.teal,
//                                       headerBuilder: (BuildContext context, bool isExpanded) {
//                                         return ListTile(
//                                           leading: const Icon(
//                                             Icons.done,
//                                             color: Colors.white,
//                                           ),
//                                           title: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 bottom: 8.0),
//                                             child: Text(
//                                               'Title:   ${myEvents['eventTitle']}',
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                           subtitle: Text(
//                                             'Description:   ${myEvents['eventDescp']}',
//                                             style:
//                                             TextStyle(color: Colors.white),
//                                           ),
//                                           trailing: Text(
//                                             "Time\n${myEvents['time']}",
//                                             style:
//                                             TextStyle(color: Colors.white),
//                                           ),
//                                         );
//                                     }, body: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                       children: [
//                                         IconButton(
//                                             onPressed: (){
//                                               ///Portrait Edit Function
//                                               showDialog(
//                                                 // barrierDismissible: false,
//                                                   context:
//                                                   context,
//                                                   builder:
//                                                       (context) {
//                                                     //TODO alerDialogeBOx
//                                                     return AlertDialog(
//                                                       scrollable: true,
//                                                       elevation:
//                                                       0,
//                                                       content:
//                                                       Column(
//                                                         mainAxisSize:
//                                                         MainAxisSize.min,
//                                                         children: [
//                                                           TextFormField(
//                                                             controller: updateTitleController,
//                                                             decoration: InputDecoration(hintText: "Title"),
//                                                           ),
//                                                           TextFormField(
//                                                             controller: updateDescController,
//                                                             decoration: InputDecoration(hintText: "Description"),
//                                                           ),
//                                                           SizedBox(
//                                                             height: 30,
//                                                           ),
//
//                                                           ///
//                                                           TextField(
//                                                             controller: updatetimecontroller, //editing controller of this TextField
//                                                             decoration: InputDecoration(
//                                                                 icon: Icon(Icons.timer), //icon of text field
//                                                                 labelText: "Enter Time" //label text of field
//                                                             ),
//                                                             readOnly: true, //set it true, so that user will not able to edit text
//                                                             onTap: () async {
//                                                               TimeOfDay? pickedTime = await showTimePicker(
//                                                                 initialTime: TimeOfDay.now(),
//                                                                 initialEntryMode: TimePickerEntryMode.inputOnly,
//                                                                 context: context,
//                                                               );
//
//                                                               if (pickedTime != null) {
//                                                                 print(pickedTime.format(context)); //output 10:51 PM
//                                                                 // DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
//                                                                 //converting to DateTime so that we can further format on different pattern.
//                                                                 // print(parsedTime); //output 1970-01-01 22:53:00.000
//                                                                 // String formattedTime = DateFormat('HH:mm a').format(parsedTime);
//                                                                 // print(formattedTime); //output 14:59:00
//                                                                 //DateFormat() is from intl package, you can format the time on any pattern you need.
//
//                                                                 setState(() {
//                                                                   updatetimecontroller.text = pickedTime.format(context); //set the value of text field.
//                                                                 });
//                                                               } else {
//                                                                 print("Time is not selected");
//                                                               }
//                                                             },
//                                                           )
//                                                         ],
//                                                       ),
//                                                       actions: [
//                                                         TextButton(
//                                                             onPressed: () {
//                                                               Navigator.pop(context);
//                                                               // Navigator.push(context, MaterialPageRoute(builder: (_)=>EventCalendarScreen()));
//
//                                                               // Navigator.push(context, MaterialPageRoute(builder: (_)=>EventCalendarScreen()));
//                                                             },
//                                                             child: Text("Cancel")),
//                                                         ElevatedButton(
//                                                             onPressed: () {
//                                                               setState(() {
//                                                                 myEvents['time'] = updatetimecontroller.text;
//                                                                 myEvents['eventTitle'] = updateTitleController.text;
//                                                                 myEvents['eventDescp'] = updateDescController.text;
//                                                                 // print(element);
//                                                                 updateTitleController.clear();
//                                                                 updateDescController.clear();
//                                                                 updatetimecontroller.clear();
//                                                               });
//                                                               // Navigator.pop(context);
//                                                               Navigator.pop(context);
//                                                             },
//                                                             child: Text("Update"))
//                                                       ],
//                                                     );
//                                                   });
//                                               ///
//
//                                             },
//                                             icon: Icon(Icons.edit_calendar_outlined, color: Colors.white,)),
//                                         IconButton(
//                                             onPressed: (){
//                                               showDialog(
//                                                   context: context,
//                                                   builder: (context){
//                                                     return AlertDialog(
//                                                       content: Column(
//                                                         mainAxisSize: MainAxisSize.min,
//                                                         children: [
//                                                           Icon(Icons.warning, color: Colors.red, size: 40,),
//                                                           SizedBox(height: 10,),
//                                                           Text("Are you sure?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
//                                                           SizedBox(height: 10,),
//                                                           Text("Do you really want to delete this record?", style: TextStyle(color: Colors.grey,),),
//                                                           SizedBox(height: 20,),
//                                                           Row(
//                                                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                             children: [
//                                                               ElevatedButton(
//                                                                 onPressed: (){
//                                                                   Navigator.pop(context);
//                                                                 },
//                                                                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
//                                                                 child: Text("No", style: TextStyle(color: Colors.white),),),
//                                                               ElevatedButton(
//                                                                 onPressed: (){
//                                                                   mySelectedEvents[DateFormat('yyyy-MM-dd')
//                                                                       .format(_selectedDate!)]!.removeWhere((element) => element['eventTitle']==myEvents['eventTitle']);
//                                                                   setState(() {
//
//                                                                   });
//                                                                   Navigator.pop(context);
//                                                                 },
//                                                                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
//                                                                 child: Text("Yes", style: TextStyle(color: Colors.white),),)
//                                                             ],
//                                                           )
//                                                         ],
//                                                       ),
//                                                     );
//                                                   });
//                                               // Navigator.pop(context);
//                                             },
//                                             icon: Icon(CupertinoIcons.delete_solid, color: Colors.white,))
//                                       ],
//                                     ),
//                                     ),
//                                   ]
//                                 ),
//                               ),
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
//     } else {
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
//                   formatButtonTextStyle: TextStyle(color: Colors.white),
//                   formatButtonShowsNext: false,
//                 ),
//                 firstDay: DateTime(2022),
//                 lastDay: DateTime(2023),
//                 focusedDay: _focusedDay,
//                 calendarFormat: _calendarFormat,
//                 rowHeight: 60,
//                 calendarStyle: CalendarStyle(
//                   cellMargin: EdgeInsets.zero,
//                   todayDecoration:
//                       BoxDecoration(color: Colors.orangeAccent),
//                   selectedDecoration:
//                       BoxDecoration(color: Colors.indigo.shade500),
//                   tableBorder: TableBorder(
//                       verticalInside: BorderSide(width: 0.2),
//                       horizontalInside: BorderSide(width: 0.2)),
//                   // rangeHighlightColor: Colors.orange,
//                   rowDecoration: BoxDecoration(shape: BoxShape.rectangle),
//                   markersMaxCount: 1,
//                   markerSize: 15,
//                   markerDecoration: BoxDecoration(
//                       color: Colors.teal.shade500,
//                       shape: BoxShape.rectangle),
//                   markersAlignment: Alignment.bottomRight,
//                   markerMargin: EdgeInsets.only(bottom: 20),
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
//           Expanded(
//             child: Container(
//               height: 272,
//               decoration: BoxDecoration(
//                   color: Colors.blue.shade700,
//                   ),
//               // /height: MediaQuery.of(context).size.height * 0.3,
//
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListView(
//                   children: [
//                     SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Align(
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
//                                 Spacer(),
//                                 Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: mySelectedEvents[DateFormat(
//                                       'yyyy-MM-dd')
//                                       .format(_selectedDate!)] ==
//                                       null
//                                       ? Text(
//                                     "0 Event",
//                                     style: TextStyle(
//                                         color: Colors.white),
//                                   )
//                                       : Text(
//                                     " ${mySelectedEvents[DateFormat('yyyy-MM-dd').format(_selectedDate!)]!.length} Events",
//                                     style: TextStyle(
//                                         color: Colors.white),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           ..._listOfDayEvents(_selectedDate!).map(
//                                 (myEvents) => Padding(
//                               padding: const EdgeInsets.only(bottom: 8.0),
//                               child: Card(
//                                 margin: EdgeInsets.zero,
//                                 color: Colors.teal,
//                                 child: Tooltip(
//                                   message: 'This is an Event',
//                                   padding: const EdgeInsets.all(20),
//                                   showDuration:
//                                   const Duration(seconds: 10),
//                                   decoration: ShapeDecoration(
//                                     color: Colors.orangeAccent,
//                                     shape: ToolTipCustomShape(),
//                                   ),
//                                   textStyle: const TextStyle(
//                                       color: Colors.white),
//                                   preferBelow: false,
//                                   verticalOffset: 20,
//                                   child: ListTile(
//                                     onTap: () {
//                                       showDialog(
//                                           context: context,
//                                           builder: (context) {
//                                             return AlertDialog(
//                                               contentPadding: EdgeInsets.zero,
//                                               content: Column(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 mainAxisSize:
//                                                 MainAxisSize.min,
//                                                 children: [
//                                                   SizedBox(height: 20,),
//                                                   Text(
//                                                     "Action",
//                                                     style: TextStyle(
//                                                       color: Colors.red,
//                                                         fontWeight:
//                                                         FontWeight
//                                                             .bold),
//                                                   ),
//                                                   SizedBox(
//                                                     height: 20,
//                                                   ),
//                                                   Column(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .center,
//                                                     children: [
//                                                       ListTile(
//                                                         onTap: (){
//                                                           showDialog(
//                                                             // barrierDismissible: false,
//                                                               context:
//                                                               context,
//                                                               builder:
//                                                                   (context) {
//                                                                 //TODO alerDialogeBOx
//                                                                 return AlertDialog(
//                                                                   scrollable: true,
//                                                                   elevation:
//                                                                   0,
//                                                                   content:
//                                                                   Column(
//                                                                     mainAxisSize:
//                                                                     MainAxisSize.min,
//                                                                     children: [
//                                                                       TextFormField(
//                                                                         controller: updateTitleController,
//                                                                         decoration: InputDecoration(hintText: "Title"),
//                                                                       ),
//                                                                       TextFormField(
//                                                                         controller: updateDescController,
//                                                                         decoration: InputDecoration(hintText: "Description"),
//                                                                       ),
//                                                                       SizedBox(
//                                                                         height: 30,
//                                                                       ),
//
//                                                                       ///
//                                                                       TextField(
//                                                                         controller: updatetimecontroller, //editing controller of this TextField
//                                                                         decoration: InputDecoration(
//                                                                             icon: Icon(Icons.timer), //icon of text field
//                                                                             labelText: "Enter Time" //label text of field
//                                                                         ),
//                                                                         readOnly: true, //set it true, so that user will not able to edit text
//                                                                         onTap: () async {
//                                                                           TimeOfDay? pickedTime = await showTimePicker(
//                                                                             initialTime: TimeOfDay.now(),
//                                                                             initialEntryMode: TimePickerEntryMode.inputOnly,
//                                                                             context: context,
//                                                                           );
//
//                                                                           if (pickedTime != null) {
//                                                                             print(pickedTime.format(context)); //output 10:51 PM
//                                                                             // DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
//                                                                             //converting to DateTime so that we can further format on different pattern.
//                                                                             // print(parsedTime); //output 1970-01-01 22:53:00.000
//                                                                             // String formattedTime = DateFormat('HH:mm a').format(parsedTime);
//                                                                             // print(formattedTime); //output 14:59:00
//                                                                             //DateFormat() is from intl package, you can format the time on any pattern you need.
//
//                                                                             setState(() {
//                                                                               updatetimecontroller.text = pickedTime.format(context); //set the value of text field.
//                                                                             });
//                                                                           } else {
//                                                                             print("Time is not selected");
//                                                                           }
//                                                                         },
//                                                                       )
//                                                                     ],
//                                                                   ),
//                                                                   actions: [
//                                                                     TextButton(
//                                                                         onPressed: () {
//                                                                           Navigator.pop(context);
//                                                                           // Navigator.push(context, MaterialPageRoute(builder: (_)=>EventCalendarScreen()));
//
//                                                                           // Navigator.push(context, MaterialPageRoute(builder: (_)=>EventCalendarScreen()));
//                                                                         },
//                                                                         child: Text("Cancel")),
//                                                                     ElevatedButton(
//                                                                         onPressed: () {
//                                                                           setState(() {
//                                                                             myEvents['time'] = updatetimecontroller.text;
//                                                                             myEvents['eventTitle'] = updateTitleController.text;
//                                                                             myEvents['eventDescp'] = updateDescController.text;
//                                                                             // print(element);
//                                                                             updateTitleController.clear();
//                                                                             updateDescController.clear();
//                                                                             updatetimecontroller.clear();
//                                                                           });
//                                                                           Navigator.pop(context);
//                                                                           Navigator.pop(context);
//                                                                         },
//                                                                         child: Text("Update"))
//                                                                   ],
//                                                                 );
//                                                               });
//                                                         },
//                                                         trailing: Icon(Icons.edit),
//                                                         leading: Text("Edit"),
//                                                       ),
//                                                       ListTile(
//                                                         onTap: (){
//                                                           // titleController.clear();
//                                                           mySelectedEvents[DateFormat('yyyy-MM-dd')
//                                                               .format(_selectedDate!)]!.removeWhere((element) => element['eventTitle']==myEvents['eventTitle']);
//                                                           setState(() {
//
//                                                           });
//                                                           Navigator.pop(context);
//                                                         },
//                                                         trailing: Icon(Icons.delete),
//                                                         leading: Text("Delete"),
//                                                       ),
//                                                       TextButton(
//                                                           onPressed: () {
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                           child: Text(
//                                                               "Cancel")),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             );
//                                           });
//                                     },
//                                     leading: const Icon(
//                                       Icons.done,
//                                       color: Colors.white,
//                                     ),
//                                     title: Padding(
//                                       padding: const EdgeInsets.only(
//                                           bottom: 8.0),
//                                       child: Text(
//                                         'Title:   ${myEvents['eventTitle']}',
//                                         style: TextStyle(
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                     subtitle: Text(
//                                       'Description:   ${myEvents['eventDescp']}',
//                                       style:
//                                       TextStyle(color: Colors.white),
//                                     ),
//                                     trailing: Text(
//                                       "Time\n${myEvents['time']}",
//                                       style:
//                                       TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
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
//     }
//   }
//
//   ///
//
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
//           style: TextStyle(color: Colors.white),
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
//           style: TextStyle(color: Colors.white),
//         );
//       }
//     } else {
//       return const Text(
//         "Today",
//         style: TextStyle(color: Colors.white),
//       );
//     }
//   }
// }
