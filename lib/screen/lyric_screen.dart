import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:relu/bloc/bookmarks/bookmark_cubit.dart';
import 'package:relu/bloc/connection/connection_cubit.dart';
import 'package:relu/bloc/connection/connection_state.dart' as cs;
import 'package:relu/bloc/lyric/lyric_cubit.dart';
import 'package:relu/bloc/lyric/lyric_state.dart';
import 'package:relu/bloc/song/song_cubit.dart';
import 'package:relu/bloc/song/song_state.dart';
import 'package:relu/models/song_model.dart';

class LyricScreen extends StatefulWidget {
  final int trackId;
  final String name;
  const LyricScreen({super.key, required this.trackId, required this.name});

  @override
  State<LyricScreen> createState() => _LyricScreenState();
}

class _LyricScreenState extends State<LyricScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SongCubit>().getSong(widget.trackId);
      context.read<LyricCubit>().getLyric(widget.trackId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.red,
            Colors.pink,
          ])),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await context
                    .read<BookMarkCubit>()
                    .addData(widget.trackId, widget.name)
                    .then((value) =>
                        Fluttertoast.showToast(msg: "Bookmark added"));
              },
              icon: const Icon(Icons.bookmark_add))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.red, Colors.pink])),
        child: BlocBuilder<ConnectionCubit, cs.ConnectionState>(
            builder: (context, connect) {
          if (connect is cs.OnlineConnectionState) {
            return BlocBuilder<SongCubit, SongState>(
              builder: (context, state) {
                if (state is InitSongState || state is LoadingSongState) {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ));
                } else if (state is SuccessSongState) {
                  SongModel model = state.songModel;
                  return Column(
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        model.message!.body!.track!.trackName!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Text(
                        "Artist",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        model.message!.body!.track!.artistName!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Text(
                        "Album Name",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        model.message!.body!.track!.albumName!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Text(
                        "Explicit",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        model.message!.body!.track!.explicit! == 1
                            ? "True"
                            : "False",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Text(
                        "Rating",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        model.message!.body!.track!.trackRating!.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Lyrics",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ],
                      ),
                      Expanded(
                        child: BlocBuilder<LyricCubit, LyricState>(
                            builder: (context, lyricState) {
                          if (lyricState is InitLyricState ||
                              lyricState is LoadingLyricState) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            ));
                          } else if (lyricState is SuccessLyricState) {
                            return Text(
                              lyricState.lyricModel.message!.body!.lyrics!
                                  .lyricsBody!,
                              style: TextStyle(color: Colors.white),
                            );
                          } else {
                            return const Center(
                                child: Text(
                              "No lyrics found",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ));
                          }
                        }),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                      child: Text(
                    "Oops! something went wrong",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ));
                }
              },
            );
          } else {
            return const Center(
                child: Text(
              "No Internet",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ));
          }
        }),
      ),
    );
  }
}
