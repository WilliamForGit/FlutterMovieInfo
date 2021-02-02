import 'package:MoviePKR/models/Movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key key}) : super(key: key);

  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    List<Movie> movies = List();
    movies.add(new Movie());
    movies.add(new Movie());
    movies.add(new Movie());
    movies.add(new Movie());
    movies.add(new Movie());
    movies.add(new Movie());
    movies.add(new Movie());

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.transparent,
                elevation: 0.8,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: Container(
                      height: 125,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 90,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/original/or06FN3Dka5tukK1e9sl16pB3iy.jpg"))),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Fantastic 6',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Image.asset(
                                  'assets/ratings/rating_5.png',
                                  width: 50,
                                  fit: BoxFit.contain,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '2019',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'PEG3',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      '120min',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Horror, Comedy, Action',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Starring: TA, RH, WX, ML, CH, AT ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          )),
                        ],
                      )),
                ),
              );
            },
          );
  }
}
//TODO: Add way to remove an item from list (in Saved Lists / single list screen)
