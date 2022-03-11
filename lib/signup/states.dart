import 'package:equatable/equatable.dart';

class SignUpStates extends Equatable{
  @override
  List<Object> get props => [];
}

class SignUpInitialState extends SignUpStates {}

class SignUpButtonClickedSuccessState extends SignUpStates {
  var signupResponseData;
  SignUpButtonClickedSuccessState({required this.signupResponseData});

  @override
  List<Object> get props => [signupResponseData];

  @override
  String toString() => 'LoginButtonClickedSuccessState';
}

class NetworkErrorState extends SignUpStates {
  String error;
  int count;
  NetworkErrorState({required this.error, required this.count});

  @override
  List<Object> get props => [error, count];
}