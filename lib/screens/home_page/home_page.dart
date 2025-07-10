import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upcoming_movies/providers/base_provider.dart';
import 'package:upcoming_movies/screens/dashboard/dashboard_page.dart';
import 'package:upcoming_movies/screens/favorites/favorites_page.dart';
import 'package:upcoming_movies/screens/more/more_page.dart';
import 'package:upcoming_movies/utilities/app_icons.dart';
import '../watch/upcoming_movies_list_page/upcoming_movies_list_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    DashboardPage(),
    const UpcomingMoviesListPage(),
    FavoritesPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final BaseProvider provider = Provider.of<BaseProvider>(context);
    return Scaffold(
      body: _screens[provider.currentIndex],
      extendBody: true, // Allows content to appear behind the nav bar
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
          child: BottomNavigationBar(
            currentIndex: provider.currentIndex,
            onTap: (index) => provider.currentIndex = index,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(fontSize: 11),
            unselectedLabelStyle: const TextStyle(fontSize: 11),
            items: [
              BottomNavigationBarItem(
                icon: _BottomBarIcon(itemIndex: 0, icon: AppIcons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: _BottomBarIcon(itemIndex: 1, icon: AppIcons.watch),
                label: 'Watch',
              ),
              BottomNavigationBarItem(
                icon: _BottomBarIcon(itemIndex: 2, icon: AppIcons.mediaLibrary),
                label: 'Favorites',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'More',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBarIcon extends StatelessWidget {
  const _BottomBarIcon({required this.icon, required this.itemIndex});
  final int itemIndex;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseProvider>(
      builder: (_, provider, __) {
        return SizedBox(
          height: 40,
          width: 20,
          child: Image.asset(
            icon,
            color:
                provider.currentIndex == itemIndex ? Colors.white : Colors.grey,
          ),
        );
      },
    );
  }
}
