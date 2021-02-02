import 'dart:convert';
import 'package:MoviePKR/models/Movie.dart';
import 'package:MoviePKR/models/movieList.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MovieLists with ChangeNotifier {
  SharedPreferences prefs;

  List<MovieList> _myLists = [];
  List<Movie> _trendingMovies = [];
  Map<int, String> genres = {};

  List<MovieList> get movieLists => [..._myLists];
  List<Movie> get trendingList => [..._trendingMovies];

  void addNewList(MovieList newList) {
    _myLists.add(newList);
    saveToSF();
    //todo handle error/exception.
    notifyListeners();
  }

  void removeList(MovieList movieList) {
    _myLists.remove(movieList);
    saveToSF();
    notifyListeners();
  }

  bool addFilmToList(Movie movie, int index) {
    var contain = movieLists[index].movies.where((m) => m.id == movie.id);
    if (contain.isEmpty) {
      movieLists[index].movies.add(movie);
      saveToSF();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  MovieList getListAtIndex(int index) {
    return _myLists[index];
  }

  String getGenre(int i) {
    String genre;
    genres.forEach((key, value) {
      if (key == i) genre = value;
    });
    return genre;
  }

  String getGenreList(Movie movie, String typeOfList) {
    String genreList = "";
    int count = 0;
    for (var genre in movie.genres) {
      if (count < 3) {
        if (typeOfList == 'serachList') {
          genreList += getGenre(genre) + " | ";
        } else {
          genreList += getGenre(genre['id']) + " | ";
        }
        count++;
      }
    }
    if (genreList.length > 3)
      genreList = genreList.substring(0, genreList.length - 3);
    return genreList;
  }

  Future<void> fetchGenres() async {
    final response = await http.get(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=837ac1cc736282b8a8c9d58d52cd5a7c&language=en-US");
    var data = json.decode(response.body)['genres'];
    for (var item in data) {
      genres[item['id']] = item['name'];
    }
    print(genres.keys);
  }

  static Future<List<Movie>> fetchMovies(String keyword) async {
    final response = await http.get(
        'https://api.themoviedb.org/3/search/movie?api_key=837ac1cc736282b8a8c9d58d52cd5a7c&language=en-US&query=' +
            keyword +
            '&page=1&include_adult=false');
    List<Movie> searchedMovies = [];
    var data = json.decode(response.body)['results'];
    for (var item in data) {
      searchedMovies.add(Movie.fromJsonNoRuntime(item));
    }
    return searchedMovies;
  }

  Future<void> fetchTrendingList() async {
    try {
      final response = await http.get(
          'https://api.themoviedb.org/3/trending/movie/day?api_key=837ac1cc736282b8a8c9d58d52cd5a7c');
      var data = json.decode(response.body)['results'];
      for (var item in data) {
        _trendingMovies.add(Movie.fromJson(item));
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<Movie> fetchMovieByID(int id) async {
    final response = await http.get("https://api.themoviedb.org/3/movie/" +
        id.toString() +
        "?api_key=837ac1cc736282b8a8c9d58d52cd5a7c&language-en-US");
    return Movie.fromJsonGenres(json.decode(response.body));
  }

  Future<void> saveToSF() async {
    var decoded = MovieList.encode(_myLists);
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('key', decoded);
  }

  _getList() async {
    prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('key');
    return data;
  }

  fetchSavedListsFromSF() async {
    String list = await _getList();
    if (list != null && list.isNotEmpty) {
      try {
        _myLists = MovieList.decode(list);
      } catch (error) {
        throw (error);
      }
    }
  }
}
