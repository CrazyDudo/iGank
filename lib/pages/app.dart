/*
 * @Author: Randall 
 * @Date: 2018-12-18 16:56:24 
 * @Last Modified by: Randall
 * @Last Modified time: 2018-12-25 18:15:25
 */
import 'package:flutter/material.dart';
import 'package:igank/api/api.dart';
import 'package:igank/api/test.dart';
import 'package:igank/model/xiandu_data_entity.dart';
import 'package:igank/pages/android_project_list.dart';
import 'package:igank/pages/test.dart';
import 'package:igank/pages/trending.dart';
import 'package:igank/common/utils/net_utils.dart';
import 'login.dart';
import 'package:igank/pages/trending_list.dart';
import 'package:igank/model/android_data_entity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:igank/common/net_utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class iGankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XianduDataEntity dataEntity;

  @override
  Widget build(BuildContext context) {
    Widget userHeader = UserAccountsDrawerHeader(
        accountName: new Text('CrazyDudo'),
        accountEmail: new Text('cd@gmial.com'),
        currentAccountPicture: new GestureDetector(
          onTap: () {
            //start login
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return new Login();
            }));
          },
          child: new CircleAvatar(
            backgroundImage: AssetImage('images/github_profile_image.png'),
            radius: 35.0,
          ),
        ));
    return Scaffold(
      appBar: AppBar(
        title: Text("iGank"),
      ),
      body: new Center(
        child: _getBody(),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            userHeader, // 可在这里替换自定义的header
            ListTile(
              title: Text('Images'),
              leading: new Icon(
                (Icons.photo_library),
              ),
              onTap: () {
                print('onTap:photo');

                Navigator.pop(context);

                //start trending page
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new JsonSeralizablePage();
                }));
              },
            ),
            ListTile(
              title: Text('Android'),
              leading: new Icon(Icons.android),
              onTap: () {
                print('onTap:Android');
                //start trending page
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new AndroidProjectList();
                }));
              },
            ),
            ListTile(
              title: Text('Bookmarks'),
              leading: new Icon(Icons.bookmark),
              onTap: () {
                print('onTap:Bookmarks');
                Fluttertoast.showToast(msg: "Bookmarks");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: new Icon(Icons.settings),
              onTap: () {
                print('onTap:Settings');
                Fluttertoast.showToast(msg: "Settings");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('About'),
              leading: new Icon(Icons.info),
              onTap: () {
                Fluttertoast.showToast(msg: "About");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Share'),
              leading: new Icon(Icons.share),
              onTap: () {
                print('onTap:Share');
                Fluttertoast.showToast(msg: "Share");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Sign out'),
              leading: new Icon(Icons.power_settings_new),
              onTap: () {
                print('onTap:Sign out');
                Fluttertoast.showToast(msg: "Sign out");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
//    getContent();
    requestData();
  }

  _getBody() {
    if (dataEntity != null) {
      return new ListView.builder(
          itemCount: dataEntity.results.length,
          itemBuilder: (BuildContext context, int index) {
            return getItem(dataEntity, index);
//            return ListTile(
//                onTap: () {
//                  Fluttertoast.showToast(msg: dataEntity.results[index].title);
//                },
//                title: Text(dataEntity.results[index].title));
          });
    } else {
      // 加载菊花
      return _loadingAnimation();
    }
  }

  getItem(XianduDataEntity entity, int position) {
    String iamgeUrl;
    if (entity.results[position].site.icon != null) {
      iamgeUrl = entity.results[position].site.icon;
    } else {
      iamgeUrl = Api.DEFAULT_IAMGE;
    }

    var row = Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 8.0),
            height: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//     title
                Text(
                  entity.results[position].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  maxLines: 2,
                ),
//                Text('作者：${entity.results[position].who}'),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text('分类：${entity.results[position].site.name}', style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0,
                      ),),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Row(
                    children: <Widget>[
                      Text('日期：${entity.results[position].publishedAt}', style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0,
                      ),),
                    ],
                  ),
                )
              ],
            ),
          )),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              iamgeUrl,
              width: 20,
              height: 20,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );

    return Card(
      child: new ListTile(
        onTap: () {
          Fluttertoast.showToast(msg: entity.results[position].title);
          //start webView
          runApp(new MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            routes: {
              '/': (_) => new WebviewScaffold(
                    url:entity.results[position].url,
                    appBar: new AppBar(
                      title: new Text(entity.results[position].site.name),
                    ),
                  ),
            },
          ));
        },
        title: row,
      ),
    );
  }

  _loadingAnimation() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.0)),
    );
  }

  //方式一：获取网络数据
  void getContent() {
    NetUtil.getUrl(Api.GANK_XIANDU, (data) {
      XianduDataEntity entity = XianduDataEntity.fromJson(data);
      print("=======json=======" + entity.results[0].title);
      setState(() {
        dataEntity = entity;
      });
    }, errorCallBack: (errorMsg) {
      print("error:" + errorMsg);
    });
  }

//方式二：获取网络数据
  Future requestData() async {
    var response = await NetUtils.get(Api.GANK_XIANDU);
    XianduDataEntity entity = XianduDataEntity.fromJson(response);
    print("=======json=======" + entity.results[0].title);
    setState(() {
      dataEntity = entity;
    });
  }
}
