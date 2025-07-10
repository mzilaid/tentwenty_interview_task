import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:upcoming_movies/models/movie.dart';

import '../../../providers/movies_provider.dart';
import '../../../widgets/shimmers/movie_card_shimmer.dart';
import '../movie_detail_page.dart/movie_detail_page.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  String searchQuery = '';
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final double topPadding = MediaQuery.of(context).padding.top;

    final List<Movie> filteredMovies = searchQuery.isEmpty
        ? []
        : moviesProvider.movies
            .where(
                (m) => m.name.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();

    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(20, topPadding + 20, 20, 20),
              child: isSubmitted
                  ? Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios)),
                        SizedBox(width: 10),
                        Text(
                          '${filteredMovies.length} Results Found',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xffF2F2F6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              size: 20, color: Colors.black),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'TV shows, movies and more',
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  searchQuery = text;
                                });
                              },
                              onSubmitted: (text) {
                                setState(() {
                                  searchQuery = text;
                                  isSubmitted = true;
                                });
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close_sharp,
                                size: 30, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
            ),
            Expanded(
              child: searchQuery.isEmpty
                  ? GridView.builder(
                      itemCount: moviesProvider.categories.length,
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 1.4,
                      ),
                      itemBuilder: (context, index) {
                        final category = moviesProvider.categories[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: category.imageUrl,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black45,
                                      Colors.transparent
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    category.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      shadows: const [
                                        Shadow(
                                            blurRadius: 3, color: Colors.black),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : filteredMovies.isEmpty
                      ? const Center(child: Text("No matching movies found"))
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40),
                              if (!isSubmitted) ...[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    'Top Result',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Divider(),
                                ),
                              ],
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                itemCount: filteredMovies.length,
                                itemBuilder: (_, index) {
                                  return _MovieSearchCard(
                                      movie: filteredMovies[index]);
                                },
                              ),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieSearchCard extends StatelessWidget {
  final Movie movie;

  const _MovieSearchCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => MovieDetailPage(movie: movie))),
      child: Container(
        height: 100,
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: movie.imageURL,
                fit: BoxFit.cover,
                width: 130,
                placeholder: (context, url) {
                  return const MovieCardShimmer();
                },
              ),
            ),
            SizedBox(
              width: 20,
            ),
            SizedBox(
              width: size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    movie.genres.first.name,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Icon(
              Icons.more_horiz,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
