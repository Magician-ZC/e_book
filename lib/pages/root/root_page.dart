import 'package:e_book/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class RootPage extends StatelessWidget {
  RootPage({super.key});
  int _index = 0;
  List rootApp = [
    {"icon": LineIcons.home, "text": "首页"},
    {"icon": LineIcons.book, "text": "豆瓣读书"},
    {"icon": LineIcons.shoppingBag, "text": "电子书城"},
    {"icon": LineIcons.heart, "text": "我的"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: _getBottomNavigator(context),
      body: LazyLoadIndexedStack(
        index: _index,
        children: const [HomePage()],
      ),
    );
  }

  Widget _getBottomNavigator(BuildContext context) {
    return SalomonBottomBar(
        currentIndex: _index,
        items: List.generate(4, (index) {
          return SalomonBottomBarItem(
              selectedColor: Theme.of(context).colorScheme.onSurface,
              unselectedColor: Theme.of(context).colorScheme.inversePrimary,
              icon: Icon(rootApp[index]['icon']),
              title: Text(rootApp[index]['text']));
        }));
  }
}
