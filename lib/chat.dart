import 'package:flutter/material.dart';

/** created by Himashi Bogahawaththa **/
/** Eyepax IT Consulting (Pvt) Ltd **/
/** created on 12/20/2022 at 9:55 AM **/


class ChatScreen extends StatefulWidget {
  final List messages;
  ChatScreen({Key? key, required this.messages, required this.scrollController}) : super(key: key);

  ScrollController scrollController;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    //separate user message and bot responses
    return ListView.separated(
        controller: widget.scrollController,
        itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: widget.messages[index]['isUserMessage']
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: const Radius.circular(
                                    20,
                                  ),
                                  topRight: const Radius.circular(20),
                                  bottomRight: Radius.circular(
                                      widget.messages[index]['isUserMessage'] ? 0 : 20),
                                  topLeft: Radius.circular(
                                      widget.messages[index]['isUserMessage'] ? 20 : 0),
                                ),
                                color: widget.messages[index]['isUserMessage']
                                    ? Colors.cyanAccent
                                    : Colors.cyan.shade900.withOpacity(0.8),
                            ),
                            constraints: BoxConstraints(maxWidth: w * 2 / 3),
                            child: Text(widget.messages[index]['message'].text.text[0],
                                style: TextStyle(
                                    color: widget.messages[index]['isUserMessage']
                                  ? Colors.black
                                  : Colors.white
                                ),
                            )
                        )
                    ],
                ),
            );
        },
        separatorBuilder: (_, i) => const Padding(padding: EdgeInsets.only(top: 0)),
        itemCount: widget.messages.length);

  }
}