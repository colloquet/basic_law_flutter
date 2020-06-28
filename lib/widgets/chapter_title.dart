import 'package:flutter/material.dart';

class ChapterTitle extends StatelessWidget {
  const ChapterTitle({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16),
          SelectableText(
            text,
            style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
