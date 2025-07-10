import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:upcoming_movies/screens/watch/movie_detail_page.dart/movie_trailer_play_page.dart';
import 'package:upcoming_movies/utilities/app_theme.dart';
import '../../../providers/movies_provider.dart';
import '/widgets/custom_widgets/custom_elevated_button.dart';

import '../../../models/movie.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({required this.movie, super.key});
  final Movie movie;

  Color getRandomColor() {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.pinkAccent,
    ];
    return colors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.6,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: movie.imageURL,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: size.height * 0.05,
                    left: 10,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 16,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Watch',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: size.height * 0.05,
                    left: size.width * 0.15,
                    right: size.width * 0.15,
                    child: Column(
                      children: [
                        Text(
                          'In Theaters ${DateFormat('MMMM dd, yyyy').format(movie.releaseDate)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        CustomELevatedButton(
                          title: 'Get Tickets',
                          textColor: Colors.white,
                          backgroundColor: AppThemes.secondary,
                          onTap: () {},
                        ),
                        CustomELevatedButton(
                          title: 'Watch Trailer',
                          textColor: Colors.white,
                          borderColor: Color(0xff61C3F2),
                          prefixIcon: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MovieTrailerPlayPage(
                                        movieId: movie.movieId)));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Genres',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                  Consumer<MoviesProvider>(builder: (_, pro, __) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          movie.genres.length,
                          (index) => _GenresCategoryNameBox(
                              title: movie.genres[index].name,
                              color: getRandomColor()),
                        ),
                      ),
                    );
                  }),
                  const Divider(),
                  const Text(
                    'Overview',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    movie.overview,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenresCategoryNameBox extends StatelessWidget {
  const _GenresCategoryNameBox({required this.title, required this.color});
  final String? title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return title == null
        ? Container()
        : Container(
            margin: const EdgeInsets.only(right: 10, top: 15, bottom: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: color),
            child: Text(
              title!,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.white),
            ),
          );
  }
}
