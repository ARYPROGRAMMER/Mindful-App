import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_face_api/flutter_face_api.dart';
import 'package:image_picker/image_picker.dart';

class _FaceEmotionDetector extends State<FaceEmotionDetector> {
  var faceSdk = FaceSDK.instance;

  var _emotion = "not initialised";
  var _status = "not initialised";

  var _uiImage = Image.asset('assets/portrait.png');


  set emotion(String val) => setState(() {
    _emotion=val;
  });
  set status(String val) => setState(() {
    _status=val;
  });


  set uiImage(Image val) => setState(() => _uiImage = val);


  MatchFacesImage? mfImage1;


  void init() async {
    super.initState();
    if (!await initialize()) return;
    status = "Service Loaded";
  }

  EmotionDetect() async {
    var config = DetectFacesConfig(
      attributes: [
        DetectFacesAttribute.EMOTION,
        DetectFacesAttribute.AGE,
        DetectFacesAttribute.GLASSES,
      ],
    );

    if (mfImage1 == null) return;
    var request = new DetectFacesRequest(mfImage1!.image, config);

    var response = await FaceSDK.instance.detectFaces(request);
    response.detection?.attributes?.forEach((attributeResult) {
      var value = attributeResult.value;
      var attribute = attributeResult.attribute;
      var confidence = attributeResult.confidence;
      var range = attributeResult.range;
      print(value);
      emotion=value!;
      // print(attribute);
      // print(confidence);
      // print(range);
    });
  }

  clearResults() {
    status = "Service Restarted";
    emotion = "nil";

    uiImage = Image.asset('assets/portrait.png');
    mfImage1 = null;
  }

  Future<bool> initialize() async {
    status = "Initializing...";
    InitConfig? config = null;
    var (success, error) = await faceSdk.initialize(config: config);
    if (!success) {
      status = error!.message;
      print("${error.code}: ${error.message}");
    }
    return success;
  }

  Future<ByteData?> loadAssetIfExists(String path) async {
    try {
      return await rootBundle.load(path);
    } catch (_) {
      return null;
    }
  }

  setImage(Uint8List bytes, ImageType type, int number) {

    var mfImage = MatchFacesImage(bytes, type);
    if (number == 1) {
      mfImage1 = mfImage;
      uiImage = Image.memory(bytes);

    }
  }

  Widget useGallery(int number) {
    return textButton("Use gallery", () async {
      Navigator.pop(context);
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        setImage(File(image.path).readAsBytesSync(), ImageType.PRINTED, number);
      }
    });
  }

  Widget useCamera(int number) {
    return textButton("Use camera", () async {
      Navigator.pop(context);
      var response = await faceSdk.startFaceCapture();
      var image = response.image;
      if (image != null) setImage(image.image, image.imageType, number);
    });
  }

  Widget image(Image image, Function() onTap) => GestureDetector(
        onTap: onTap,
        child: Image(height: 150, width: 150, image: image.image),
      );

  Widget button(String text, Function() onPressed) {
    return Container(
      child: textButton(text, onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.black12),
          )),
      width: 250,
    );
  }

  Widget text(String text) => Text(text, style: TextStyle(fontSize: 18,color: Colors.black));

  Widget textButton(String text, Function() onPressed, {ButtonStyle? style}) =>
      TextButton(
        child: Text(text),
        onPressed: onPressed,
        style: style,
      );

  setImageDialog(BuildContext context, int number) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Select option"),
          actions: [useGallery(number), useCamera(number)],
        ),
      );

  @override
  Widget build(BuildContext bc) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(_status))),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(bc).size.height / 8),
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image(_uiImage, () => setImageDialog(bc, 1)),
              // image(_uiImage2, () => setImageDialog(bc, 2)),
              Container(margin: EdgeInsets.fromLTRB(0, 0, 0, 15)),
              button('Emotion Detect', EmotionDetect),
              button("Clear", () => clearResults()),
              Container(margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text("Emotion: " + _emotion.toString(),),
                  Container(margin: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                  text("Details: " + _emotion..length),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    init();
  }
}

class FaceEmotionDetector extends StatefulWidget {
  FaceEmotionDetector({super.key});

