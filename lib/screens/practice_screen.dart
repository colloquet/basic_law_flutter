import 'package:basic_law_flutter/widgets/all_questions.dart';
import 'package:basic_law_flutter/widgets/random_questions.dart';
import 'package:flutter/material.dart';

class PracticeScreen extends StatefulWidget {
  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final ScrollController scrollController = ScrollController();

  int tabIndex = 0;
  final List<Widget> tabs = <Widget>[
    const AllQuestions(),
    const RandomQuestions(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2)
      ..addListener(() {
        setState(() {
          tabIndex = tabController.index;
        });
        scrollController.jumpTo(0);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            title: GestureDetector(
              onTap: () {
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              child: const Text('練習試題'),
            ),
            bottom: TabBar(
              controller: tabController,
              tabs: const <Widget>[
                Tab(text: '全部問題'),
                Tab(text: '隨機15條'),
              ],
            ),
          ),
          tabs[tabIndex],
        ],
      ),
    );
  }
}
