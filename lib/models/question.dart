import 'answer.dart';

class Question {
  Question({
    required this.text,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'],
      answers: json['answers']
          .map<Answer>((dynamic child) => Answer.fromJson(child))
          .toList(),
    );
  }

  String text;
  List<Answer> answers;
}
