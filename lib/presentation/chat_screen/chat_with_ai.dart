import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _userInput = TextEditingController();
  late VideoPlayerController _controller;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _userInput.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/background_model.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  var scrollController = ScrollController();
  static const apiKey = "AIzaSyDepZiY8dOe8UjZwjiAfhB1Qd6Bv55g73g";
  final model = GenerativeModel(model: 'gemini-1.5-flash-002', apiKey: apiKey);

  final List<Message> _messages = [];
  double c = 0;
  Future<void> sendMessage() async {
    final message = _userInput.text;

    setState(() {
      _messages
          .add(Message(isUser: true, message: message, date: DateTime.now()));
      c++;
    });

    setState(() {
      scrollController.animateTo(
        c * 2000,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _userInput.text = '';
    });
    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
      c++;
    });

    setState(() {
      scrollController.animateTo(
        c * 2000,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _userInput.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    bool activation = false;
    bool activationfunction() {
      activation = true;
      return activation;
    }

    bool deactivationfunction() {
      activation = false;
      return activation;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("AI Chat",
            style: TextStyle(fontSize: 25, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(children: [
        Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  shrinkWrap: true,
                  // reverse: true,
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return Messages(
                        isUser: message.isUser,
                        message: message.message,
                        date: DateFormat('HH:mm').format(message.date));
                  }),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 15,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _userInput,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.values.first,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Text";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          if (val.toString() != ' ') {
                            activationfunction();
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 10),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            label: const Text(
                              'Ask Me Anything',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  IconButton(
                      padding: const EdgeInsets.only(bottom: 20),
                      iconSize: 30,
                      style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white),
                          shape: WidgetStateProperty.all(const CircleBorder())),
                      onPressed: () {
                        Future.delayed(const Duration(seconds: 4));
                        activation ? sendMessage() : null;
                        deactivationfunction();
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 30,
                      ))
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages(
      {super.key,
      required this.isUser,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15)
          .copyWith(left: isUser ? 100 : 20, right: isUser ? 20 : 100),
      decoration: BoxDecoration(
          color: isUser ? Colors.red : Colors.green,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
              topRight: const Radius.circular(20),
              bottomRight: isUser ? Radius.zero : const Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
