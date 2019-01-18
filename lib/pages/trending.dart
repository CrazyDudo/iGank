import 'package:flutter/material.dart';
import 'package:igank/api/api.dart';

import 'package:igank/widget/common_listview.dart';

class Trending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TrendingPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class TrendingPage extends StatefulWidget {
  TrendingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: new Center(
        child: new InfiniteListView(),
      ),
    );
  }
}


