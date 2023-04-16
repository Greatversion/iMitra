import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';

class MyObjectDetector extends StatefulWidget {
  const MyObjectDetector({super.key});

  @override
  _MyObjectDetectorState createState() => _MyObjectDetectorState();
}

class _MyObjectDetectorState extends State<MyObjectDetector> {
  late final ObjectDetector _objectDetector;

  @override
  void initState() {
    super.initState();
    _initializeObjectDetector();
  }

  Future<void> _initializeObjectDetector() async {
    final modelPath = await _getModel('assets/ml/object_labeler.tflite');
    final options = LocalObjectDetectorOptions(
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true, mode: DetectionMode.stream,
    );
    _objectDetector = GoogleMlKit.vision.objectDetector(options: options);
    await _objectDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    // Implement your UI and camera feed here
    return Container();
  }

  @override
  void dispose() {
    _objectDetector.close();
    super.dispose();
  }
}

Future<String> _getModel(String assetPath) async {
  final appDirectory = await getApplicationDocumentsDirectory();
  final modelFile = File('${appDirectory.path}/$assetPath');
  if (!await modelFile.exists()) {
    final byteData = await rootBundle.load(assetPath);
    final bytes = byteData.buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    );
    await modelFile.writeAsBytes(bytes);
  }
  return modelFile.path;
}
