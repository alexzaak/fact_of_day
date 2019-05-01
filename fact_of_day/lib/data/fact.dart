class Fact {
  final String text;
  final String permalink;
  final String sourceUrl;
  final String language;
  final String source;

  Fact({this.text, this.permalink, this.sourceUrl, this.language, this.source});

  factory Fact.fromJson(Map<String, dynamic> json) {
    return Fact(
      text: json['text'],
      permalink: json['permalink'],
      sourceUrl: json['source_url'],
      language: json['language'],
      source: json['source'],
    );
  }
}
