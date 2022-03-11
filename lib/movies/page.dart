import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laam_assignment/constants/url_constants.dart';
import 'package:laam_assignment/login/bloc.dart';
import 'package:laam_assignment/login/page.dart';
import 'package:laam_assignment/models/movies.dart';
import 'package:laam_assignment/models/user.dart';
import 'package:laam_assignment/movie_details/bloc.dart';
import 'package:laam_assignment/movie_details/page.dart';
import 'package:laam_assignment/utilities/network_repository.dart';
import 'package:laam_assignment/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'movies.dart';

class MoviesPage extends StatefulWidget {
  MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesState createState() =>  _MoviesState();
}

class _MoviesState extends State<MoviesPage> {
  MoviesBloc? moviesBloc;
  SharedPreferences? sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  Movies? movies;
  bool _isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init()async{
    sharedPreferences =  await SharedPreferences.getInstance();
    moviesBloc = BlocProvider.of<MoviesBloc>(context);
    moviesBloc?.add(GetMoviesListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoviesBloc, MoviesStates>(
        listener: (context, state) {
          if(state is GetMoviesListSuccessState){
            setState(() {
              _isLoading = false;
              movies = Movies.fromJson(state.moviesListResponseData);
            });
          }
          if(state is NetworkErrorState){
            setState(() {
              _isLoading = false;
            });
            Utils.alertMessage(context, state.error.toUpperCase());
          }
        },
        child: BlocBuilder<MoviesBloc, MoviesStates>(builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Movies', style: TextStyle(color: Colors.white),),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.input), color: Colors.white,
                  onPressed: (){
                    sharedPreferences!.setBool('login', false);
                    navigateToLoginScreen();
                  },
                ),
              ],
            ),
            body: SafeArea(
                child: _isLoading? Center(
                  child: CircularProgressIndicator(),
                ):Container(
                  padding: EdgeInsets.all(20),
                  child: ListView.builder(
                    itemCount: movies!.results!.length,
                    itemBuilder: (context, position) {
                      return listItems(position);
                    },
                  ),
                )
            ),
          );
        }));
  }

  Widget listItems(int position) {
    return ListTile(
      title: Container(
        child: Column(
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image.network('https://image.tmdb.org/t/p/original'+movies!.results!.elementAt(position).posterPath.toString(),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(movies!.results!.elementAt(position).originalTitle!, style: TextStyle(color: Colors.black, fontSize: 18),),
            )
          ],
        ),
      ),
      onTap: ()=>navigateToDetailScreen(movies!.results!.elementAt(position).id),
    );
  }

  navigateToDetailScreen(int? id) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          BlocProvider<MoviesDetailsBloc>(
            create: (context) {
              return MoviesDetailsBloc(networkRepository: NetworkRepository(),);
            },
            child: MoviesDetailsPage(moviesId: id,),
          ),
    ));
  }

  void navigateToLoginScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) =>
          BlocProvider<LoginBloc>(
            create: (context) {
              return LoginBloc(networkRepository: NetworkRepository(),);
            },
            child: LoginPage(),
          ),
    ));
  }

}
