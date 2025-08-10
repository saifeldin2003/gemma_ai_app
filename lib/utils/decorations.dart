import 'package:flutter/material.dart';

decorationChatItem(bool isUser){
  return BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft:
                isUser ? Radius.circular(10) : Radius.zero,
            topRight:
                !isUser ? Radius.circular(10) : Radius.zero,
          ),
          color: isUser
              ? Colors.indigo
              : Colors.indigoAccent,
        );
}

marginChatItem(bool isUser){
  return EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: isUser ? 50 : 10,
          right:isUser ? 10 : 50,
        );
}