import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'login.dart';

class LoginStates extends Equatable{
  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginStates {}

class LoginButtonClickedSuccessState extends LoginStates {
  var loginResponseData;
  LoginButtonClickedSuccessState({required this.loginResponseData});

  @override
  List<Object> get props => [loginResponseData];

  @override
  String toString() => 'LoginButtonClickedSuccessState';
}


class NetworkErrorState extends LoginStates {
  String error;
  int count;
  NetworkErrorState({required this.error, required this.count});

  @override
  List<Object> get props => [error, count];
}