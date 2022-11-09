import 'package:relu/models/song_model.dart';

abstract class SongState {}

class InitSongState extends SongState {}

class LoadingSongState extends SongState {}

class SuccessSongState extends SongState {
  SongModel songModel;
  SuccessSongState({required this.songModel});
}

class ErrorSongState extends SongState {}
