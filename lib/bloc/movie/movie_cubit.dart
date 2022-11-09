import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu/bloc/movie/movie_state.dart';
import 'package:relu/models/movie_model.dart';
import 'package:relu/repository/movie_repo.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieRepo movieRepo;
  MovieCubit(this.movieRepo) : super(InitMovieState());
  getMovie() async {
    emit(LoadingMovieState());
    try {
      MovieModel movieModel = await movieRepo.getMovies();
      if (movieModel.message!.header!.statusCode! == 200) {
        emit(SuccessMovieState(movieModel: movieModel));
      } else {
        emit(ErrorMovieState());
      }
    } catch (e) {
      emit(ErrorMovieState());
    }
  }
}
