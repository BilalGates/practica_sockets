import 'dart:io';

Future<void> main() async {
  // 1. Bind: levanta el servidor en localhost:3000
  final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 3000);
  print('🔌 Servidor escuchando en ${server.address.address}:${server.port}');

  // 2. Escuchar conexiones entrantes
  await for (Socket client in server) {
    print(
      '👤 Cliente conectado: '
      '${client.remoteAddress.address}:${client.remotePort}',
    );
    _handleClient(client);
  }
}

void _handleClient(Socket socket) {
  // 3. Leer datos enviados por el cliente
  socket.listen(
    (List<int> data) {
      final mensaje = String.fromCharCodes(data).trim();
      print('📥 Recibido: "$mensaje"');
      // 4. Devolver eco al cliente
      socket.write('Echo: $mensaje\n');
    },
    onDone: () {
      print('❌ Cliente desconectado');
      socket.destroy();
    },
    onError: (e) {
      print('⚠️ Error: $e');
      socket.destroy();
    },
  );
}
