import 'dart:ui';
import 'package:MoviePKR/screens/movieDescription/widgets/detailed_movie_description.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/models/Movie.dart';

class DescriptionScreen extends StatefulWidget {
  final int id;
  DescriptionScreen({Key key, this.id}) : super(key: key);

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  Movie movie;
  Future<Movie> getMovie() async {
    movie = await MovieLists.fetchMovieByID(widget.id);
    return movie;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: getMovie(),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData) {
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
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Text('About movie',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 24)),
                  ),
                  body: Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Padding(
                        padding: const EdgeInsets.all(18),

                        child: DetailedMovieDescription(movie),
                      )),
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
