import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../models/text_node.dart';
import '../store/main_model.dart';
import '../widgets/chapter_title.dart';
import '../widgets/list_items.dart';
import '../widgets/paragraph.dart';
import '../widgets/subtitle.dart';
import 'navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    final List<TextNode> basicLawText =
        context.select((MainModel value) => value.basicLawText);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _scrollController.scrollTo(
              index: 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          child: const Text('基本法全文'),
        ),
      ),
      body: ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
        padding: const EdgeInsets.only(right: 16, bottom: 96, left: 16),
        itemCount: basicLawText.length,
        itemBuilder: (BuildContext context, int index) {
          final TextNode node = basicLawText[index];
          switch (node.type) {
            case 'chapter-title':
              return ChapterTitle(text: node.text);
            case 'section-title':
              return ChapterTitle(text: node.text);
            case 'subtitle':
              return Subtitle(text: node.text);
            case 'paragraph':
              return Paragraph(text: node.text);
            case 'list':
              return ListItems(node: node);
            case 'separator':
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Divider(height: 1),
              );
            default:
              return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.list),
        onPressed: () async {
          final int? id = await Navigator.push(
            context,
            MaterialPageRoute<int>(
              builder: (BuildContext context) {
                return NavigationScreen();
              },
              fullscreenDialog: true,
            ),
          );

          if (id != null) {
            final int index =
                basicLawText.indexWhere((TextNode node) => node.id == id);
            _scrollController.jumpTo(index: index);
          }
        },
      ),
    );
  }
}
