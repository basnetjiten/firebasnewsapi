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
    final db = Firestore.instance;
    if (event is FetchNewsApi) {
      NewsApiDS newsApiDS = NewsApiDS();
      NewsApi newsApi;
      newsApi = await newsApiDS.fetchNewsApi();
      if (newsApi.status == "ok") {
        //when the connection is success

        /*await db
            .collection("NewsApi")
            .document("LatestHeadline")
            .setData(newsApi.toJson(), merge: true)
            .whenComplete(() {

        final data=    fetchNewsFromFireStore();*/

        yield NewsApiFetchedState(newsApi: newsApi);
      }
    }
  }

  Future<DocumentSnapshot> fetchNewsFromFireStore() async {
    final db = Firestore.instance;
    final newsApiFromFireStore =
        await db.collection('NewsApi').document('LatestHeadline').get();
    return newsApiFromFireStore;
  }
}
