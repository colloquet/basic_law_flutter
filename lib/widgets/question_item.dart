import 'package:flutter/material.dart';

import 'package:basic_law_flutter/models/question.dart';
import 'package:basic_law_flutter/models/answer.dart';

class QuestionItem extends StatefulWidget {
  const QuestionItem({
    Key key,
    this.index,
    this.question,
  }) : super(key: key);

  final int index;
  final Question question;

  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  int selectedAnswerIndex = -1;
  List<Answer> shuffledAnswers;

  @override
  void initState() {
    super.initState();
    shuffledAnswers = widget.question.answers.toList()..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 8),
          child: SelectableText(
            '${widget.index + 1}. ${widget.question.text}',
            style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ...shuffledAnswers
            .asMap()
            .entries
            .map((MapEntry<int, Answer> entry) {
          final int index = entry.key;
          final Answer answer = entry.value;
          final bool isActive = index == selectedAnswerIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAnswerIndex = index;
              });
            },
            child: Material(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: index,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: answer.correct ? Colors.green : Colors.red,
                      groupValue: selectedAnswerIndex,
                      onChanged: (int value) {
                        setState(() {
                          selectedAnswerIndex = value;
                        });
                      },
                    ),
                    Flexible(
                      child: Text(
                        answer.text,
                        softWrap: true,
                        style: textTheme.bodyText2.copyWith(
                            color: isActive
                                ? answer.correct ? Colors.green : Colors.red
                                : null),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }
}
