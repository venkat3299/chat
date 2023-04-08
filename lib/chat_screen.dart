import 'package:chat_app/socket_server.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  //  final TextEditingController _textController = TextEditingController();
  List<String> _messages = [];

  final SocketServer _socketServer = SocketServer();

  @override
  void initState() {
    super.initState();
    _socketServer.socket.connect();
    _socketServer.socket.on('response', (data) {
      setState(() {
        _messages.insert(0, "Server: ${data['message']}");
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    _messages[index],
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              },
            ),
          ),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type a message',
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                _sendMessage(_textController.text);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String message) {
    _textController.clear();
    setState(() {
      _messages.insert(0, "You: $message");
            _messages.insert(0, "response: ${message.split('').reversed.join()}");
    });
  }
}
