import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:upcoming_movies/screens/watch/upcoming_movies_list_page/movie_search_page.dart';
import 'package:upcoming_movies/utilities/app_theme.dart';
import 'package:upcoming_movies/widgets/shimmers/movie_card_shimmer.dart';
import '/models/movie.dart';
import '../../../providers/movies_provider.dart';
import '../movie_detail_page.dart/movie_detail_page.dart';

class UpcomingMoviesListPage extends StatefulWidget {
  const UpcomingMoviesListPage({super.key});

  @override
  State<UpcomingMoviesListPage> createState() => _UpcomingMoviesListPageState();
}

class _UpcomingMoviesListPageState extends State<UpcomingMoviesListPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final provider = Provider.of<MoviesProvider>(context, listen: false);
    await provider.getGenresName();
    await provider.getMovies();
    provider.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    return SafeArea(
      top: false,
      child: Consumer<MoviesProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(20, topPadding + 20, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Watch',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MovieSearchPage()));
                      },
                      child: const Icon(Icons.search,
                          size: 24, color: AppThemes.primary),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 40),
                    itemCount:
                        provider.fetchingMovies ? 10 : provider.movies.length,
                    itemBuilder: (_, index) {
                      if (provider.fetchingMovies) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: MovieCardShimmer(),
                        );
                      }
                      return _MovieCard(movie: provider.movies[index]);
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => MovieDetailPage(movie: movie))),
      child: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: movie.imageURL,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) {
                  return const MovieCardShimmer();
                },
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  movie.name,
                  softWrap: true,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    shadows: const [
                      Shadow(
                          blurRadius: 4,
                          color: Colors.black87,
                          offset: Offset(1, 1)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
