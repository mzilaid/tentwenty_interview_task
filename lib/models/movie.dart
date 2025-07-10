import 'package:upcoming_movies/models/genre.dart';

class Movie {
  final String name;
  final String posterImgUrl;
  final String movieId;
  final String overview;
  final List<Genre> genres;
  final DateTime releaseDate;
  final String imageURL;

  Movie({
    required this.name,
    required this.movieId,
    required this.posterImgUrl,
    required this.overview,
    required this.genres,
    required this.releaseDate,
    required this.imageURL,
  });

  factory Movie.fromMap(Map<String, dynamic> movie, List<Genre> allGenres) {
    List<Genre> genreObjects = [];
    for (int id in movie['genre_ids']) {
      final matched = allGenres.firstWhere((g) => g.id == id,
          orElse: () => Genre(id: id, name: 'Unknown'));
      genreObjects.add(matched);
    }

    return Movie(
      name: movie['title'],
      movieId: movie['id'].toString(),
      posterImgUrl: movie['poster_path'],
      overview: movie['overview'],
      releaseDate: DateTime.parse(movie['release_date']),
      genres: genreObjects,
      imageURL: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': name,
      'id': movieId,
      'poster_path': posterImgUrl,
      'overview': overview,
      'release_date': releaseDate.toIso8601String(),
      'genre_ids': genres.map((genre) => genre.id).toList(),
    };
  }
}
