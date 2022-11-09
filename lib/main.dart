import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu/bloc/bookmarks/bookmark_cubit.dart';
import 'package:relu/bloc/connection/connection_cubit.dart';
import 'package:relu/bloc/lyric/lyric_cubit.dart';
import 'package:relu/bloc/movie/movie_cubit.dart';
import 'package:relu/bloc/song/song_cubit.dart';
import 'package:relu/repository/lyric_repo.dart';
import 'package:relu/repository/movie_repo.dart';
import 'package:relu/repository/song_repo.dart';
import 'package:relu/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovieCubit(MovieRepo())),
        BlocProvider(create: (_) => SongCubit(SongRepo())),
        BlocProvider(create: (_) => LyricCubit(LyricRepo())),
        BlocProvider(create: (_) => ConnectionCubit()),
        BlocProvider(create: (_) => BookMarkCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
