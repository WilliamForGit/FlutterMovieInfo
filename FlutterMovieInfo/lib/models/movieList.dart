import 'dart:convert';
import 'Movie.dart';

class MovieList {
  String listTitle;
  List<Movie> _movies = [];

  MovieList(String title) {
    listTitle = title;
    _movies = [];
  }

  MovieList.fromStorage(String title, List<Movie> list) {
    listTitle = title;
    _movies = list;
  }

  int get count => _movies.length;
  List<Movie> get movies => _movies;

  factory MovieList.fromJson(Map<String, dynamic> json) {
    return MovieList.fromStorage(
        json['listTitle'], Movie.decode(json['movies']));
  }

  static Map<String, dynamic> toMap(MovieList movieList) => {
        'listTitle': movieList.listTitle,
        'movies':
            movieList._movies.length > 0 ? Movie.encode(movieList._movies) : ""
      };

  static String encode(List<MovieList> lists) => json.encode(
        lists
            .map<Map<String, dynamic>>((list) => MovieList.toMap(list))
            .toList(),
      );

  static List<MovieList> decode(String lists) =>
      (json.decode(lists) as List<dynamic>)
          .map<MovieList>((l) => MovieList.fromJson(l))
          .toList();
}
