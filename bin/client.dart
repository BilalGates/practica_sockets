import 'dart:io';
import 'dart:convert';

void main() async {
  final socket = await Socket.connect('localhost', 3000);
  print('Connectat al servidor!');

  socket.listen((data) {
    print(utf8.decode(data));
  });

  stdin.listen((data) {
    socket.add(data);
  });
}
