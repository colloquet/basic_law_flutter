import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:basic_law_flutter/store/main_model.dart';
import 'package:basic_law_flutter/models/question.dart';
import 'package:basic_law_flutter/widgets/question_item.dart';

class RandomQuestions extends StatefulWidget {
  const RandomQuestions({
    Key key,
  }) : super(key: key);

  @override
  _RandomQuestionsState createState() => _RandomQuestionsState();
}

class _RandomQuestionsState extends State<RandomQuestions> {
  List<Question> questions;

  @override
  void initState() {
    super.initState();
    final List<Question> allQuestions = context.read<MainModel>().questions;
    questions = (allQuestions.toList()..shuffle()).take(15).toList();
  }

  @override
  Widget build(BuildContext context) {
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
