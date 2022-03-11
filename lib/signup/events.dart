import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SignUpEvents extends Equatable{
  SignUpEvents([List props = const []]);
}

class SignUpButtonClicked extends SignUpEvents {
  final String email , password;

  SignUpButtonClicked({required this.email , required this.password});

  @override
  List<Object> get props => [email , password];

  String toString() => 'SignUpButtonClicked';

}