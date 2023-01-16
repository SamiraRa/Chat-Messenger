// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessage extends StatelessWidget {
  String text;
  String sender;
  ChatMessage({
    Key? key,
    required this.text,
    required this.sender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundColor: sender == "User" ? Vx.red200 : Vx.green200,
            child: Text(sender[0]),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(sender,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 7, 27, 49),
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ),
              Expanded(child: text.trim().text.bodyText1(context).make().px8())
              // Container(
              //   margin: const EdgeInsets.only(top: 5.0),
              //   child: Text(text),
              // )
            ],
          ),
        )
      ],
    );
  }
}
