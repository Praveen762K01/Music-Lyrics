import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu/bloc/song/song_state.dart';
import 'package:relu/models/song_model.dart';
import 'package:relu/repository/song_repo.dart';

class SongCubit extends Cubit<SongState> {
  SongRepo songRepo;
  SongCubit(this.songRepo) : super(InitSongState());
  getSong(int trackId) async {
    emit(LoadingSongState());
    try {
      SongModel songModel = await songRepo.getSongs(trackId);
      if (songModel.message!.header!.statusCode == 200) {
        emit(SuccessSongState(songModel: songModel));
      } else {
        emit(ErrorSongState());
      }
    } catch (e) {
      emit(ErrorSongState());
    }
  }
}
