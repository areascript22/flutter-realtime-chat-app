import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtime_chat_app/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final textController = TextEditingController();
  final focusNode = FocusNode();
  bool _isWritting = false;

  List<ChatMessage> _messaged = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 14,
              backgroundColor: Colors.blue[100],
              child: Text("Te", style: TextStyle(fontSize: 12)),
            ),
            SizedBox(height: 5),
            Text(
              "Melisa A",
              style: TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemCount: _messaged.length,
                itemBuilder: (_, i) => _messaged[i],
              ),
            ),
            Divider(height: 1),

            //TODO CAJA DE TEXTO
            Container(color: Colors.white, child: _inputChat()),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: textController,
                onSubmitted: _handleSubmit,
                onChanged: (value) {
                  //TODO cuando hya un valor para poder postear
                  setState(() {
                    if (value.trim().length > 0) {
                      _isWritting = true;
                    } else {
                      _isWritting = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: "Enviar mensaje",
                ),
                focusNode: focusNode,
              ),
            ),
            //button
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child:
                  Platform.isAndroid
                      ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: IconTheme(
                          data: IconThemeData(color: Colors.blue[400]),
                          child: IconButton(
                            onPressed:
                                _isWritting
                                    ? () => _handleSubmit(textController.text)
                                    : null,
                            icon: Icon(Icons.send),
                          ),
                        ),
                      )
                      : CupertinoButton(
                        child: Text("Enviar"),
                        onPressed:
                            _isWritting
                                ? () => _handleSubmit(textController.text)
                                : null,
                      ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit(String texto) {
    if (texto.isEmpty) {
      return;
    }
    print(texto);

    focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: textController.text,
      uid: "123",
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
      ),
    );

    _messaged.insert(0, newMessage);
    newMessage.animationController.forward();
    textController.clear();
    setState(() {
      _isWritting = false;
    });
  }

  @override
  void dispose() {
    //TODO off socker
    //Clean isntances
    for (var item in _messaged) {
      item.animationController.dispose();
    }
    super.dispose();
  }
}
