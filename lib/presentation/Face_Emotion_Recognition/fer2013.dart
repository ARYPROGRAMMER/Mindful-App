import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class FaceEmotionDetector extends StatefulWidget {
  const FaceEmotionDetector({Key? key}) : super(key: key);

  @override
  _FaceEmotionDetectorState createState() => _FaceEmotionDetectorState();
}

class _FaceEmotionDetectorState extends State<FaceEmotionDetector> {
  CameraController? _controller;
  Interpreter? _interpreter;
  bool _isCameraInitialized = false;
  bool _isInterpreterInitialized = false;

  // final List<String> _emotions = ['Angry', 'Disgusted', 'Fear', 'Happy', 'Sad', 'Surprise', 'Neutral'];
  final List<String> _emotions = ['Angry', 'Disgusted', 'Fear', 'Sad', 'Happy', 'Surprise', 'Neutral'];
  String _currentEmotion = 'Unknown';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadModel();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      await _controller!.initialize();
      _isCameraInitialized = true;
      if (mounted) {
        setState(() {});
      }
      print('Camera initialized successfully');
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/model.tflite');
      _isInterpreterInitialized = true;
      print('Interpreter loaded successfully');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }
  //
  // Future<void> _processImage() async {
  //   if (!_isCameraInitialized || !_isInterpreterInitialized) {
  //     print('Camera initialized: $_isCameraInitialized');
  //     print('Interpreter initialized: $_isInterpreterInitialized');
  //     return;
  //   }
  //
  //   try {
  //     final image = await _controller!.takePicture();
  //     final imageBytes = await image.readAsBytes();
  //     final img.Image? capturedImage = img.decodeImage(imageBytes);
  //
  //     if (capturedImage == null) {
  //       print('Failed to decode image');
  //       return;
  //     }
  //
  //     // Convert to grayscale and resize
  //     final img.Image resizedImage = img.copyResize(capturedImage, width: 48, height: 48);
  //     final img.Image grayImage = img.grayscale(resizedImage);
  //
  //     // Prepare the input for the model
  //     var input = List.generate(
  //       1,
  //           (index) => List.generate(
  //         48,
  //             (y) => List.generate(
  //           48,
  //               (x) {
  //             final pixel = grayImage.getPixel(x, y);
  //             return img.getRed(pixel) / 255.0;  // Normalize grayscale value
  //           },
  //         ),
  //       ),
  //     );
  //
  //     // Prepare the output array
  //     var output = List.filled(1 * 7, 0.0).reshape([1, 7]);
  //
  //     // Run inference
  //     _interpreter!.run(input, output);
  //
  //     // Log the output to debug
  //     print('Model output: $output');
  //
  //     final result = output[0] as List<double>;
  //     final maxIndex = result.indexOf(result.reduce((curr, next) => curr > next ? curr : next));
  //
  //     if (mounted) {
  //       setState(() {
  //         _currentEmotion = _emotions[maxIndex];
  //       });
  //     }
  //   } catch (e) {
  //     print('Error processing image: $e');
  //   }
  // }


  Future<void> _processImage() async {
    if (!_isCameraInitialized || !_isInterpreterInitialized) {
      print('Camera initialized: $_isCameraInitialized');
      print('Interpreter initialized: $_isInterpreterInitialized');
      return;
    }

    try {
      final image = await _controller!.takePicture();
      final imageBytes = await image.readAsBytes();
      final img.Image? capturedImage = img.decodeImage(imageBytes);

      if (capturedImage == null) {
        print('Failed to decode image');
        return;
      }

      // Convert to grayscale and resize
      final img.Image resizedImage = img.copyResize(capturedImage, width: 48, height: 48);
      final img.Image grayImage = img.grayscale(resizedImage);

      // Prepare the input for the model
      // Creating a 4D tensor: (1, 48, 48, 1)
      var input = List.generate(
        1,
            (index) => List.generate(
          48,
              (y) => List.generate(
            48,
                (x) {
              final pixel = grayImage.getPixel(x, y);
              return img.getRed(pixel) / 255.0;  // Normalize grayscale value
            },
          ),
        ),
      );

      // Convert the 3D array to 4D by adding a channel dimension
      var input4D = input.map((array) => array.map((row) => row.map((value) => [value]).toList()).toList()).toList();

      // Prepare the output array
      var output = List.filled(1 * 7, 0.0).reshape([1, 7]);

      // Run inference
      _interpreter!.run(input4D, output);

      // Log the output to debug
      print('Model output: $output');

      final result = output[0] as List<double>;
      final maxIndex = result.indexOf(result.reduce((curr, next) => curr > next ? curr : next));

      final double confidenceThreshold = 0.4; // Set your threshold

      if (mounted) {
        setState(() {
          if (result[maxIndex] > confidenceThreshold) {
            _currentEmotion = _emotions[maxIndex];
          } else {
            _currentEmotion = 'Unknown'; // Or whatever fallback you prefer
          }
        });
      }
    } catch (e) {
      print('Error processing image: $e');
    }
  }


  @override
  void dispose() {
    _controller?.dispose();
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Face Emotion Detector')),
      body: _isCameraInitialized
          ? Column(
        children: [
          Expanded(
            child: CameraPreview(_controller!),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Current Emotion: $_currentEmotion',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: _isCameraInitialized && _isInterpreterInitialized ? _processImage : null,
        child: Icon(Icons.camera),
      ),
    );
  }
}
