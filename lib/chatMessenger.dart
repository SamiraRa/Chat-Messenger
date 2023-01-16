import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:object_box/widgets/chat_messages.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessenger extends StatefulWidget {
  const ChatMessenger({super.key});

  @override
  State<ChatMessenger> createState() => _ChatMessengerState();
}

class _ChatMessengerState extends State<ChatMessenger> {
  TextEditingController controller = TextEditingController();
  List<ChatMessage> messages = [];
  ChatGPT? chatGPT;

  StreamSubscription? subscription;

  void sendMessage() {
    ChatMessage message = ChatMessage(text: controller.text, sender: "User");
    setState(() {
      messages.insert(0, message);
    });

    controller.clear();

    final request = CompleteReq(
        prompt: message.text, model: kTranslateModelV3, max_tokens: 200);

    subscription = chatGPT!
        .builder("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")
        .onCompleteStream(request: request)
        .listen((res) {
      Vx.log(res!.choices[0].text);
      ChatMessage botMessage =
          ChatMessage(text: res.choices[0].text, sender: "bot");

      setState(() {
        messages.insert(0, botMessage);
      });
    });
  }

  @override
  void initState() {
    chatGPT = ChatGPT.instance;
    super.initState();
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  reverse: true,
                  padding: Vx.m8,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      // height: context.screenHeight / 10,
                      // color: Colors.grey,
                      child: messages[index],
                    ).p16();
                  }),
            ),
            Container(
              decoration: BoxDecoration(
                color: context.cardColor,
              ),
              child: _buildTextComposer(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onSubmitted: (value) {
              sendMessage();
            },
            decoration:
                const InputDecoration.collapsed(hintText: "Send a Message"),
          ),
        ),
        IconButton(
          onPressed: () {
            sendMessage();
          },
          icon: const Icon(Icons.send),
        )
      ],
    ).px16();
  }
}
