import 'package:equatable/equatable.dart';

class MoviesStates extends Equatable{
  @override
  List<Object> get props => [];
}

class MoviesInitialState extends MoviesStates {}

class GetMoviesListSuccessState extends MoviesStates {
  var moviesListResponseData;
  GetMoviesListSuccessState({required this.moviesListResponseData});

  @override
  List<Object> get props => [moviesListResponseData];

  @override
  String toString() => 'GetMoviesListSuccessState';
}

class NetworkErrorState extends MoviesStates {
  String error;
  int count;
  NetworkErrorState({required this.error, required this.count});

  @override
  List<Object> get props => [error, count];
}