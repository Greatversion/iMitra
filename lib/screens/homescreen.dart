import 'package:custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:imitra/Braille/braille.dart';
import 'package:imitra/screens/detect.dart';
import 'package:imitra/screens/mL%20integration/camera_control.dart';
import 'package:imitra/screens/mainScreen.dart';

import 'package:imitra/screens/userAccount.dart';
import 'package:vibration/vibration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomScreens = <Widget>[
      const MainScreen(),
      const DetectScreen(),
      const BrailleKeypad(),
      const UserAccount(),
    ];

    // void onTapIcon

    var responsive = MediaQuery.of(context);
    return Scaffold(
      body: IndexedStack(
        index: selectedPageIndex,
        children: bottomScreens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 8, 78, 135),
          Color.fromARGB(255, 11, 9, 37)
        ])),
        child: CustomBottomBoxBar(
          unselectedItemBoxColor: Colors.transparent,
          duration: 300,
          selectedItemBoxColor: const Color.fromARGB(255, 15, 6, 140),
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white,
          barRadius: 50,
          onIndexChange: (int index) {
            Vibration.vibrate(duration: 800);
            setState(() {
              selectedPageIndex = index;
            });
          },
          inicialIndex: selectedPageIndex,
          items: [
            CustomBottomBoxBarItem(Icons.home_filled,
                const Text('Home', style: TextStyle(color: Colors.white))),
            CustomBottomBoxBarItem(Icons.blind_rounded,
                const Text('Detect', style: TextStyle(color: Colors.white))),
            CustomBottomBoxBarItem(
                Icons.subscript,
                const Text('Braille Learning',
                    style: TextStyle(color: Colors.white))),
            CustomBottomBoxBarItem(Icons.person,
                const Text('Account', style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}

LinearGradient color =
    const LinearGradient(colors: [Colors.black, Colors.pink]);
