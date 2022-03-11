import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laam_assignment/utilities/network_repository.dart';

import 'login.dart';

class LoginBloc extends Bloc<LoginEvents , LoginStates> {
  final NetworkRepository? networkRepository;
  int count = 0;

  LoginBloc({@required this.networkRepository}) : assert (networkRepository != null), super(LoginInitialState());

  @override
  Stream<LoginStates> mapEventToState(LoginEvents event) async*{
    count = count+1;
    if (event is LoginButtonClicked) {
      var response = await networkRepository!.firebaseLogin(
        email: event.email,
        password: event.password,
      );
      if (response.email != null) {
        yield LoginButtonClickedSuccessState(loginResponseData: response);
      } else {
        yield NetworkErrorState(error: response.code.toString(), count: count);
      }
    }
  }

}