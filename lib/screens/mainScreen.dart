import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imitra/News_tab/news_tab.dart';
import 'package:imitra/News_tab/youtube_direct.dart';
import 'package:imitra/screens/detect.dart';
import 'package:imitra/screens/tiles.dart';
import 'package:imitra/screens/userAccount.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

import '../Braille/braille.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextToSpeech tts = TextToSpeech();
  _launchEmergencyCall() async {
    final Uri _url = Uri.parse('tel:112');
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw Exception('unwanted error while calling');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tts.speak('welcome');
  }

  @override
  Widget build(BuildContext context) {
    //................................................................... //USER DATA FETCHING
    FirebaseAuth user = FirebaseAuth.instance;
    User? nuser = user.currentUser;
    ListElements listdata = ListElements();
    //......................................................................
    var responsive = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: responsive.size.height,
        width: responsive.size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 8, 78, 135),
            Color.fromARGB(255, 11, 9, 37)
          ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: responsive.size.height * 0.05),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 4, left: responsive.size.width * 0.8),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              NetworkImage(nuser!.photoURL.toString()),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Text("Hello !",
                            style: GoogleFonts.kanit(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 45)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          nuser.displayName.toString().toUpperCase(),
                          style: GoogleFonts.kanit(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Card(
                color: const Color.fromARGB(174, 255, 251, 251),
                margin: const EdgeInsets.all(25),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                ),
                shadowColor: const Color.fromARGB(255, 205, 203, 203),
                elevation: 50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text.rich(TextSpan(
                      text: 'With ',
                      style: GoogleFonts.righteous(
                          color: Colors.black, fontSize: 16),
                      children: [
                        TextSpan(
                          text: 'iMitra',
                          style: GoogleFonts.righteous(
                              color: Colors.red, fontSize: 24),
                        ),
                        TextSpan(
                          text:
                              ' we strive to make the world more accessible to you.',
                          style: GoogleFonts.righteous(
                              color: Colors.black, fontSize: 16),
                        )
                      ])),
                ),
              ),
              Text(
                "Our Services",
                style: GoogleFonts.kanit(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 13),
              Container(
                  height: 180,
                  width: responsive.size.width,
                  alignment: Alignment.center,
                  child: ListView.builder(
                    physics: const PageScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    itemCount: listdata.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Vibration.vibrate();
                          switch (index) {
                            case 0:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetectScreen()));
                              break;
                            case 1:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BrailleKeypad()));
                              break;
                            case 2:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const GetInTouch()));

                            // add cases for other screens as needed
                          }
                        },
                        child: Card(
                          color: const Color.fromARGB(123, 255, 251, 251),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(25, 25))),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      const Color.fromARGB(255, 14, 11, 79),
                                  foregroundImage:
                                      AssetImage(listdata.data[index]['image']),
                                  // child: Text(
                                  //   listdata.data[index]['text'],
                                  //   style: const TextStyle(
                                  //       fontSize: 16,
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  listdata.data[index]['text'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
              const SizedBox(height: 10),
              Container(
                child: Column(
                  children: [
                    Text(
                      'Emergency Call',
                      style: GoogleFonts.kanit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    IconButton(
                        iconSize: 55,
                        color: Colors.red,
                        onPressed: () {
                          _launchEmergencyCall();
                        },
                        icon: const Icon(Icons.dangerous_rounded))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
