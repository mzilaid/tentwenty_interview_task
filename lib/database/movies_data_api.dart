import 'dart:convert';

import 'package:http/http.dart' as http;

class MoviesDataAPI {
  static const String _apiKey = '8befe1879fb304dc43a3871111476012';

  static Future<List<dynamic>> getUpcomingMoviesList() async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$_apiKey');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  static Future<List<dynamic>> getMovieTrailer(String movieId) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$_apiKey');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch trailer');
    }
  }

  static getGenresNames() async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$_apiKey');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch genres');
    }
  }
}
