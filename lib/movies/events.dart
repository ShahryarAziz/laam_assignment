import 'package:equatable/equatable.dart';

abstract class MoviesEvents extends Equatable{
  MoviesEvents([List props = const []]);
}

class GetMoviesListEvent extends MoviesEvents {

  GetMoviesListEvent();

  @override
  List<Object> get props => [];

  String toString() => 'GetMoviesListEvent';

}