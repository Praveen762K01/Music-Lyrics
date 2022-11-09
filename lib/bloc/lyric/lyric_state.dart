import 'package:relu/models/lyric_model.dart';

abstract class LyricState {}

class InitLyricState extends LyricState {}

class LoadingLyricState extends LyricState {}

class SuccessLyricState extends LyricState {
  LyricModel lyricModel;
  SuccessLyricState({required this.lyricModel});
}

class ErrorLyricState extends LyricState {}
