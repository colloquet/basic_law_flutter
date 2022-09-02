import '../models/question.dart';
import '../models/text_node.dart';

class MainModel {
  MainModel({
    required this.basicLawText,
    required this.questions,
  });

  List<TextNode> basicLawText;
  List<Question> questions;
}
