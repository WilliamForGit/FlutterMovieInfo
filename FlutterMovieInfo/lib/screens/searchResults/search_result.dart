import 'package:MoviePKR/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:MoviePKR/widgets/detailedMovieList.dart';
import 'package:flutter/rendering.dart';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/models/Movie.dart';

class SearchResult extends StatefulWidget {
  final String search;
  SearchResult({Key key, this.search}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Movie> movieList;
  Future<List<Movie>> getMovieList(String query) async {
    movieList = await MovieLists.fetchMovies(query);
    return movieList;
  }

  @override
  Widget build(BuildContext context) {
    getMovieList(widget.search);
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
            title: Text(
              'Search Results',
              style: TextStyle(fontSize: 24),
            ),
            centerTitle: true,
          ),
          body: FutureBuilder<List<Movie>>(
              future: getMovieList(widget.search),
              // ignore: missing_return
              builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
                if (snapshot.hasData) {
                  return Column(children: <Widget>[
                    searchBar(context),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                      child: Container(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Showing results for: '" +
                                      widget.search +
                                      "'",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)))),
                    ),
                    Expanded(
                        child: detailedMovieList(movieList,
                            'serachList')),
                  ]);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}
