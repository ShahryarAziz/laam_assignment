import 'package:equatable/equatable.dart';

class MoviesDetailsStates extends Equatable{
  @override
  List<Object> get props => [];
}

class MoviesDetailsInitialState extends MoviesDetailsStates {}

class GetMovieDetailsSuccessState extends MoviesDetailsStates {
  var movieDetailsResponseData;
  GetMovieDetailsSuccessState({required this.movieDetailsResponseData});

  @override
  List<Object> get props => [movieDetailsResponseData];

  @override
  String toString() => 'GetMovieDetailsSuccessState';
}

class GetMovieImagesSuccessState extends MoviesDetailsStates {
  var movieImagesResponseData;
  GetMovieImagesSuccessState({required this.movieImagesResponseData});

  @override
  List<Object> get props => [movieImagesResponseData];

  @override
  String toString() => 'GetMovieImagesSuccessState';
}

class NetworkErrorState extends MoviesDetailsStates {
  String error;
  int count;
  NetworkErrorState({required this.error, required this.count});

  @override
  List<Object> get props => [error, count];
}