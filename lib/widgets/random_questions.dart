import 'package:flutter/material.dart';

import 'questions_list.dart';

class RandomQuestions extends StatelessWidget {
  const RandomQuestions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const QuestionList(limit: 15);
  }
}
