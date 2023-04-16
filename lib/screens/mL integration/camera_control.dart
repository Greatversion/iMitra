import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:imitra/main.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:tflite/tflite.dart';

// import 'package:tflite_maven/tflite.dart';

class CameraControl extends StatefulWidget {
  const CameraControl({Key? key}) : super(key: key);

  @override
  State<CameraControl> createState() => _CameraControlState();
}

class _CameraControlState extends State<CameraControl> {
  // Declare class variables.....>>>>>>>
  late CameraController camController;
  String newResult = '';
  late CameraImage camImage;
  TextToSpeech tts = TextToSpeech();
  bool isWorking = false;

  // INITIALIZE THE CAMERA>>>>>>>>>>>>>
  initializeCamera() async {
    camController = CameraController(cameras[0], ResolutionPreset.veryHigh,
        enableAudio: false);
    await camController.initialize().then((value) {
      if (!mounted) {
        // check if there is widget inside the tree or not to fet into / open the camera .......
        return;
      }
      setState(() {
        camController.startImageStream((imageFromStream) {
          if (!isWorking) {
            // if camera is not busy OR not in current use
            isWorking =
                true; // make it in use ,,(we are inside the setstate)...........
            camImage = imageFromStream;
            runModelOnCameraImageStream();
          }
        });
      });
    });
  }

//LOAD THE MODEL >>>>>>>>>>>>>>>>>>>>>>>>>>>
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/mobilenet_v1_1.0_224.tflite", // CAPTURED MODELS
      labels:
          "assets/mobilenet_v1_1.0_224.txt", // LABELS OF THE IMAGES CAPTURED
    );
  }

  // PASS THE STREAM OF IMAGES TO THE LOAD MODEL>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  String previousResult = '';

  runModelOnCameraImageStream() async {
    if (camController.value.isInitialized == true) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: camImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: camImage.height,
        imageWidth: camImage.width,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 5,
        rotation: 90,
        threshold: 0.5,
        asynch: true,
      );

      // check if the detected object is the one you are interested in
      recognitions?.forEach((responsedGot) {
        String label = responsedGot['label'].toString();
        // double confidence = responsedGot['confidence'] as double;
        if (newResult.contains(label)) {
          // if the label is already in newResult, do not add it again
          return;
        }
        if (previousResult != label) {
          setState(() {
            newResult = label;
            previousResult = label;
            nowspeak(newResult);
          });
        }
      });

      isWorking = false;
    }
  }

  nowspeak(String k) async {
    await tts.speak(k);
  }

  //get INIT the CAMERA Initializer
  @override
  void initState() {
    super.initState();
    initializeCamera();
    loadModel();

    //LOAD THE MODEL
  }

  @override
  void dispose() async {
    super.dispose();
    await camController
        .stopImageStream(); // stop the camera image stream before disposing
    camController.dispose(); // dispose the camera Controller
    await Tflite.close(); //close the TFLITE MODELS
  }

  @override
  Widget build(BuildContext context) {
    var responsive = MediaQuery.of(context);

    return Scaffold(
      // ignore: sized_box_for_whitespace
      body: Container(
        height: responsive.size.height * 0.8,
        width: responsive.size.width,
        child: camController.value.isInitialized == true
            ? AspectRatio(
                aspectRatio: camController.value.aspectRatio,
                child: CameraPreview(camController),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),

        // Text(
        //   newResult,
        //   style: const TextStyle(color: Colors.red, fontSize: 33),
        // ),
      ),
    );
  }
}
