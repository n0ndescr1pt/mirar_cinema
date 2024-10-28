import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:mirar/src/app_routes.dart';
import 'package:mirar/src/features/films/bloc/film/film_bloc.dart';
import 'package:mirar/src/injectable/init_injectable.dart';

class FilmScreen extends StatefulWidget {
  final String kinoposikId;
  const FilmScreen({super.key, required this.kinoposikId});

  @override
  State<FilmScreen> createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen>
    with SingleTickerProviderStateMixin {
  final List<String> blockedDomains = [
    'https://mc.yandex.ru',
    'track.adpod.in',
    'imasdk.googleapis.com',
    'ads-matresh.ru',
    'https://www.serv01001.xyz',
    'https://aj1907.online',
    'https://vast.ufouxbwn.com'
  ];
  bool showPlayer = true;
  late InAppWebViewController webView;
  @override
  void initState() {
    super.initState();

    getIt<FilmBloc>().add(FilmEvent.loadDetails(filmId: widget.kinoposikId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              setState(() {
                showPlayer = false;
              });
              context.pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<FilmBloc, FilmState>(
              bloc: getIt<FilmBloc>(),
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const Text("Loading"),
                  loaded: (film) => Column(
                    children: [
                      Text(film.nameRu ?? ""),
                      Text(film.description ?? ""),
                      Text(film.ratingImdb.toString()),
                    ],
                  ),
                );
              },
            ),
            if (showPlayer)
              SizedBox(
                width: 600,
                height: 240,
                child: InAppWebView(
                  shouldInterceptRequest: (controller, request) async {
                    String url = request.url.toString();
                    print("aaaaaa             $url");
                    for (String domain in blockedDomains) {
                      if (url.contains(domain)) {
                        print("Blocked request to $url");

                        return WebResourceResponse(
                          contentType: "text/plain",
                          contentEncoding: "utf-8",
                        );
                      }
                    }

                    return null;
                  },
                  initialSettings: InAppWebViewSettings(
                      transparentBackground: true,
                      supportZoom: false,
                      cacheEnabled: false),
                  initialData: InAppWebViewInitialData(data: """
                    <!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Document</title>
                    </head>
                    <body>
                        <div data-kinobox="auto" data-kinopoisk=${widget.kinoposikId}></div>
                <script src="https://kinobox.tv/kinobox.min.js"></script>
                </body>
                </html>"""),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
