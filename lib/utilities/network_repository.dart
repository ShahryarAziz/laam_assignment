import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:laam_assignment/constants/url_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NetworkRepository {
  SharedPreferences? prefs;
  var dio = Dio();
  final _auth = FirebaseAuth.instance;

  firebaseLogin({required String email, required String password}) async{
    try {
      UserCredential response = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return response.user;
    } on FirebaseAuthException catch (error) {
      return error;
    }
  }

  firebaseSignup({required String email, required String password}) async{
    try {
      UserCredential response = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return response.user;
    } on FirebaseAuthException catch (error) {
      return error;
    }
  }

  Future<dynamic> getMoviesList() async{
    Map<String , String> params = {
      'api_key': 'd1c8f5f9549960ec002a9cc86397c5cf',
    };
    print("url:"+ UrlConstants.getMoviesDataUrl);
    try {
      Response response = await dio.get(UrlConstants.getMoviesDataUrl,
        queryParameters: params
      );
      print("Response Code: "+ response.statusCode.toString());
      return response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  Future<dynamic> getMovieDetails(int movieId) async{
    Map<String , String> params = {
      'api_key': 'd1c8f5f9549960ec002a9cc86397c5cf',
    };
    print("url:"+ UrlConstants.getMovieDetailsDataUrl+movieId.toString());
    try {
      Response response = await dio.get(UrlConstants.getMovieDetailsDataUrl+movieId.toString(),
          queryParameters: params
      );
      print("Response Code: "+ response.statusCode.toString());
      return response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  Future<dynamic> getMovieImages(int movieId) async{
    Map<String , String> params = {
      'api_key': 'd1c8f5f9549960ec002a9cc86397c5cf',
    };
    print("url:"+ UrlConstants.getMovieDetailsDataUrl+movieId.toString()+'/images');
    try {
      Response response = await dio.get(UrlConstants.getMovieDetailsDataUrl+movieId.toString()+'/images',
          queryParameters: params
      );
      print("Response Code: "+ response.statusCode.toString());
      return response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }
  //
  // Future<dynamic> getUserInfoFromApi({@required String token}) async{
  //   Map<String , String> header = {
  //     'echo-auth-token': token,
  //   };
  //   try {
  //     var response = await http.get(Uri.parse(UrlConstants.getUserInfoUrl),
  //         headers: header,
  //     );
  //     print("Response Code: $token "+ response.body.toString());
  //     return response;
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return error;
  //   }
  // }
}
