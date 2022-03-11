import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:laam_assignment/utilities/network_repository.dart';

import 'movies_details.dart';

class MoviesDetailsBloc extends Bloc<MoviesDetailsEvents , MoviesDetailsStates> {
  final NetworkRepository? networkRepository;
  int count = 0;

  MoviesDetailsBloc({@required this.networkRepository}) : assert (networkRepository != null), super(MoviesDetailsInitialState());

  @override
  Stream<MoviesDetailsStates> mapEventToState(MoviesDetailsEvents event) async*{
    count = count+1;
    if (event is GetMovieDetails) {
      var response = await networkRepository!.getMovieDetails(event.movieId);
      if (response.statusCode == 200) {
        yield GetMovieDetailsSuccessState(movieDetailsResponseData: response.data);
      } else {
        yield NetworkErrorState(error: response.code.toString(), count: count);
      }
    }

    if (event is GetMovieImages) {
      var response = await networkRepository!.getMovieImages(event.movieId);
      if (response.statusCode == 200) {
        yield GetMovieImagesSuccessState(movieImagesResponseData: response.data);
      } else {
        yield NetworkErrorState(error: response.code.toString(), count: count);
      }
    }

  }

}