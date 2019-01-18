import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:igank/model/android_data_entity.dart';
import 'package:igank/model/android_data_entity.dart';
import 'package:igank/model/android_data_entity.dart';
import 'package:igank/model/image_data_entity.dart';

import 'package:igank/common/utils/net_utils.dart';

import 'package:dio/dio.dart';

import 'package:igank/api/api.dart';
import 'package:igank/model/category_entiry.dart';
import 'package:igank/common/net_utils.dart';
import 'package:url_launcher/url_launcher.dart';

///用于测试
class AndroidProjectList extends StatefulWidget {
  @override
  _AndroidProjectListState createState() => _AndroidProjectListState();
}

class _AndroidProjectListState extends State<AndroidProjectList> {
  String name = "";
  String email = "";

//  PictureDataEntity dataEntity;
  AndroidDataEntity dataEntity;

  List<String> picList = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Android"),
      ),
      body: _getBody(),
    );
  }

  _getBody() {
    if (dataEntity != null) {
      return ListView.builder(
          itemCount: dataEntity.results.length,
          itemBuilder: (BuildContext context, int position) {
//          return  new Text(dataEntity.results[position].who);

            return getItem(dataEntity, position);
          });
    } else {
      // 加载菊花
      return _loadingAnimation();
    }
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

  getItem(AndroidDataEntity entity, int position) {
    String iamgeUrl;
    if (entity.results[position].images != null) {
      iamgeUrl = entity.results[position].images[0];
    } else {
      iamgeUrl = Api.DEFAULT_IAMGE;
    }

    var row = Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              iamgeUrl,
              width: 80.0,
              height: 120.0,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 8.0),
            height: 130.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//     title
                Text(
                  entity.results[position].desc,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  maxLines: 2,
                ),
//                Text('作者：${entity.results[position].who}'),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '作者：${entity.results[position].who}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '日期：${entity.results[position].publishedAt}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
/*    return Card(
      child: row,
    );*/

    return Card(
      child: new ListTile(
        onTap: () {
          //start webView
          runApp(new MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            routes: {
              '/': (_) => new WebviewScaffold(
                    appBar: AppBar(
                      title: Text(entity.results[position].desc),
                    ),
                    withLocalStorage: true,
                    url: entity.results[position].url,
                    withJavascript: true,
                  ),
            },

/*            routes: {
              '/': (_) => new WebviewScaffold(
                url: entity.results[position].url,
                appBar: new AppBar(
                  title: new Text("Android"),
                ),
              ),
            },
            */
          ));
        },
        title: row,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
//    getContent();
    requestData();
  }

  //获取网络数据
  void getContent() {
    NetUtil.getByFullUrl(Api.GANK_FULI, (data) {
//      User user = User.fromJson(data);
//      CategoryEntity autogenerated = CategoryEntity.fromJson(data);
      PictureDataEntity autogenerated = PictureDataEntity.fromJson(data);
      print(data);
//      XianDuListEntity entity = XianDuListEntity.fromJson(data);
      print("=======json=======" + autogenerated.results[0].url);
      setState(() {
        name = autogenerated.results[0].url;
//        dataEntity = autogenerated;
      });
    }, errorCallBack: (errorMsg) {
      print("error:" + errorMsg);
    });
  }

  Future requestData() async {
    var response = await NetUtils.get(Api.GANK_Android);
    print(response.toString());
    AndroidDataEntity entity = AndroidDataEntity.fromJson(response);
    print(entity.results[0].desc);

    setState(() {
      dataEntity = entity;
    });
  }
}
