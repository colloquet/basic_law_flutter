import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  const Subtitle({
    Key? key,
    required this.text,
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
            style: textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
