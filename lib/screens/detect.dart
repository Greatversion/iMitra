import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';

import 'mL integration/camera_control.dart';

class DetectScreen extends StatelessWidget {
  const DetectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var responsive = MediaQuery.of(context);

    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: responsive.size.height,
          width: responsive.size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 8, 78, 135),
              Color.fromARGB(255, 11, 9, 37)
            ]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 32, left: 6),
                //   child:
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 7, top: responsive.size.height * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to iMitra Object Detection 👁️‍🗨️",
                        style: GoogleFonts.kanit(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 45),
                      Text(
                        "Step 1 : Open Camera.",
                        style: GoogleFonts.oswald(
                            color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "Step 2 : Get the Phone to the Person's Shirt/T-shirt.",
                        style: GoogleFonts.oswald(
                            color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "Step 3 : Start Getting the Instructions whenever any,",
                        style: GoogleFonts.oswald(
                            color: Colors.white, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 54),
                        child: Text(
                          "Object comes infront of the Person's way.",
                          style: GoogleFonts.oswald(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                    onPressed: () async {
                      Vibration.vibrate();
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CameraControl()));
                    },
                    child: const Text("Open Camera 📸"))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
