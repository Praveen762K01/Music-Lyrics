import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu/bloc/lyric/lyric_state.dart';
import 'package:relu/models/lyric_model.dart';
import 'package:relu/repository/lyric_repo.dart';

class LyricCubit extends Cubit<LyricState> {
  LyricRepo lyricRepo;
  LyricCubit(this.lyricRepo) : super(InitLyricState());

  getLyric(int trackId) async {
    emit(LoadingLyricState());

    try {
      LyricModel lyricModel = await lyricRepo.getLyrics(trackId);
      if (lyricModel.message!.header!.statusCode == 200) {
        emit(SuccessLyricState(lyricModel: lyricModel));
      } else {
        emit(ErrorLyricState());
      }
    } catch (e) {
      emit(ErrorLyricState());
    }
  }
}
