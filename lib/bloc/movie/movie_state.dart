import 'package:relu/models/movie_model.dart';

abstract class MovieState {}

class InitMovieState extends MovieState {}

class LoadingMovieState extends MovieState {}

class SuccessMovieState extends MovieState {
  MovieModel movieModel;
  SuccessMovieState({required this.movieModel});
}

class ErrorMovieState extends MovieState {}
