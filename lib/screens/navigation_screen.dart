import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/text_node.dart';
import '../store/main_model.dart';

class NavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final List<TextNode> basicLawText =
        context.select((MainModel value) => value.basicLawText);
    final List<TextNode> titles = basicLawText
        .where((TextNode node) =>
            node.type == 'chapter-title' || node.type == 'section-title')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('目錄'),
      ),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1.0),
        itemCount: titles.length,
        itemBuilder: (BuildContext context, int index) {
          final TextNode node = titles[index];

          switch (node.type) {
            case 'chapter-title':
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop(node.id);
                },
                child: Ink(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    node.text,
                    style: textTheme.subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            case 'section-title':
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop(node.id);
                },
                child: Ink(
                  padding: const EdgeInsets.only(
                      top: 8, right: 8, bottom: 8, left: 32),
                  child: Text(node.text,
                      style: textTheme.subtitle2!
                          .copyWith(fontWeight: FontWeight.normal)),
                ),
              );
            default:
              return Text(node.text);
          }
        },
      ),
    );
  }
}
