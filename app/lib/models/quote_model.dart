

class Quote {
  final int id;
  final String text;
  final String name;

  const Quote({
    required this.id,
    required this.text,
    required this.name
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json["id"],
      text: json["text"],
      name: json["name"],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Quote &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              text == other.text &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ name.hashCode;
}

class QuoteRequest {
  final String text;
  final String name;

  QuoteRequest({required this.text, required this.name});

  Map<String, dynamic> toJson() => {
    'text': text,
    'name': name
  };
}