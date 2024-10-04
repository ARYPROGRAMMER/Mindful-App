import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'package:image_picker/image_picker.dart';

class _FaceEmotionDetector extends State<FaceEmotionDetector> {
  File? _image;
  List<Face> _faces = [];
  final ImagePicker _picker = ImagePicker();
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
        enableContours: true,
        enableClassification: true,
        enableLandmarks: true,
        enableTracking: true),
  );

  double _imageWidth = 0;
  double _imageHeight = 0;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final file = File(pickedFile.path);

      // Get the image dimensions
      final decodedImage = await decodeImageFromList(file.readAsBytesSync());
      _imageWidth = decodedImage.width.toDouble();
      _imageHeight = decodedImage.height.toDouble();

      setState(() {
        _image = file;
      });
      _detectEmotion();
    }
  }

  Future<void> _detectEmotion() async {
    if (_image == null) return;
    final inputImage = InputImage.fromFile(_image!);

    final List<Face> faces = await _faceDetector.processImage(inputImage);

    if (faces.isNotEmpty) {
      setState(() {
        _faces = faces;
      });
    } else {
      setState(() {
        _faces = [];
      });
    }
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  String _classifyEmotion(Face face) {
    final double? smileProb = face.smilingProbability;
    final double? leftEyeOpenProb = face.leftEyeOpenProbability;
    final double? rightEyeOpenProb = face.rightEyeOpenProbability;

    if (smileProb != null && smileProb > 0.8) {
      return 'Happy';
    } else if (smileProb != null && smileProb < 0.2) {
      return 'Sad';
    } else if (leftEyeOpenProb != null &&
        rightEyeOpenProb != null &&
        leftEyeOpenProb < 0.2 &&
        rightEyeOpenProb < 0.2) {
      return 'Eyes Closed';
    } else if (smileProb != null &&
        smileProb > 0.5 &&
        leftEyeOpenProb! > 0.5 &&
        rightEyeOpenProb! > 0.5) {
      return 'Surprised';
    } else {
      return 'Neutral';
    }
  }

  @override
  Widget build(BuildContext bc) {
    return Scaffold(
      appBar: AppBar(
          title: const Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Center(
            child: Text(
          "Face Emotion Detector",
          style: TextStyle(color: Colors.green, fontSize: 30),
        )),
      )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null
                ? LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      double maxWidth = constraints.maxWidth;
                      double maxHeight =
                          maxWidth * (_imageHeight / _imageWidth);

                      return Stack(
                        children: [
                          Image.file(
                            _image!,
                            width: maxWidth,
                            height: maxHeight,
                            fit: BoxFit.contain,
                          ),
                          ..._faces.map((face) {
                            final boundingBox = face.boundingBox;
                            // Scale the bounding box to match the displayed image size
                            double scaleX = maxWidth / _imageWidth;
                            double scaleY = maxHeight / _imageHeight;

                            return Positioned(
                              left: boundingBox.left * scaleX,
                              top: boundingBox.top * scaleY,
                              width: boundingBox.width * scaleX,
                              height: boundingBox.height * scaleY,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 3),
                                ),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    color: Colors.red.withOpacity(0.8),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 4),
                                    child: Text(
                                      _classifyEmotion(face),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  )
                : const Text(
                    'Pick an image or capture one with the camera',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text(
                    'Pick from Gallery',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: const Text(
                    'Capture with Camera',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // init();
  }
}

class FaceEmotionDetector extends StatefulWidget {
  FaceEmotionDetector({super.key});

  @override
  _FaceEmotionDetector createState() => _FaceEmotionDetector();
}
