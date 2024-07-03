import 'package:chat_bot_test/controller/chat_controller.dart';
import 'package:chat_bot_test/enums/message_type.dart';
import 'package:chat_bot_test/models/message_model.dart';
import 'package:chat_bot_test/view/widgets/message_recieved_widget.dart';
import 'package:chat_bot_test/view/widgets/message_sent_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChatPage extends HookWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final messageController = useTextEditingController();

    final isLoadingState = useState(false);
    final messageState = useState(<MessageModel>[]);

    void sendPrompt() {
      final message = messageController.text;
      messageController.clear();

      ChatController().sendMessage(message, messageState, isLoadingState);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              messageState.value = [];
            },
          )
        ],
        bottom: isLoadingState.value
            ? const PreferredSize(
                preferredSize: Size(double.infinity, 8),
                child: LinearProgressIndicator(),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: messageState.value.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final messageToShow = messageState.value[index];

                  if (messageToShow.type == MessageType.sent) {
                    return MessageSentWidget(
                      message: messageToShow.message,
                    );
                  } else {
                    return MessageRecievedWidget(
                      message: messageToShow.message,
                    );
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (_) => sendPrompt(),
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Ask anything..',
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: isLoadingState.value ? null : sendPrompt,
                  icon: const Icon(Icons.send),
                )
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
