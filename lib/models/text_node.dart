class TextNode {
  TextNode({
    required this.id,
    required this.type,
    required this.text,
    this.children,
  });

  factory TextNode.fromJson(Map<String, dynamic> json) {
    return TextNode(
        id: json['id'],
        type: json['type'],
        text: json['text'] ?? '',
        children: json['type'] == 'list'
            ? json['children']
                .map<TextNode>((dynamic child) => TextNode.fromJson(child))
                .toList()
            : null);
  }

  int id;
  String type;
  String text;
  List<TextNode>? children;
}
