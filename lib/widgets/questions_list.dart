import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:basic_law_flutter/store/main_model.dart';
import 'package:basic_law_flutter/models/question.dart';
import 'package:basic_law_flutter/widgets/question_item.dart';

class QuestionList extends StatelessWidget {
  const QuestionList({
    Key key,
    this.limit,
  }) : super(key: key);

  final int limit;

  @override
  Widget build(BuildContext context) {
    final List<Question> questions =
        context.select((MainModel value) => value.questions);
    final List<Question> shuffledQuestions = (questions.toList()..shuffle())
        .take(limit == null ? questions.length : limit)
        .toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final Question question = shuffledQuestions[index];
          return QuestionItem(index: index, question: question);
        },
        childCount: shuffledQuestions.length,
      ),
    );
  }
}
