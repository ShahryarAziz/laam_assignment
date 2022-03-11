import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:laam_assignment/utilities/network_repository.dart';

import 'movies.dart';

class MoviesBloc extends Bloc<MoviesEvents , MoviesStates> {
  final NetworkRepository? networkRepository;
  int count = 0;

  MoviesBloc({@required this.networkRepository}) : assert (networkRepository != null), super(MoviesInitialState());

  @override
  Stream<MoviesStates> mapEventToState(MoviesEvents event) async*{
    count = count+1;
    if (event is GetMoviesListEvent) {
      var response = await networkRepository!.getMoviesList();
      if (response.statusCode == 200) {
        yield GetMoviesListSuccessState(moviesListResponseData: response.data);
      } else {
        yield NetworkErrorState(error: response.code.toString(), count: count);
      }
    }
    // if (event is LoginButtonClicked) {
    //   var response = await networkRepository.getTokenFromApi(
    //     email: event.email,
    //     password: event.password,
    //   );
    //   print(response.body.toString());
    //   if (response.statusCode.toString() == '200') {
    //     print('Before parsing' + response.toString());
    //     yield LoginButtonClickedSuccessState(loginResponseData: response);
    //   } else
    //     yield NetworkErrorState(error: "Failed to Login.", count: count);
    // }

  }

}