import 'package:flutter/material.dart';
import 'package:gemma_app_ai/model/chat_model.dart';
import 'package:gemma_app_ai/widgets/chat_item.dart';

class ChatList extends StatelessWidget {
  final ScrollController controller;
  final List<ChatModel> chatList;
  const ChatList({super.key, required this.controller, required this.chatList});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: controller,
        shrinkWrap: true,
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          return ChatItem(chatModel: chatList[index]);
        },
      ),
    );
  }
}
