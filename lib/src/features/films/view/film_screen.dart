import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:mirar/src/app_routes.dart';
import 'package:mirar/src/common/server_api.dart';
import 'package:mirar/src/features/films/bloc/film/film_bloc.dart';

class FilmScreen extends StatefulWidget {
  final String kinoposikId;
  const FilmScreen({super.key, required this.kinoposikId});

  @override
  State<FilmScreen> createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen>
    with SingleTickerProviderStateMixin {
  bool _fileCreated = false;
  final List<String> blockedDomains = [
    'https://mc.yandex.ru',
    'track.adpod.in',
    'imasdk.googleapis.com',
    'ads-matresh.ru',
    'https://www.serv01001.xyz',
    'https://aj1907.online',
    'https://vast.ufouxbwn.com',
    'aj2635.bid',
    "/mob.playjusting.com/s"
  ];
  bool showPlayer = true;
  late InAppWebViewController webView;
  @override
  void initState() {
    super.initState();
    _initializeFile();
    createFile('aboba.html', getPlayerString(widget.kinoposikId));
    context
        .read<FilmBloc>()
        .add(FilmEvent.loadDetails(filmId: widget.kinoposikId));
  }

  Future<void> _initializeFile() async {
    await createFile('aboba.html', getPlayerString(widget.kinoposikId));
    setState(() {
      _fileCreated = true;
    });
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
            if (showPlayer && _fileCreated)
              SizedBox(
                width: 600,
                height: 240,
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri('http://127.0.0.1:8080/aboba.html'),
                  ),
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
