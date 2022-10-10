import 'package:flutter/material.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  TextEditingController controller = TextEditingController();
  // final auth = FirebaseAuth.instance;
  // User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
          automaticallyImplyLeading: true,
          title: Text("Reset Password"),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(hintText: "Reset Email"),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue.shade800),
                      ),
                        onPressed: () {
                          // print(controller.text.trim());
                          // resetPassword(controller.text.trim());
                        },
                        child: Text("Reset",)))
              ],
            )),
      ),
    );
  }

  // resetPassword(String email) async {
  //   try {
  //     await auth.sendPasswordResetEmail(email: email);
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Email Sent")));
  //     // .catchError((e) => print(e));
  //   } on FirebaseAuthException catch (ex) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(ex.code.toString())));
  //   }
  // }
// resetPassword(String email) async {
//   // if (user != auth.currentUser) {
//   await auth
//       .sendPasswordResetEmail(email: email)
//       .then((value) => ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Email Sent"))))
//       .catchError(
//           (e) => FirebaseAuthException(code: "Some Thing Gone Wrong"));
//   // }
//   //  on FirebaseAuthException catch (ex) {
//   //   ScaffoldMessenger.of(context)
//   //       .showSnackBar(SnackBar(content: Text(ex.code.toString())));
//   // }
// }
}
