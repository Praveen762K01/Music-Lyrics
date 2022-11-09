import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu/bloc/connection/connection_cubit.dart';
import 'package:relu/bloc/connection/connection_state.dart' as cs;
import 'package:relu/bloc/movie/movie_cubit.dart';
import 'package:relu/bloc/movie/movie_state.dart';
import 'package:relu/models/movie_model.dart';
import 'package:relu/screen/bookmark_screen.dart';
import 'package:relu/screen/lyric_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ConnectionCubit>().check();
      context.read<MovieCubit>().getMovie();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Relu Musix"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.red,
            Colors.pink,
          ])),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const BookMarkScreen()));
              },
              icon: const Icon(Icons.bookmarks))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red,
          Colors.pink,
        ])),
        child: BlocBuilder<ConnectionCubit, cs.ConnectionState>(
            builder: (context, connection) {
          if (connection is cs.OnlineConnectionState) {
            return BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
              if (state is InitMovieState || state is LoadingMovieState) {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ));
              } else if (state is SuccessMovieState) {
                MovieModel model = state.movieModel;
                return ListView.builder(
                  itemCount: model.message!.body!.trackList!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const Divider(),
                        ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LyricScreen(
                                        trackId: model.message!.body!
                                            .trackList![index].track!.trackId!,
                                        name: model
                                            .message!
                                            .body!
                                            .trackList![index]
                                            .track!
                                            .trackName!,
                                      ))),
                          leading: const Icon(
                            Icons.library_music_outlined,
                            color: Colors.white,
                          ),
                          subtitle: Text(
                            model.message!.body!.trackList![index].track!
                                .trackName!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          title: Text(
                            model.message!.body!.trackList![index].track!
                                .albumName!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          trailing: Text(
                            model.message!.body!.trackList![index].track!
                                .artistName!,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                );
              } else {
                return const Center(
                    child: Text(
                  "Oops! something went wrong",
                  style: TextStyle(color: Colors.white),
                ));
              }
            });
          } else {
            return const Center(
                child: Text(
              "No Internet",
              style: TextStyle(color: Colors.white),
            ));
          }
        }),
      ),
    );
  }
}
