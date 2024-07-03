import 'package:chat_bot_test/enums/message_type.dart';
import 'package:chat_bot_test/models/message_part_model.dart';

class MessageModel {
  final List<MessagePartModel> message;
  final MessageType type;

  MessageModel({
    required this.message,
    required this.type,
  });
}