  @override
  _FaceEmotionDetector createState() => _FaceEmotionDetector();
}

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img;
//
// class FaceEmotionDetector extends StatefulWidget {
//   const FaceEmotionDetector({Key? key}) : super(key: key);
//
//   @override
//   _FaceEmotionDetectorState createState() => _FaceEmotionDetectorState();
// }
//
// class _FaceEmotionDetectorState extends State<FaceEmotionDetector> {
//   CameraController? _controller;
//   Interpreter? _interpreter;
//   bool _isCameraInitialized = false;
//   bool _isInterpreterInitialized = false;
//
//   // final List<String> _emotions = ['Angry', 'Disgusted', 'Fear', 'Happy', 'Sad', 'Surprise', 'Neutral'];
//   final List<String> _emotions = ['Angry', 'Disgusted', 'Fear', 'Sad', 'Happy', 'Surprise', 'Neutral'];
//   String _currentEmotion = 'Unknown';
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//     _loadModel();
//   }
//
//   Future<void> _initializeCamera() async {
//     try {
//       final cameras = await availableCameras();
//       final firstCamera = cameras.first;
//
//       _controller = CameraController(
//         firstCamera,
//         ResolutionPreset.medium,
//       );
//
//       await _controller!.initialize();
//       _isCameraInitialized = true;
//       if (mounted) {
//         setState(() {});
//       }
//       print('Camera initialized successfully');
//     } catch (e) {
//       print('Error initializing camera: $e');
//     }
//   }
//
//   Future<void> _loadModel() async {
//     try {
//       _interpreter = await Interpreter.fromAsset('assets/model.tflite');
//       _isInterpreterInitialized = true;
//       print('Interpreter loaded successfully');
//     } catch (e) {
//       print('Failed to load model: $e');
//     }
//   }
//   //
//   // Future<void> _processImage() async {
//   //   if (!_isCameraInitialized || !_isInterpreterInitialized) {
//   //     print('Camera initialized: $_isCameraInitialized');
//   //     print('Interpreter initialized: $_isInterpreterInitialized');
//   //     return;
//   //   }
//   //
//   //   try {
//   //     final image = await _controller!.takePicture();
//   //     final imageBytes = await image.readAsBytes();
//   //     final img.Image? capturedImage = img.decodeImage(imageBytes);
//   //
//   //     if (capturedImage == null) {
//   //       print('Failed to decode image');
//   //       return;
//   //     }
//   //
//   //     // Convert to grayscale and resize
//   //     final img.Image resizedImage = img.copyResize(capturedImage, width: 48, height: 48);
//   //     final img.Image grayImage = img.grayscale(resizedImage);
//   //
//   //     // Prepare the input for the model
//   //     var input = List.generate(
//   //       1,
//   //           (index) => List.generate(
//   //         48,
//   //             (y) => List.generate(
//   //           48,
//   //               (x) {
//   //             final pixel = grayImage.getPixel(x, y);
//   //             return img.getRed(pixel) / 255.0;  // Normalize grayscale value
//   //           },
//   //         ),
//   //       ),
//   //     );
//   //
//   //     // Prepare the output array
//   //     var output = List.filled(1 * 7, 0.0).reshape([1, 7]);
//   //
//   //     // Run inference
//   //     _interpreter!.run(input, output);
//   //
//   //     // Log the output to debug
//   //     print('Model output: $output');
//   //
//   //     final result = output[0] as List<double>;
//   //     final maxIndex = result.indexOf(result.reduce((curr, next) => curr > next ? curr : next));
//   //
//   //     if (mounted) {
//   //       setState(() {
//   //         _currentEmotion = _emotions[maxIndex];
//   //       });
//   //     }
//   //   } catch (e) {
//   //     print('Error processing image: $e');
//   //   }
//   // }
//
//
//   Future<void> _processImage() async {
//     if (!_isCameraInitialized || !_isInterpreterInitialized) {
//       print('Camera initialized: $_isCameraInitialized');
//       print('Interpreter initialized: $_isInterpreterInitialized');
//       return;
//     }
//
//     try {
//       final image = await _controller!.takePicture();
//       final imageBytes = await image.readAsBytes();
//       final img.Image? capturedImage = img.decodeImage(imageBytes);
//
//       if (capturedImage == null) {
//         print('Failed to decode image');
//         return;
//       }
//
//       // Convert to grayscale and resize
//       final img.Image resizedImage = img.copyResize(capturedImage, width: 48, height: 48);
//       final img.Image grayImage = img.grayscale(resizedImage);
//
//       // Prepare the input for the model
//       // Creating a 4D tensor: (1, 48, 48, 1)
//       var input = List.generate(
//         1,
//             (index) => List.generate(
//           48,
//               (y) => List.generate(
//             48,
//                 (x) {
//               final pixel = grayImage.getPixel(x, y);
//               return img.getRed(pixel) / 255.0;  // Normalize grayscale value
//             },
//           ),
//         ),
//       );
//
//       // Convert the 3D array to 4D by adding a channel dimension
//       var input4D = input.map((array) => array.map((row) => row.map((value) => [value]).toList()).toList()).toList();
//
//       // Prepare the output array
//       var output = List.filled(1 * 7, 0.0).reshape([1, 7]);
//
//       // Run inference
//       _interpreter!.run(input4D, output);
//
//       // Log the output to debug
//       print('Model output: $output');
//
//       final result = output[0] as List<double>;
//       final maxIndex = result.indexOf(result.reduce((curr, next) => curr > next ? curr : next));
//
//       final double confidenceThreshold = 0.4; // Set your threshold
//
//       if (mounted) {
//         setState(() {
//           if (result[maxIndex] > confidenceThreshold) {
//             _currentEmotion = _emotions[maxIndex];
//           } else {
//             _currentEmotion = 'Unknown'; // Or whatever fallback you prefer
//           }
//         });
//       }
//     } catch (e) {
//       print('Error processing image: $e');
//     }
//   }
//
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     _interpreter?.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Face Emotion Detector')),
//       body: _isCameraInitialized
//           ? Column(
//         children: [
//           Expanded(
//             child: CameraPreview(_controller!),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Current Emotion: $_currentEmotion',
//               style: Theme.of(context).textTheme.displayMedium,
//             ),
//           ),
//         ],
//       )
//           : Center(child: CircularProgressIndicator()),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _isCameraInitialized && _isInterpreterInitialized ? _processImage : null,
//         child: Icon(Icons.camera),
//       ),
//     );
//   }
// }
