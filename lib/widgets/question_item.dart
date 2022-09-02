import 'package:flutter/material.dart';

import '../models/answer.dart';
import '../models/question.dart';

class QuestionItem extends StatefulWidget {
  const QuestionItem({
    Key? key,
    required this.index,
    required this.question,
    required this.answers,
  }) : super(key: key);

  final int index;
  final Question question;
  final List<Answer> answers;

  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem>
    with AutomaticKeepAliveClientMixin {
  int selectedAnswerIndex = -1;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 8),
          child: SelectableText(
            '${widget.index + 1}. ${widget.question.text}',
            style: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ...widget.answers.asMap().entries.map((MapEntry<int, Answer> entry) {
          final int index = entry.key;
          final Answer answer = entry.value;
          final bool isActive = index == selectedAnswerIndex;
          final Color highlightColor =
              answer.correct ? Colors.green.shade400 : Colors.red;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAnswerIndex = index;
              });
            },
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Radio<int>(
                      value: index,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: highlightColor,
                      groupValue: selectedAnswerIndex,
                      onChanged: (int? value) {
                        if (value != null) {
                          setState(() {
                            selectedAnswerIndex = value;
                          });
                        }
                      },
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Text(
                            answer.text,
                            softWrap: true,
                            style: textTheme.bodyText2!.copyWith(
                                color: isActive ? highlightColor : null),
                          ),
                          if (isActive)
                            Icon(
                              answer.correct ? Icons.check : Icons.close,
                              color: highlightColor,
                            ),
                        ],
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
