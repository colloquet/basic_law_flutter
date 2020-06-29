import 'package:basic_law_flutter/widgets/questions_list.dart';
import 'package:flutter/material.dart';

class RandomQuestions extends StatelessWidget {
  const RandomQuestions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const QuestionList(limit: 15);
  }
}
