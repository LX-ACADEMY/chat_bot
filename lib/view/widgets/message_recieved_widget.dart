import 'package:chat_bot_test/enums/message_part_type.dart';
import 'package:chat_bot_test/models/message_part_model.dart';
import 'package:flutter/material.dart';

class MessageRecievedWidget extends StatelessWidget {
  final List<MessagePartModel> message;

  const MessageRecievedWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth * 0.7,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: RichText(
              text: TextSpan(children: [
                for (final text in message)
                  TextSpan(
                    text: text.message,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: text.type == MessagePartType.bold
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  )
              ]),
            ),
          ),
        );
      }),
    );
  }
}
