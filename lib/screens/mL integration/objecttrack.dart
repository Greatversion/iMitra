import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isDetecting = false;
  late final ObjectDetector objectDetector;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeObjectDetector();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  Future<void> _initializeObjectDetector() async {
    objectDetector = GoogleMlKit.vision.objectDetector(options: ObjectDetectorOptions(classifyObjects: true, multipleObjects: true ,mode: DetectionMode.stream));
    await objectDetector.close();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _detectObjects() async {
    if (!isDetecting) {
      try {
        await _initializeControllerFuture;
        await objectDetector.processImage(
          InputImage.fromBytes(
            bytes: await _controller.takePicture().then((value) => value.readAsBytes()),
            inputImageData: InputImageData(
              size: Size(
                _controller.value.previewSize!.height,
                _controller.value.previewSize!.width,
              ),
              imageRotation: InputImageRotation.rotation0deg,
              inputImageFormat: InputImageFormat.nv21, planeData: [],
            ),
          ),
        ).then((results) {
          // Do something with the detected objects
          String detectedObjects = '';
          for (final item in results) {
            detectedObjects += '${item.trackingId}: ${item.labels.first.text}\n';
          }
          print(detectedObjects);
        });
        setState(() {
          isDetecting = false;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isDetecting = true;
                  });
                  await _detectObjects();
                },
                child: Text('Detect Objects'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
