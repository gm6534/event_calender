import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoApp extends StatefulWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  DemoAppState createState() => DemoAppState();
}

class DemoAppState extends State<DemoApp> {
  String text = '';
  String subject = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Plus Plugin Demo',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Share Plus Plugin Demo'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Share text:',
                      hintText: 'Enter some text and/or link to share',
                    ),
                    maxLines: 2,
                    onChanged: (String value) => setState(() {
                      text = value;
                    }),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Share subject:',
                      hintText: 'Enter subject to share (optional)',
                    ),
                    maxLines: 2,
                    onChanged: (String value) => setState(() {
                      subject = value;
                    }),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add image'),


                  ),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        onPressed: text.isEmpty && imagePaths.isEmpty
                            ? null
                            : () => _onShare(context),
                        child: const Text('Share'),
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        onPressed: text.isEmpty && imagePaths.isEmpty
                            ? null
                            : () => _onShareWithResult(context),
                        child: const Text('Share With Result'),
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _onDeleteImage(int position) {
    setState(() {
      imagePaths.removeAt(position);
      imageNames.removeAt(position);
    });
  }

  void _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;

    if (imagePaths.isNotEmpty) {
      // final files = <XFile>[];
      for (var i = 0; i < imagePaths.length; i++) {
        // files.add(XFile(imagePaths[i], name: imageNames[i]));
      }
      // await Share.shareXFiles(files,
      //     text: text,
      //     subject: subject,
      //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      // await Share.share(text,
      //     subject: subject,
      //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  void _onShareWithResult(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    // ShareResult result;
    // if (imagePaths.isNotEmpty) {
    //   final files = <XFile>[];
    //   for (var i = 0; i < imagePaths.length; i++) {
    //     files.add(XFile(imagePaths[i], name: imageNames[i]));
    //   }
    //   result = await Share.shareXFiles(files,
    //       text: text,
    //       subject: subject,
    //       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    // } else {
    //   result = await Share.shareWithResult(text,
    //       subject: subject,
    //       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  //   }
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text("Share result: ${result.status}"),
  //   )
  // );
  }
}