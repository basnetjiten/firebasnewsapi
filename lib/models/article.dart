import 'package:app/models/source.dart';

class Article {
  String author;
  String content;
  String description;
  String publishedAt;
  Source source;
  String title;
  String url;
  String urlToImage;

  Article.fromJSON(Map<String, dynamic> parsedJson) {
    this.author = parsedJson['author'];
    this.content = parsedJson['content'];
    this.description = parsedJson['description'];
    this.publishedAt = parsedJson['publishedAt'];
    var sourcedata = parsedJson['source'];
    this.source=sourcedata.map<Source>((json) => Source.fromJSON(json));
    this.title = parsedJson['title'];
    this.url = parsedJson['url'];
    this.urlToImage = parsedJson['urlToImage'];
  }

  Map<String, dynamic> toJson() => {
        "author": author,
        "content": content,
        "description": description,
        "publishedAt": publishedAt,
        "source": source,
        "title": title,
        "url": url,
        "urlToImage": urlToImage
      };
}
