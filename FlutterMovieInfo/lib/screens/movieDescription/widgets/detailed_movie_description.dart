import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:MoviePKR/util/constants.dart';
import 'package:MoviePKR/widgets/smoothStarRating.dart';
import 'package:flutter/material.dart';
import 'package:MoviePKR/models/Movie.dart';

import 'add_to_list_btn.dart';

class DetailedMovieDescription extends StatefulWidget {
  Movie _movie;
  DetailedMovieDescription(this._movie);

  _DetailedMovieDescriptionState createState() =>
      _DetailedMovieDescriptionState(_movie);
}

class _DetailedMovieDescriptionState extends State<DetailedMovieDescription> {
  final Movie movie;
  _DetailedMovieDescriptionState(this.movie);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(5, 7))
          ]),
          height: 300,
          child: Image(
              image: movie.posterPath != null
                  ? NetworkImage(ApiData.postersUrl + movie.posterPath)
                  : AssetImage('assets/images/image_NA.png')),
        ),
        Container(height: 16),
        Expanded(
          child: Container(
              padding: EdgeInsets.all(12),
              color: Color.fromARGB(225, 18, 18, 30).withOpacity(0.3),
              height: 300,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                    Container(height: 5),
                    starRating(Movie.getRating(movie.rating), 20),
                    Container(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.update_outlined,
                          color: Colors.white.withOpacity(0.5),
                          size: 20,
                        ),
                        Container(width: 5),
                        Text(Movie.checkRunTime(movie.runTime),
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          Movie.checkDescription(movie.description),
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    AddToListBtn(
                      movie: movie,
                    ),
                  ])),
        ),
      ]),
    );
  }
}
