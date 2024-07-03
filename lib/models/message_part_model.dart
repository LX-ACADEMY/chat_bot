import 'package:chat_bot_test/enums/message_part_type.dart';

class MessagePartModel {
  final String message;
  final MessagePartType type;

  MessagePartModel({
    required this.message,
    required this.type,
  });
}
