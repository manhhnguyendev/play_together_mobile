import 'package:flutter/material.dart';
import 'package:play_together_mobile/pages/home_page.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:play_together_mobile/screen/login_screen/login_page.dart';

class LogoutGooglePage extends StatefulWidget {
  static String routeName = "logout_google";
  @override
  _HomeStateState createState() => _HomeStateState();
}

class _HomeStateState extends State<HomePage> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // late FirebaseAuth _auth;
  // late GoogleSignIn _googleSignIn;

  // Future _handleSignOut() async {
  //   await _auth.signOut();
  //   await _googleSignIn.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("test"),
    );
  }
}




// Scaffold(
//       body: FutureBuilder(
//           future: _initialization,
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return const Text('Something went wrong');
//             }
//             if (snapshot.connectionState == ConnectionState.done) {
//               _auth = FirebaseAuth.instance;
//               _googleSignIn = GoogleSignIn();
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     OutlineButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, LoginPage.routeName);
//                         _handleSignOut();
//                       },
//                       child: const Text('Logout'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//             return const CircularProgressIndicator();
//           }),
//     );
