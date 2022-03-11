import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class MoviesDetailsEvents extends Equatable{
  MoviesDetailsEvents([List props = const []]);
}

class GetMovieDetails extends MoviesDetailsEvents {
  final int movieId;

  GetMovieDetails({required this.movieId});

  @override
  List<Object> get props => [movieId];

  String toString() => 'GetMovieDetails';

}

class GetMovieImages extends MoviesDetailsEvents {
  final int movieId;

  GetMovieImages({required this.movieId});

  @override
  List<Object> get props => [movieId];

  String toString() => 'GetMovieImages';

}