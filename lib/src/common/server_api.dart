import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<HttpServer> startLocalServer() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8081);

  print('Локальный сервер запущен на http://127.0.0.1:8081');
  server.listen((HttpRequest request) async {
    final String path = request.uri.path;
    if (path == '/aboba.html') {
      try {
        final String fileContent = await readFile("aboba.html");
        request.response.headers.contentType = ContentType.html;
        request.response.write(fileContent);
      } catch (e) {
        request.response.statusCode = HttpStatus.notFound;
        request.response.write('Not Found');
      }
    } else {
      request.response.statusCode = HttpStatus.notFound;
      request.response.write('Not Found');
    }
    await request.response.close();
  });

  return server;
}

String getPlayerString(String kinopoiskId) {
  return '''
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div class="kinobox_player"></div>
    <script src="https://kinobox.tv/kinobox.min.js"></script>
    <script>kbox('.kinobox_player', {search: {kinopoisk: $kinopoiskId}})
var iframe = document.getElementById('player');

document.getElementById('play').addEventListener('click', e => {
  iframe.contentWindow.postMessage({ api: 'play' }, "*");
});

document.getElementById('pause').addEventListener('click', e => {
  iframe.contentWindow.postMessage({ api: 'pause' }, "*");
});

window.addEventListener("message", function (event) {
   console.log(event.data);
});
    </script>
</body>
</html>''';
}

Future<File> createFile(String fileName, String content) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$fileName';
  final file = File(filePath);
  return file.writeAsString(content);
}

Future<String> readFile(String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$fileName';
  final file = File(filePath);
  return file.readAsStringSync();
}
