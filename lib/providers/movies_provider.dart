import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';
import '/models/genre.dart';
import '../database/movies_data_api.dart';
import '/utilities/shared_prefrences_keys.dart';

import '../models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  final List<Movie> _movies = <Movie>[];
  final List<Genre> _genres = <Genre>[];
  bool _fetchingMovies = true;
  List<Category> categories = [];

  bool get fetchingMovies => _fetchingMovies;
  List<Movie> get movies => _movies;
  List<Genre> get genres => _genres;

  getMovies() async {
    List<dynamic> moviesData = await MoviesDataAPI.getUpcomingMoviesList();
    for (Map<String, dynamic> movie in moviesData) {
      movies.add(Movie.fromMap(movie, genres));
    }
    _fetchingMovies = false;
    notifyListeners();
  }

  getGenresName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? genresNameJson =
        preferences.getString(SharedPrefrencesKey.genresNamesKey);
    if (genresNameJson == null) {
      genresNameJson = await MoviesDataAPI.getGenresNames();
      preferences.setString(
          SharedPrefrencesKey.genresNamesKey, genresNameJson ?? '');
    }
    List<dynamic> genresNameList =
        (json.decode(genresNameJson ?? ''))['genres'];
    log(genresNameList.toString());
    for (var genreName in genresNameList) {
      _genres.add(Genre.fromMap(genreName));
    }
    notifyListeners();
  }

  getCategories() {
    final Map<int, Category> genreMap = {};
    final Set<String> usedMovieIds = {};

    for (var movie in _movies) {
      if (usedMovieIds.contains(movie.movieId)) continue;

      for (var genre in movie.genres) {
        if (!genreMap.containsKey(genre.id)) {
          genreMap[genre.id] = Category(
            id: genre.id,
            name: genre.name,
            imageUrl: movie.imageURL,
          );
          usedMovieIds.add(movie.movieId);
          break;
        }
      }
    }

    categories = genreMap.values.toList();
  }

  Future<String?>? getTrailerId(String movieId) async {
    final trailers = await MoviesDataAPI.getMovieTrailer(movieId);
    final trailer = trailers.firstWhere(
      (item) => item['site'] == 'YouTube' && item['type'] == 'Trailer',
      orElse: () => null,
    );

    if (trailer != null) {
      return trailer['key'];
    }
    return null;
  }
}
