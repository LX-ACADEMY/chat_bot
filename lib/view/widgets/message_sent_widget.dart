import 'package:chat_bot_test/models/message_part_model.dart';
import 'package:flutter/material.dart';

class MessageSentWidget extends StatelessWidget {
  final List<MessagePartModel> message;

  const MessageSentWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth * 0.7,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: RichText(
              text: TextSpan(children: [
                for (final text in message)
                  TextSpan(
                    text: text.message,
                  )
              ]),
            ),
          ),
        );
      }),
    );
  }
}
