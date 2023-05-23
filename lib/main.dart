import 'package:chatbot/chat.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My bot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      
      home: const Home()
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My bot"),
        ),
        body: Container(
            child: Column(
              children: [
                Expanded(child: ChatScreen(messages: messages, scrollController: scrollController,)),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    color: Colors.teal,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt_outlined, color: Colors.white70,)),
                        Expanded(
                            child: TextField(
                              controller: _controller,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter a message'
                              ),
                            )
                        ),
                        IconButton(
                            onPressed: () {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 300),
                              );
                              sendMessage(_controller.text);
                              _controller.clear();
                            },
                            icon: const Icon(Icons.send, color: Colors.white70,))
                      ],
                    ),
                )
              ],
          ),
        )
    );
  }

  sendMessage(String text) async {
      if (text.isEmpty) {
          print('Message is empty');
      }
      else {

          //User message
          setState(() {
              addMessage(Message(text: DialogText(text: [text])), true);
          });

          //bot response
          DetectIntentResponse response = await dialogFlowtter.detectIntent(
              queryInput: QueryInput(text: TextInput(text: text)));

          if (response.message == null) return;
              setState(() {
                  addMessage(response.message!);
              });
      }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
      messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
