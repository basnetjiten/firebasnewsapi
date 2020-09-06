
import 'package:app/models/newsapi.dart';

abstract class NewsApiState {}

class InitialNewsApiState extends NewsApiState{}

class NewsApiFetchedState extends NewsApiState{

  final NewsApi newsApi;
  NewsApiFetchedState({this.newsApi});
}
class NewsApiErrorState extends NewsApiState{}
