import 'package:app/blocs/authentication_bloc/bloc.dart';
import 'package:app/blocs/authentication_bloc/event.dart';
import 'package:app/blocs/authentication_bloc/state.dart';
import 'package:app/blocs/newsapi/bloc.dart';
import 'package:app/blocs/newsapi/event.dart';
import 'package:app/google_signin.dart';
import 'package:app/models/article.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/newsapi/state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: checkIfUserIsAlreadyLoggedIn()

        // },

        );
  }

  checkIfUserIsAlreadyLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      return NewsListPage(
        user: user,
      );
    } else {
      return LoginPage();
    }
  }
}

class NewsListPage extends StatefulWidget {
  final User user;

  NewsListPage({this.user});

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  //instance of newsapiBloc
  NewsApiBloc _newsApiBloc;

  @override
  void initState() {
    _newsApiBloc = NewsApiBloc(InitialNewsApiState())..add(FetchNewsApi());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.displayName,
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
            final List<Articles> articleList = state.newsApi.articles;

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
