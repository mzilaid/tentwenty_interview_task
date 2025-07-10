import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:upcoming_movies/providers/base_provider.dart';
import 'providers/movies_provider.dart';
import '/screens/home_page/home_page.dart';
import '/utilities/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseProvider>(
          create: (_) => BaseProvider(),
        ),
        ChangeNotifierProvider<MoviesProvider>(
          create: (_) => MoviesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Upcoming Movies',
        theme: AppThemes.light,
        home: const HomeScreen(),
      ),
    );
  }
}
