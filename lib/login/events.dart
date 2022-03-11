import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvents extends Equatable{
  LoginEvents([List props = const []]);
}

class LoginButtonClicked extends LoginEvents {
  final String email , password;

  LoginButtonClicked({required this.email , required this.password});

  @override
  List<Object> get props => [email , password];

  String toString() => 'LoginButtonClicked';

}
