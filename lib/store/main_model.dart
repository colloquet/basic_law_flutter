import 'package:basic_law_flutter/models/text_node.dart';
import 'package:basic_law_flutter/models/question.dart';

class MainModel {
  MainModel({
    this.basicLawText,
    this.questions,
  });

  List<TextNode> basicLawText;
  List<Question> questions;
}
