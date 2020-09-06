
import 'package:app/models/newsapi.dart';

//contract to be implemented by some other class who uses it
abstract class NewsApiInterface {

  Future<NewsApi> fetchNewsApi();

}