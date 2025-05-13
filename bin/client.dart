import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  // 1. Conectar al servidor
  final socket = await Socket.connect('127.0.0.1', 3000);
  print('✅ Conectado a ${socket.remoteAddress.address}:${socket.remotePort}');

  // 2. Enviar un mensaje
  const mensaje = '¡Hola servidor!';
  print('📤 Enviando: $mensaje');
  socket.writeln(mensaje);

  // 3. Escuchar la respuesta
  socket.listen(
    (List<int> data) {
      final respuesta = utf8.decode(data).trim();
      print('📥 Respuesta: $respuesta');
    },
    onDone: () {
      print('🔒 Conexión cerrada por el servidor');
      socket.destroy();
    },
    onError: (e) {
      print('⚠️ Error: $e');
      socket.destroy();
    },
  );
}
