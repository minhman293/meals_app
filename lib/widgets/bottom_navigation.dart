import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, required this.pageIndex, required this.selectPage});

  final int pageIndex;
  final void Function(int) selectPage;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: selectPage,
      currentIndex: pageIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Categories'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
      ],
    );
  }
}
