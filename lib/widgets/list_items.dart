import 'package:flutter/material.dart';

import 'package:basic_law_flutter/models/text_node.dart';

class ListItems extends StatelessWidget {
  const ListItems({
    Key key,
    this.node,
  }) : super(key: key);

  final TextNode node;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 8),
            ...node.children.map((TextNode _node) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 8),
                  SelectableText(_node.text, style: textTheme.bodyText2),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
