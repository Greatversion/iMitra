// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:vibration/vibration.dart';

class BrailleKeypad extends StatefulWidget {
  const BrailleKeypad({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BrailleKeypadState createState() => _BrailleKeypadState();
}

class _BrailleKeypadState extends State<BrailleKeypad> {
  TextToSpeech tts = TextToSpeech();
  List<bool> _dotStatus = List.generate(6, (index) => false);
  final Map<List<bool>, String> _brailleMap = {
    [true, false, false, false, false, false]: 'A',
    [true, true, false, false, false, false]: 'B',
    [true, false, false, true, false, false]: 'C',
    [true, false, false, true, true, false]: 'D',
    [true, false, false, false, true, false]: 'E',
    [true, true, false, true, false, false]: 'F',
    [true, true, false, true, true, false]: 'G',
    [true, true, false, false, true, false]: 'H',
    [false, true, false, true, false, false]: 'I',
    [false, true, false, true, true, false]: 'J',
    [true, false, true, false, false, false]: 'K',
    [true, true, true, false, false, false]: 'L',
    [true, false, true, true, false, false]: 'M',
    [true, false, true, true, true, false]: 'N',
    [true, false, true, false, true, false]: 'O',
    [true, true, true, true, false, false]: 'P',
    [true, true, true, true, true, false]: 'Q',
    [true, true, true, false, true, false]: 'R',
    [false, true, true, true, false, false]: 'S',
    [false, true, true, true, true, false]: 'T',
    [true, false, true, false, false, true]: 'U',
    [true, true, true, false, false, true]: 'V',
    [false, true, false, true, true, true]: 'W',
    [true, false, true, true, false, true]: 'X',
    [true, false, true, true, true, true]: 'Y',
    [true, false, true, false, true, true]: 'Z',
  };
  String _currentCharacter = '';

  void _toggleDotStatus(int dotIndex) async {
    setState(() {
      _dotStatus[dotIndex] = !_dotStatus[dotIndex];
      _updateCurrentCharacter();
    });
  }

  void _clearDotStatus() {
    setState(() {
      _dotStatus = List.generate(6, (index) => false);
    });
  }

  void _updateCurrentCharacter() {
    _brailleMap.forEach((pattern, character) {
      if (_dotStatus
          .asMap()
          .entries
          .every((entry) => entry.value == pattern[entry.key])) {
        setState(() {
          _currentCharacter = character;
          // ignore: prefer_interpolation_to_compose_strings
          tts.speak("You have Entered " + _currentCharacter);
        });
      }
    });
  }


  

  @override
  Widget build(BuildContext context) {
    var responsive = MediaQuery.of(context);
    return Container(
      height: responsive.size.height,
      width: responsive.size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 8, 78, 135),
          Color.fromARGB(255, 11, 9, 37)
        ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Text(
              _currentCharacter,
              style: const TextStyle(color: Colors.white, fontSize: 44),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDotButton(
                0,
                const Text(
                  "1",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
              ),
              const SizedBox(width: 20),
              _buildDotButton(
                3,
                const Text(
                  "4",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDotButton(
                1,
                const Text(
                  "2",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              const SizedBox(width: 20),
              _buildDotButton(
                4,
                const Text(
                  "5",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDotButton(
                2,
                const Text(
                  "3",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              const SizedBox(width: 20),
              _buildDotButton(
                5,
                const Text(
                  "6 ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            child: ElevatedButton(
              onPressed: _clearDotStatus,
              child: const Text('Clear'),
            ),
          ),
        ],
      ),
    );
  }

  void onTap(int k) {
    // ignore: unrelated_type_equality_checks

    Vibration.vibrate(amplitude: 50, intensities: [100]);

    _toggleDotStatus(k);
  }

  var number = const Text("");

  Widget _buildDotButton(int dotIndex, Widget number) {
    return GestureDetector(
      onTap: () {
        onTap(dotIndex);
      },
      child: Column(
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: _dotStatus[dotIndex] ? Colors.black : Colors.grey[300],
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Center(
              child: number,
            ),
          ),
        ],
      ),
    );
  }
}
