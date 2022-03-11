import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:laam_assignment/utilities/network_repository.dart';

import 'signup.dart';

class SignUpBloc extends Bloc<SignUpEvents , SignUpStates> {
  final NetworkRepository? networkRepository;
  int count = 0;

  SignUpBloc({@required this.networkRepository}) : assert (networkRepository != null), super(SignUpInitialState());

  @override
  Stream<SignUpStates> mapEventToState(SignUpEvents event) async*{
    count = count+1;
    if (event is SignUpButtonClicked) {
      var response = await networkRepository!.firebaseSignup(
        email: event.email,
        password: event.password,
      );
      if (response.email != null) {
        yield SignUpButtonClickedSuccessState(signupResponseData: response);
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