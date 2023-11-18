import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumbo/features/views/user_view/user_home/settings%20page.dart';
import 'package:jumbo/utils/constants/colors.dart';

import 'categories page.dart';
import 'favorites page.dart';
import 'homepage.dart';

class HomeNavbar extends StatefulWidget {
  const HomeNavbar({Key? key}) : super(key: key);

  @override
  _HomeNavbarState createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  int _selectedTab = 0;


  final List<Widget> _pages = [HomePage(), Categories(), Favorites(), Settings()];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: TColors.primary,
            unselectedItemColor: TColors.black,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedTab,
            onTap: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Accuiel',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart_fill),
                label: 'Favoris',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings_solid),
                label: 'Parametres',
              ),
            ],
          ),
        ),
      ),
    );
  }
}