import 'package:app/models/source.dart';

class NewsApi {
  List<Article> articles;
  String status;
  int totalResults;

  NewsApi.fromJSON(Map<String, dynamic> parsedJson) {
    var articleMap = parsedJson['articles'];

    this.articles = articleMap.map<Article>((json) => Article.fromJSON(json)).toList();
    this.status = parsedJson['status'];
    this.totalResults = parsedJson['totalResults'];
  }

  Map<String, dynamic> toJson() => {
        "articles": articles,
        "status": status,
        "totalResults": totalResults,
      };
}

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
    var parsedSource = parsedJson['source'];
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
