import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imitra/screens/login_functionality/loginscreen.dart';
import 'package:vibration/vibration.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googlesigin = GoogleSignIn();
  Future<void> signOutGoogle() async {
    await auth.signOut();
    await googlesigin.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    googlesigin.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final nuser1 = auth.currentUser;
    var responsive = MediaQuery.of(context);
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 8, 78, 135),
              Color.fromARGB(255, 11, 9, 37)
            ]),
          ),
          height: responsive.size.height,
          width: responsive.size.width,
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 45.0, bottom: 20),
              child: CircleAvatar(
                radius: 55,
                foregroundImage: NetworkImage(nuser1!.photoURL.toString()),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                nuser1.displayName.toString().toUpperCase(),
                style: GoogleFonts.kanit(
                    shadows: [const Shadow(blurRadius: 50)],
                    color: Colors.white,
                    fontSize: 25,
                    backgroundColor: const Color.fromARGB(255, 68, 89, 100)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 15.0, bottom: 10),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Personal Details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Column(
                    children: const [
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        iconColor: Color.fromARGB(255, 116, 116, 116),
                        title: Text(
                          "User Name",
                          style: TextStyle(
                              color: Color.fromARGB(255, 116, 116, 116)),
                        ),
                        trailing: Text(
                          "Edit",
                          style: TextStyle(color: Colors.blue),
                        ),
                        leading: Icon(Icons.account_box, size: 30),
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        iconColor: Color.fromARGB(255, 116, 116, 116),
                        title: Text(
                          "Email",
                          style: TextStyle(
                              color: Color.fromARGB(255, 116, 116, 116)),
                        ),
                        trailing: Text(
                          "Edit",
                          style: TextStyle(color: Colors.blue),
                        ),
                        leading: Icon(Icons.email_rounded, size: 30),
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        iconColor: Color.fromARGB(255, 116, 116, 116),
                        title: Text(
                          "Contact No.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 116, 116, 116)),
                        ),
                        trailing: Text(
                          "Edit",
                          style: TextStyle(color: Colors.blue),
                        ),
                        leading: Icon(Icons.call, size: 30),
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        iconColor: Color.fromARGB(255, 116, 116, 116),
                        title: Text(
                          "Give us Feedback",
                          style: TextStyle(
                              color: Color.fromARGB(255, 116, 116, 116)),
                        ),
                        trailing: Text(
                          "Edit",
                          style: TextStyle(color: Colors.blue),
                        ),
                        leading: Icon(Icons.feedback_rounded, size: 30),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        const Text(
                          "Log Out",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 244, 241, 241)),
                        ),
                        IconButton(
                            onPressed: () {
                              Vibration.vibrate();
                              signOutGoogle();
                              if (auth.currentUser == null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const SignInScreen()));
                              }
                            },
                            icon: const Icon(
                              Icons.logout_rounded,
                              size: 38,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
