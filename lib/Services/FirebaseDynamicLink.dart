// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
//
// import '../Pages/ViewAllWidget.dart';
//
// // createShortDynamicLink(String link) async{
// //   final dynamicLinkParams = DynamicLinkParameters(
// //     link: Uri.parse(link),
// //     uriPrefix: "https://evecalendar.page.link",
// //     androidParameters: const AndroidParameters(packageName: "com.gm.event_calender"),
// //
// //   );
// //   final dynamicLink =
// //   await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
// //   return dynamicLink.shortUrl;
// // }
//
//
//
// class _MainScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<_MainScreen> {
//   String? _linkMessage;
//   bool _isCreatingLink = false;
//
//   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
//   final String _testString =
//       'To test: long press link and then copy and click from a non-browser '
//       "app. Make sure this isn't being tested on iOS simulator and iOS xcode "
//       'is properly setup. Look at firebase_dynamic_links/README.md for more '
//       'details.';
//
//   final String DynamicLink = 'https://evecalendar.page.link';
//   final String Link = 'https://evecalendar.page.link/pzok';
//
//   @override
//   void initState() {
//     super.initState();
//     initDynamicLinks();
//   }
//
//   Future<void> initDynamicLinks() async {
//     dynamicLinks.onLink.listen((dynamicLinkData) {
//       Navigator.pushNamed(context, dynamicLinkData.link.path);
//     }).onError((error) {
//       print('onLink error');
//       print(error.message);
//     });
//   }
//
//   Future<void> _createDynamicLink(bool short, linkurl) async {
//     setState(() {
//       _isCreatingLink = true;
//     });
//
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://evecalendar.page.link',
//       longDynamicLink: Uri.parse(linkurl),
//       link: Uri.parse(DynamicLink),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.gm.event_calender',
//         minimumVersion: 0,
//       ),
//     );
//
//     Uri url;
//     if (short) {
//       final ShortDynamicLink shortLink =
//       await dynamicLinks.buildShortLink(parameters);
//       url = shortLink.shortUrl;
//     } else {
//       url = await dynamicLinks.buildLink(parameters);
//     }
//
//     setState(() {
//       _linkMessage = url.toString();
//       _isCreatingLink = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }