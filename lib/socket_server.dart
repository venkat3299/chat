import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketServer {
  static final SocketServer _instance = SocketServer._internal();

  factory SocketServer() {
    return _instance;
  }


late  IO.Socket socket;

  SocketServer._internal() {
    socket = IO.io('localhost', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('Socket connected');
    });

    socket.on('disconnect', (_) {
      print('Socket disconnected');
    });

    socket.on('message', (data) {
      String reversedMessage = data['message'].split('').reversed.join();
      socket.emit('response', {'message': reversedMessage});
    });
  }
}
