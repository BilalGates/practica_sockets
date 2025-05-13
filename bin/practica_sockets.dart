import 'dart:io';
import 'dart:convert';

void main() async {
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 3000);
  print('Servidor escoltant al port 3000');

  final clients = <Socket>[];

  await for (final client in server) {
    clients.add(client);
    print('Client connectat: ${client.remoteAddress.address}:${client.remotePort}');

    client.listen(
      (data) {
        final msg = utf8.decode(data).trim();
        print('Missatge rebut: $msg');

        if (msg.toLowerCase() == 'num_clients') {
          client.writeln('Clients connectats: ${clients.length}');
        } else {
          client.writeln('Resposta del servidor: $msg');
        }
      },
      onDone: () {
        print('Client desconnectat');
        clients.remove(client);
        client.close();
      },
    );
  }
}
