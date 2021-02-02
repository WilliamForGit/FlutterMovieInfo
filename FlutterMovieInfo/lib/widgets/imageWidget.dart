import 'package:flutter/material.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:MoviePKR/models/Movie.dart';

Widget imageWidget(int index, List<Movie> movieList) {
  try {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 6, 0, 6),
      alignment: Alignment.centerLeft,
      height: double.infinity,
      child: Image(image: NetworkImage(
          ApiData.postersUrl + movieList[index].posterPath)),
    );
  } catch (exception) {
    return Container(
        alignment: Alignment.centerLeft,
        width: 90,
        height: double.infinity,
        child: Image(image: AssetImage('assets/images/image_NA.png')));
  }
}