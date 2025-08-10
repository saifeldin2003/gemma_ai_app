import 'package:flutter/material.dart';
import 'package:gemma_app_ai/main_screen.dart';
import 'package:gemma_app_ai/model/chat_model.dart';
import 'dart:async';
import 'package:gemma_app_ai/utils/decorations.dart';

class ChatItem extends StatefulWidget {
  const ChatItem({super.key, required this.chatModel});
  final ChatModel chatModel;
 
  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> with AutomaticKeepAliveClientMixin{
  String _displayedText = '';
  int _charIndex = 0;
  List<String> _charList = [];
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _charList = widget.chatModel.message.characters.toList();
    if (!widget.chatModel.isUser) {
      if(_displayedText == widget.chatModel.message) return;
      _startTypingEffect();
    } else {
      _displayedText = widget.chatModel.message;
    }
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Align(
      alignment:
          widget.chatModel.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: marginChatItem(widget.chatModel.isUser),
        decoration: decorationChatItem(widget.chatModel.isUser),
        child: Text(
          _displayedText,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _startTypingEffect() {
    const duration = Duration(milliseconds: 20);
    _typingTimer = Timer.periodic(duration, (timer) {
      if (_charIndex < _charList.length) {
        if(_displayedText == widget.chatModel.message) return;
        setState(() {
          _displayedText += _charList[_charIndex];
          MainScreenState.refreshScroll();
          _charIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  
  @override
  bool get wantKeepAlive => true;
}
