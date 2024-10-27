import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
  late InAppWebViewController webView;
  @override
  void initState() {
    super.initState();

    getIt<FilmBloc>().add(FilmEvent.loadDetails(filmId: widget.kinoposikId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            SizedBox(
              width: 600,
              height: 240,
              child: InAppWebView(
                initialSettings: InAppWebViewSettings(
                    transparentBackground: true, supportZoom: false),
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
