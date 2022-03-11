import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laam_assignment/models/images.dart';
import 'package:laam_assignment/models/movie_details.dart';
import 'package:laam_assignment/models/user.dart';
import 'package:laam_assignment/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'movies_details.dart';

class MoviesDetailsPage extends StatefulWidget {
  int? moviesId;
  MoviesDetailsPage({Key? key, this.moviesId}) : super(key: key);

  @override
  _MoviesDetailsState createState() =>  _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetailsPage> {
  MoviesDetailsBloc? moviesDetailsBloc;
  SharedPreferences? sharedPreferences;
  MovieDetails? movieDetails;
  Images? images;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init()async{
    sharedPreferences =  await SharedPreferences.getInstance();
    moviesDetailsBloc = BlocProvider.of<MoviesDetailsBloc>(context);
    moviesDetailsBloc!.add(GetMovieDetails(movieId: widget.moviesId!));
    moviesDetailsBloc!.add(GetMovieImages(movieId: widget.moviesId!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoviesDetailsBloc, MoviesDetailsStates>(
        listener: (context, state) {
          if(state is GetMovieDetailsSuccessState){
            movieDetails = MovieDetails.fromJson(state.movieDetailsResponseData);
          }
          if(state is GetMovieImagesSuccessState){
            images = Images.fromJson(state.movieImagesResponseData);
          }
          if(state is NetworkErrorState){
            Utils.alertMessage(context, state.error.toUpperCase());
          }
        },
        child: BlocBuilder<MoviesDetailsBloc, MoviesDetailsStates>(builder: (context, state) {
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
              title: const Text('Movie Detail', style: TextStyle(color: Colors.white),),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: movieDetails != null ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(movieDetails!.originalTitle.toString(), style: TextStyle(color: Colors.black),),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: Text(movieDetails!.overview.toString(), style: TextStyle(color: Colors.black),),
                        ),
                      ],
                    ),
                    images != null ? Row(
                      children: [
                        SizedBox(height: 400, width: 400 ,child: GridView.count(crossAxisCount: 3, children: List.generate(images!.logos!.length, (index) {
                            return Container(
                              height: 200,
                              width: 200,
                              child: Image.network('https://image.tmdb.org/t/p/original'+images!.posters!.elementAt(index).filePath.toString()),
                            );
                          }
                          ),
                        ))
                      ],
                    ):Container()
                  ],
                ):Container(),
              ),
            )
          );
        }));
  }

}
