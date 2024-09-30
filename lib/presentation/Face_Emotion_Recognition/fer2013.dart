import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_face_api/flutter_face_api.dart';
import 'package:image_picker/image_picker.dart';

class _FaceEmotionDetector extends State<FaceEmotionDetector> {
  var faceSdk = FaceSDK.instance;

  var _emotion = "Not Initialised";
  var _status = "not Initialised";
  var _details = "Not Initialised";

  var _uiImage1 = Image.asset('assets/portrait.png');

  set emotion(String val) => setState(() {
        _emotion = val;
      });
  set status(String val) => setState(() {
        _status = val;
      });
  set details(String val) => setState(() {
        _details = val;
      });

  set uiImage1(Image val) => setState(() => _uiImage1 = val);

  Uint8List? mfImage1;

  void init() async {
    super.initState();
    if (!await initialize()) return;
    status = "Face Emotion Detector";
  }

  EmotionDetect() async {
    setState(() {});
    var config = DetectFacesConfig(
      attributes: [
        DetectFacesAttribute.EMOTION,
      ],
    );

    if (mfImage1 == null) return;
    var request = DetectFacesRequest(mfImage1!, config);

    var response = await faceSdk.detectFaces(request);
    response.detection?.attributes?.forEach((attributeResult) {
      var value = attributeResult.value;
      var confidence = attributeResult.confidence;
      emotion = value!;
      details = confidence.toString();
    });
  }

  clearResults() {
    status = "FER Restarted";
    emotion = "nil";
    details = "nil";
    uiImage1 = Image.asset('assets/portrait.png');
    mfImage1 = null;
  }

  Future<bool> initialize() async {
    status = "Configuring...";
    InitConfig? config = null;
    var (success, error) = await faceSdk.initialize(config: config);
    if (!success) {
      status = error!.message;
      print("${error.code}: ${error.message}");
    }
    return success;
  }

  setImage(Uint8List bytes, ImageType type, int number) async {
    // var mfImage = MatchFacesImage(bytes, type);
    if (number == 1) {
      mfImage1 = bytes;
      uiImage1 = Image.memory(bytes);
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
        child: Image(height: 300, width: 300, image: image.image),
      );

  Widget button(String text, Function() onPressed) {
    return Container(
      width: 250,
      child: textButton(text, onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.black12),
          )),
    );
  }

  Widget text(String text) => Text(text,
      style: TextStyle(
          fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold));

  Widget textButton(String text, Function() onPressed, {ButtonStyle? style}) =>
      TextButton(
        child: Text(text),
        onPressed: onPressed,
        style: style,
      );

  setImageDialog(BuildContext context, int number) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Select Option"),
          actions: [useGallery(number), useCamera(number)],
        ),
      );

  @override
  Widget build(BuildContext bc) {
    return Scaffold(
      appBar: AppBar(
          title: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
            child: Text(
          _status,
          style: TextStyle(color: Colors.green, fontSize: 30),
        )),
      )),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(bc).size.height / 8),
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              image(_uiImage1, () => setImageDialog(bc, 1)),
              SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text("Emotion : $_emotion"),
                  Container(margin: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                  text("Accuracy : ${_details}"),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: EmotionDetect,
                  child: Text(
                    "Analyze Emotion",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: clearResults,
                  child: Text("Reset",
                      style: TextStyle(fontSize: 20, color: Colors.black)))
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
