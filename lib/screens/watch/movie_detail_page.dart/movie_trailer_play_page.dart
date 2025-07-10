import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upcoming_movies/providers/movies_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerPlayPage extends StatefulWidget {
  const MovieTrailerPlayPage({required this.movieId, super.key});
  final String movieId;

  @override
  State<MovieTrailerPlayPage> createState() => _MovieTrailePlayPageState();
}

class _MovieTrailePlayPageState extends State<MovieTrailerPlayPage> {
  bool _fetching = true;
  YoutubePlayerController? controller;
  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  initializeVideo() async {
    MoviesProvider provider =
        Provider.of<MoviesProvider>(context, listen: false);
    String? trailerVideoId = await provider.getTrailerId(widget.movieId);
    if (trailerVideoId == null) {
      setState(() {
        _fetching = false;
      });
      return;
    }
    controller = YoutubePlayerController(
        initialVideoId: trailerVideoId,
        flags: YoutubePlayerFlags(autoPlay: true))
      ..addListener(_videoListener);
    setState(() {
      _fetching = false;
    });
  }

  void _videoListener() {
    if (controller != null &&
        controller!.value.playerState == PlayerState.ended) {
      controller!.removeListener(_videoListener);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    controller?.removeListener(_videoListener);
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) {
      return Material(
          child: Center(child: CircularProgressIndicator.adaptive()));
    }
    if (controller == null) {
      return Material(
        child: Center(
          child: Text('Failed to fetch trailer'),
        ),
      );
    }
    return YoutubePlayer(controller: controller!);
  }
}
