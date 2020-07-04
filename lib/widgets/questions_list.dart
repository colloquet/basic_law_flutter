import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:basic_law_flutter/store/main_model.dart';
import 'package:basic_law_flutter/models/question.dart';
import 'package:basic_law_flutter/widgets/question_item.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({
    Key key,
    this.limit,
  }) : super(key: key);

  final int limit;

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  List<Question> shuffledQuestions;

  @override void initState() {
    super.initState();

    final List<Question> questions =
        context.read<MainModel>().questions;
    shuffledQuestions = (questions.toList()..shuffle())
        .take(widget.limit == null ? questions.length : widget.limit)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
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
