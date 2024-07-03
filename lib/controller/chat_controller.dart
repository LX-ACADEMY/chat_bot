import 'package:chat_bot_test/enums/message_part_type.dart';
import 'package:chat_bot_test/enums/message_type.dart';
import 'package:chat_bot_test/models/message_model.dart';
import 'package:chat_bot_test/models/message_part_model.dart';
import 'package:chat_bot_test/services/gemini_services.dart';
import 'package:flutter/material.dart';

final class ChatController {
  /// Send a new message and get the reply
  Future<void> sendMessage(
      String message,
      ValueNotifier<List<MessageModel>> messageState,
      ValueNotifier<bool> isLoadingState) async {
    final messageSent = MessageModel(
        message: getMessagePartFrom(message), type: MessageType.sent);

    messageState.value = [...messageState.value, messageSent];

    isLoadingState.value = true;

    final response = await GeminiServices.sendPrompt(message);

    final responseMessage =
        response['candidates'].first['content']['parts'].first['text'];

    final messageReceived = MessageModel(
        message: getMessagePartFrom(responseMessage),
        type: MessageType.received);

    messageState.value = [...messageState.value, messageReceived];

    isLoadingState.value = false;
  }

  /// Convert string message into message parts
  List<MessagePartModel> getMessagePartFrom(String message) {
    final messageParts = <MessagePartModel>[];

    final boldMessagePart = message.split('**');

    var gap = 1;
    for (var i = 0; i < boldMessagePart.length; i++) {
      if (i == 0 && message.startsWith('**')) {
        messageParts.add(MessagePartModel(
            message: boldMessagePart[i], type: MessagePartType.bold));

        gap = 0;
        continue;
      }

      if (i % 2 == gap) {
        messageParts.add(MessagePartModel(
            message: boldMessagePart[i], type: MessagePartType.bold));
      } else {
        messageParts.add(MessagePartModel(
            message: boldMessagePart[i], type: MessagePartType.normal));
      }
    }

    return messageParts;
  }
}
