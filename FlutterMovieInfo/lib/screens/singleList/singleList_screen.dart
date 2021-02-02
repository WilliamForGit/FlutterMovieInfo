import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MoviePKR/models/Movie.dart';
import 'package:MoviePKR/widgets/detailedMovieList.dart';

class MovieListScreen extends StatefulWidget {
  final String listTitleInMylist;
  final List<Movie> moviesInMylist;
  MovieListScreen(this.listTitleInMylist, this.moviesInMylist);

  State<StatefulWidget> createState() =>
      new _MovieListScreenState(listTitleInMylist, moviesInMylist);
}

class _MovieListScreenState extends State<MovieListScreen> {
  final String titleInMyMovielist;
  final List<Movie> moviesInMyMovielist;
  _MovieListScreenState(this.titleInMyMovielist, this.moviesInMyMovielist);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(titleInMyMovielist, textAlign: TextAlign.center),
          ),
          body: detailedMovieList(moviesInMyMovielist, 'mylist'),
        ));
  }
}
