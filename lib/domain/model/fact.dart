class Fact {
  final String id;
  final String text;
  final String sourceUrl;
  final String iconUrl;

  Fact({this.id, this.text, this.iconUrl, this.sourceUrl});

  factory Fact.fromJson(Map<String, dynamic> json) {
    return Fact(
      id: json['id'],
      text: json['value'],
      iconUrl: json['icon_url'],
      sourceUrl: json['url'],
    );
  }
}
