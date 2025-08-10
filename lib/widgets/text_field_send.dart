import 'package:flutter/material.dart';

class TextFieldSend extends StatefulWidget {
  const TextFieldSend({required this.controller, required this.fun});
  final Function() fun;
  final TextEditingController controller;

  @override
  State<TextFieldSend> createState() => _TextFieldSendState();
}

class _TextFieldSendState extends State<TextFieldSend> {
bool enabled=false;
@override
  void initState() {
    
widget.controller.addListener(() {
  enabled= widget.controller.text.isNotEmpty;
  setState(() {
    
  });
},);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 20,left: 12,right: 12,top: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey.shade800,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 20),
            Expanded(
              child: TextField(
                cursorColor: Colors.cyan,
                minLines: 1,
                maxLines: 5,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: widget.controller,
                decoration: InputDecoration(
                  
                  fillColor: Colors.transparent,
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hint: Text("ask me", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            RotationTransition(
              turns: AlwaysStoppedAnimation(90 / 360),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: enabled ? widget.fun : null,
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: enabled
                      ?Colors.white:Colors.grey.shade600,

                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
