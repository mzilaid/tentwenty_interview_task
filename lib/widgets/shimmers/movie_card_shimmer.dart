import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class MovieCardShimmer extends StatelessWidget {
  const MovieCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      width: double.infinity,
      height: 180,
      radius: 16,
      baseColor: Colors.grey,
      highlightColor: Colors.grey,
    );
  }
}
