import 'package:app/blocs/newsapi/bloc.dart';
import 'package:app/blocs/newsapi/event.dart';
import 'package:app/models/newsapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/newsapi/state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        myTitle: "hello",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String myTitle;

  MyHomePage({this.myTitle});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String titleFromStatefulWidget;
  Offset position;

  //instance of newsapiBloc
  NewsApiBloc _newsApiBloc;

  @override
  void initState() {
    _newsApiBloc = NewsApiBloc(InitialNewsApiState())..add(FetchNewsApi());
    titleFromStatefulWidget = widget.myTitle;
    position = Offset(0.0, 80);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FLUTTER FIREBASE CLASS",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: BlocBuilder(
        cubit: _newsApiBloc,
        // ignore: missing_return
        builder: (context, state) {

          if (state is InitialNewsApiState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NewsApiFetchedState) {
            final List<Article> articleList = state.newsApi.articles;

            return Container(
              //height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: articleList.length,
                  itemBuilder: (context, index) {
                    final article = articleList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            article.title,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(article.content ?? "--")
                        ],
                      ),
                    );
                  }),
            );
          }
          if (state is NewsApiErrorState) {}
        },
      )),
    );
  }
}
