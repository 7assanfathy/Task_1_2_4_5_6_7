import 'package:flutter/material.dart';
import 'package:projects/dashboard/dashboard_screen.dart';
import 'package:projects/favorite/favorite_screen.dart';
import 'package:projects/page/page_screen.dart';
import 'package:projects/profile/profile_page/profile_page.dart';
import 'package:projects/quote/quote_screen.dart';
class NavBar extends StatefulWidget {
  const NavBar({super.key});
  @override
  State<NavBar> createState() => _NavBarState();
}
class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          [DashboardScreen(),
            QuoteScreen(),
            FavoriteScreen(),
            ProfilePage(),
            PageScreen()
          ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'dashboard',),
          NavigationDestination(icon: Icon(Icons.format_quote), label: 'quote'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'favorite'),
          NavigationDestination(icon: Icon(Icons.person), label: 'profile'),
          NavigationDestination(icon: Icon(Icons.link_off_rounded), label: 'Page',),
        ],
      ),
    );
  }
}