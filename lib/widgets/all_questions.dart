import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:basic_law_flutter/store/main_model.dart';
import 'package:basic_law_flutter/models/question.dart';
import 'package:basic_law_flutter/widgets/question_item.dart';

class AllQuestions extends StatelessWidget {
  const AllQuestions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Question> questions = context.select((MainModel value) => value.questions);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final Question question = questions[index];

          return QuestionItem(index: index, question: question);
        },
        childCount: questions.length,
      ),
    );
  }
}
