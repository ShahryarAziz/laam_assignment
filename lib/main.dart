import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laam_assignment/movies/bloc.dart';
import 'package:laam_assignment/utilities/network_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/color_constants.dart';
import 'login/bloc.dart';
import 'login/page.dart';
import 'movies/page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? login = prefs.getBool('login');
  if(login != null){
    if(login){
      runApp(AlreadyLoginApp());
    }else{
      runApp(LoginApp());
    }
  }else{
    runApp(LoginApp());
  }
}

class LoginApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(ColorConstants.mainAppDarkColor),
        canvasColor: const Color(ColorConstants.progressBackgroundColor),
      ),
      home: BlocProvider<LoginBloc>(
        create: (context) {
          return LoginBloc(networkRepository: NetworkRepository(),);
        },
        child: LoginPage(),
      ),
    );
  }
}

class AlreadyLoginApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(ColorConstants.mainAppDarkColor),
        canvasColor: const Color(ColorConstants.progressBackgroundColor),
      ),
      home: BlocProvider<MoviesBloc>(
        create: (context) {
          return MoviesBloc(networkRepository: NetworkRepository(),);
        },
        child: MoviesPage(),
      ),
    );
  }
}
