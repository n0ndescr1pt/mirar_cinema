import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FilmScreen extends StatefulWidget {
  const FilmScreen({super.key});

  @override
  State<FilmScreen> createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  late InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: InAppWebView(
            initialData: InAppWebViewInitialData(data: """
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Document</title>
            </head>
            <body>
                <div data-kinobox="auto" data-query="The boys"></div>
            <script src="https://kinobox.tv/kinobox.min.js"></script>
            </body>
            </html>"""),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
          )),
        ],
      ),
    );
  }
}
