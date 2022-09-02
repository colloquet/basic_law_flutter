import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/answer.dart';
import '../models/question.dart';
import '../store/main_model.dart';
import 'question_item.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({
    Key? key,
    this.limit,
  }) : super(key: key);

  final int? limit;

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  late List<Question> shuffledQuestions;
  late List<List<Answer>> shuffledAnswers;

  @override
  void initState() {
    super.initState();

    final List<Question> questions = context.read<MainModel>().questions;
    shuffledQuestions = (questions.toList()..shuffle())
        .take(widget.limit == null ? questions.length : widget.limit!)
        .toList();
    shuffledAnswers = shuffledQuestions.map((Question question) {
      return question.answers.toList()..shuffle();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final Question question = shuffledQuestions[index];
          final List<Answer> answers = shuffledAnswers[index];
          return QuestionItem(
            index: index,
            question: question,
            answers: answers,
          );
        },
        childCount: shuffledQuestions.length,
      ),
    );
  }
}
