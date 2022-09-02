import 'package:flutter/material.dart';

import '../models/text_node.dart';

class ListItems extends StatelessWidget {
  const ListItems({
    Key? key,
    required this.node,
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
            if (node.children != null)
              ...node.children!.map((TextNode _node) {
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
