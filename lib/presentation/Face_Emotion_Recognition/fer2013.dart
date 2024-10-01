
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
      enableTracking: true
    ),
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
    } else if (leftEyeOpenProb != null && rightEyeOpenProb != null && leftEyeOpenProb < 0.2 && rightEyeOpenProb < 0.2) {
      return 'Eyes Closed';
    } else if (smileProb != null && smileProb > 0.5 && leftEyeOpenProb! > 0.5 && rightEyeOpenProb! > 0.5) {
      return 'Surprised';
    } else {
      return 'Neutral';
    }
  }
  //
  // var _emotion = "Not Initialised";
  // var _status = "not Initialised";
  // var _details = "Not Initialised";

  // var _uiImage1 = Image.asset('assets/portrait.png');

  // set emotion(String val) => setState(() {
  //       _emotion = val;
  //     });
  // set status(String val) => setState(() {
  //       _status = val;
  //     });
  // set details(String val) => setState(() {
  //       _details = val;
  //     });
  //
  // set uiImage1(Image val) => setState(() => _uiImage1 = val);
  //
  // Uint8List? mfImage1;

  // void init() async {
  //   super.initState();
  //   if (!await initialize()) return;
  //   status = "Face Emotion Detector";
  // }

  // EmotionDetect() async {
  //   setState(() {});
  //   var config = DetectFacesConfig(
  //     attributes: [
  //       DetectFacesAttribute.EMOTION,
  //     ],
  //   );
  //
  //   if (mfImage1 == null) return;
  //   var request = DetectFacesRequest(mfImage1!, config);
  //
  //   var response = await faceSdk.detectFaces(request);
  //   response.detection?.attributes?.forEach((attributeResult) {
  //     var value = attributeResult.value;
  //     var confidence = attributeResult.confidence;
  //     emotion = value!;
  //     details = confidence.toString();
  //   });
  // }

  // clearResults() {
  //   status = "FER Restarted";
  //   emotion = "nil";
  //   details = "nil";
  //   uiImage1 = Image.asset('assets/portrait.png');
  //   mfImage1 = null;
  // }

  // Future<bool> initialize() async {
  //   status = "Configuring...";
  //   InitConfig? config = null;
  //   var (success, error) = await faceSdk.initialize(config: config);
  //   if (!success) {
  //     status = error!.message;
  //     print("${error.code}: ${error.message}");
  //   }
  //   return success;
  // }

  // setImage(Uint8List bytes, ImageType type, int number) async {
  //   // var mfImage = MatchFacesImage(bytes, type);
  //   if (number == 1) {
  //     mfImage1 = bytes;
  //     uiImage1 = Image.memory(bytes);
  //   }
  // }

  // Widget useGallery(int number) {
  //   return textButton("Use gallery", () async {
  //     Navigator.pop(context);
  //     var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       setImage(File(image.path).readAsBytesSync(), ImageType.PRINTED, number);
  //     }
  //   });
  // }
  //
  // Future<void> _useCamera(int number) async {
  //
  //   var response = await faceSdk.startFaceCapture();
  //   var image = response.image;
  //   if (image != null) {
  //
  //     setImage(image.image, image.imageType, number);
  //   }
  //
  // }
  //
  //
  // // Define the setImage function to process the captured image
  // Future<void> setImage(Uint8List imageData, ImageType imageType, int number) async {
  //   // Convert the image to InputImage format for ML Kit
  //   final inputImage = check.decodeImage(imageData);
  //   // final inputImage = InputImage.fromBytes(bytes: imageData, metadata: InputImageMetadata(rotation: InputImageRotation.rotation0deg, format: InputImageFormat.yv12, bytesPerRow: 1024, size:Size(100,100) ));
  //   // Perform face detection
  //   final Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;
  //   File file = File('$tempPath/your_image.png');
  //   await file.writeAsBytes(imageData);
  //   setState(() {
  //     _image= file;
  //   });
  //    _detectEmotion();
  // }

  // Widget useCamera(int number) {
  //   return textButton("Use camera", () async {
  //     Navigator.pop(context);
  //     var response = await faceSdk.startFaceCapture();
  //     var image = response.image;
  //     if (image != null) setImage(image.image, image.imageType, number);
  //   });
  // }

  // Widget image(Image image, Function() onTap) => GestureDetector(
  //       onTap: onTap,
  //       child: Image(height: 300, width: 300, image: image.image),
  //     );

  // Widget button(String text, Function() onPressed) {
  //   return Container(
  //     width: 250,
  //     child: textButton(text, onPressed,
  //         style: ButtonStyle(
  //           backgroundColor: WidgetStateProperty.all<Color>(Colors.black12),
  //         )),
  //   );
  // }
  //
  // Widget text(String text) => Text(text,
  //     style: TextStyle(
  //         fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold));
  //
  // Widget textButton(String text, Function() onPressed, {ButtonStyle? style}) =>
  //     TextButton(
  //       child: Text(text),
  //       onPressed: onPressed,
  //       style: style,
  //     );
  //
  // setImageDialog(BuildContext context, int number) => showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //         title: Text("Select Option"),
  //         actions: [useGallery(number), useCamera(number)],
  //       ),
  //     );

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
              builder: (BuildContext context, BoxConstraints constraints) {
                double maxWidth = constraints.maxWidth;
                double maxHeight = maxWidth * (_imageHeight / _imageWidth);

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
                            border: Border.all(color: Colors.red, width: 3),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              color: Colors.red.withOpacity(0.8),
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
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
                : const Text('Pick an image or capture one with the camera',style: TextStyle(fontSize: 20,color: Colors.black),textAlign: TextAlign.center,),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text('Pick from Gallery',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: const Text('Capture with Camera',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
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
