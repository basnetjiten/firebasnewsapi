import 'dart:convert';

import 'package:app/models/newsapi.dart';
import 'package:http/http.dart' as http;
import 'package:app/repository/repocontract.dart';

class NewsApiDS implements NewsApiInterface {
  final httpClient = http.Client();
  final String baseUrl =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=acc3485c8b4143ba9d5dae0a2e2102ed";

  @override
  Future<NewsApi> fetchNewsApi() async {
    try {
      http.Response response = await httpClient.get(baseUrl);
      var responseString = response.body;
      Map<String, dynamic> mapJson = json.decode(responseString);
      NewsApi newsApi = NewsApi.fromJson(mapJson);
      return newsApi;
    }
    /*catch (_) {
      print("error occured");
    }*/
     finally {
      httpClient.close();
    }
  }
}
/*  try {
      var uriResponse = await httpClient.get(baseUrl);
      Map<String, dynamic> jsonString = json.decode(uriResponse.body);
      NewsApi newsApi = NewsApi.fromJSON(jsonString);
      print(newsApi.toJson());
      return newsApi;
    } finally {
      httpClient.close();
    }
  }*/
