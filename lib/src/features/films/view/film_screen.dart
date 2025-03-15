import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirar/src/common/server_api.dart';
import 'package:mirar/src/features/films/bloc/film/film_bloc.dart';
import 'package:mirar/src/features/films/view/widgets/add_review_bottomsheet.dart';
import 'package:mirar/src/features/films/view/widgets/description_block.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';
import 'package:mirar/src/features/review/bloc/review_bloc/review_bloc.dart';
import 'package:mirar/src/features/review/bloc/watch_history_bloc/watch_history_bloc.dart';
import 'package:mirar/src/theme/app_colors.dart';

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
    "/mob.playjusting.com/s",
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          BlocConsumer<FilmBloc, FilmState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Positioned(
                      child: Container(
                    width: double.infinity,
                    height: 900,
                    color: Colors.black,
                  ));
                },
                loaded: (film) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Image.network(
                      film.posterUrl ?? "",
                      fit: BoxFit.fitHeight,
                      width: double.infinity,
                      height: 650,
                    ),
                  );
                },
              );
            },
            listener: (BuildContext context, FilmState state) {
              state.whenOrNull(
                loaded: (film) {
                  Future.delayed(Duration(minutes: 2)).then((e) {
                    if (context.read<AuthBloc>().loginModel != null) {
                      context.read<WatchHistoryBloc>().add(
                          WatchHistoryEvent.addWatchHistory(
                              film: film,
                              userId: context
                                  .read<AuthBloc>()
                                  .loginModel!
                                  .objectID));
                    }

                    updateLists(context);
                  });
                  AppMetrica.reportEventWithMap('OpenFilm', {
                    "filmName": film.nameRu ?? "",
                    "filmId": film.kinopoiskId
                  });
                },
              );
            },
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 350,
                pinned: true,
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      showPlayer = false;
                    });
                    context
                        .read<FilmBloc>()
                        .add(const FilmEvent.clearDetails());
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      BlocBuilder<FilmBloc, FilmState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => const Text("Loading"),
                            loaded: (film) => Padding(
                              padding: EdgeInsets.only(
                                  top: 36, bottom: 8, left: 12, right: 12),
                              child: Column(
                                children: [
                                  Text(
                                    film.nameRu ?? '',
                                    style: TextStyle(fontSize: 26),
                                  ),
                                  if (film.year != null &&
                                      film.genres.length > 1)
                                    Text(
                                      "${film.year.toString()} ${film.genres.take(2).join(', ')}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.7)),
                                    ),
                                  Text(
                                    "${film.filmLength != null ? "${(film.filmLength! ~/ 60)} ч ${(film.filmLength! % 60).toStringAsFixed(0)} мин" : ""}  ${film.ratingAgeLimits != null ? "${film.ratingAgeLimits!.replaceFirst("age", "")}+" : ""}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                  const SizedBox(height: 36),
                                  DescriptionBlock(
                                      description: film.description ?? ""),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      if (showPlayer && _fileCreated)
                        RepaintBoundary(
                          child: SizedBox(
                            width: 600,
                            height: 240,
                            child: InAppWebView(
                              onConsoleMessage: (controller, consoleMessage) {
                                print("asd ${consoleMessage}");
                              },
                              initialUrlRequest: URLRequest(
                                url: WebUri('http://127.0.0.1:8081/aboba.html'),
                              ),
                              shouldInterceptRequest:
                                  (controller, request) async {
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
                                  useHybridComposition: false,
                                  transparentBackground: true,
                                  supportZoom: false,
                                  cacheEnabled: true),
                              onWebViewCreated:
                                  (InAppWebViewController controller) async {
                                webView = controller;
                              },
                            ),
                          ),
                        ),
                      BlocBuilder<FilmBloc, FilmState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            loaded: (film) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.activeIconBackground
                                        .withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Сам рейтинг
                                      Text(
                                        // Если нет рейтинга, показываем --
                                        film.ratingKinopoisk?.toString() ??
                                            '--',
                                        style: const TextStyle(
                                          fontSize: 42,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 4),

                                      // Кол-во голосов
                                      Text(
                                        "${film.ratingKinopoiskVoteCount ?? 0} оценок",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Кнопка "Оценить"
                                      SizedBox(
                                        height: 50,
                                        child: OutlinedButton.icon(
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            side: const BorderSide(
                                                color: Colors.white),
                                            elevation: 2,
                                          ),
                                          label: const Text(
                                            'Оценить',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onPressed: () {
                                            showCustomBottomSheet(
                                                context, film);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateLists(BuildContext context) {
    if (context.read<AuthBloc>().loginModel != null) {
      context.read<WatchHistoryBloc>().add(WatchHistoryEvent.getWatchHistory(
          userId: context.read<AuthBloc>().loginModel!.objectID));
      context.read<ReviewBloc>().add(ReviewEvent.getReviewMovie(
          userId: context.read<AuthBloc>().loginModel!.objectID));
    }
  }
}
