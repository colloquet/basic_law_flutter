import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'practice_screen.dart';
import 'settings_screen.dart';

class Destination {
  const Destination(this.index, this.name, this.icon, this.widget);
  final int index;
  final String name;
  final IconData icon;
  final Widget widget;
}

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with TickerProviderStateMixin {
  late List<Key> _destinationKeys;
  late List<AnimationController> _faders;

  int _currentIndex = 0;

  final List<Destination> allDestinations = <Destination>[
    Destination(0, '全文', Icons.book, HomeScreen()),
    Destination(1, '試題', Icons.list, PracticeScreen()),
    Destination(2, '設定', Icons.settings, SettingsScreen()),
  ];

  @override
  void initState() {
    super.initState();

    _faders =
        allDestinations.map<AnimationController>((Destination destination) {
      return AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200));
    }).toList();
    _faders[_currentIndex].value = 1.0;
    _destinationKeys =
        List<Key>.generate(allDestinations.length, (int index) => GlobalKey())
            .toList();
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: allDestinations.map((Destination destination) {
          final Widget view = FadeTransition(
            opacity: _faders[destination.index]
                .drive(CurveTween(curve: Curves.fastOutSlowIn)),
            child: KeyedSubtree(
              key: _destinationKeys[destination.index],
              child: destination.widget,
            ),
          );
          if (destination.index == _currentIndex) {
            _faders[destination.index].forward();
            return view;
          } else {
            _faders[destination.index].reverse();
            if (_faders[destination.index].isAnimating) {
              return IgnorePointer(child: view);
            }
            return Offstage(child: view);
          }
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: _currentIndex,
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination.icon),
            label: destination.name,
          );
        }).toList(),
      ),
    );
  }
}
