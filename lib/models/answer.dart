class Answer {
  Answer({
    this.text,
    this.correct,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      text: json['text'],
      correct: json['correct'],
    );
  }

  String text;
  bool correct;
}
