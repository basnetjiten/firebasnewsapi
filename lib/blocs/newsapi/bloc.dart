import 'package:app/blocs/newsapi/event.dart';
import 'package:app/blocs/newsapi/state.dart';
import 'package:app/models/newsapi.dart';
import 'package:app/repository/newsapids.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsApiBloc extends Bloc<NewsApiEvent, NewsApiState> {
  NewsApiBloc(initialState) : super(initialState);

  @override
  Stream<NewsApiState> mapEventToState(event) async* {
    final db = FirebaseFirestore.instance;
    if (event is FetchNewsApi) {
      NewsApiDS newsApiDS = NewsApiDS();
      NewsApi newsApi;
      //lets say they use mysql database
      newsApi = await newsApiDS.fetchNewsApi();
      if (newsApi.status == "ok") {
        //when the connection is success

        await db
            .collection("NewsApi")
            .doc("LatestHeadline")
            .set(newsApi.toJson(), SetOptions(merge: true))
            .whenComplete(() {
          final data = fetchNewsFromFireStore();
          print(data.toString());
        });
        yield NewsApiFetchedState(newsApi: newsApi);
      }
    }
  }

  Future<DocumentSnapshot> fetchNewsFromFireStore() async {
    final db = FirebaseFirestore.instance;
    final newsApiFromFireStore =
    await db.collection('NewsApi').doc('LatestHeadline').get();
    return newsApiFromFireStore;
  }
}
