import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:igank/model/image_data_entity.dart';

import 'package:igank/common/utils/net_utils.dart';

import 'package:dio/dio.dart';
 import 'package:igank/api/api.dart';
import 'package:igank/model/category_entiry.dart';

class JsonSeralizablePage extends StatefulWidget {
  @override
  _JsonSeralizablePageState createState() => _JsonSeralizablePageState();
}

class _JsonSeralizablePageState extends State<JsonSeralizablePage> {
  String name = "";
  String email = "";
  PictureDataEntity dataEntity;

  List<String> picList = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON"),
      ),
      body: _getBody(),
/*      body: new Center(
//        child: new Text("name=" + name),
        child: new ListView(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              dataEntity.results[0].url,
              width: 100.0,
              height: 150.0,
              fit: BoxFit.fill,
            ),
          ),
        ]),
      ),*/
    );
  }

  _getBody() {
    if (dataEntity != null) {
      return ListView.builder(
          itemCount: dataEntity.results.length,
          itemBuilder: (BuildContext context, int position) {
            return _getItem(dataEntity.results[position].url);
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

  _getItem(String url) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
                child: new CachedNetworkImage(
                  imageUrl: url,
                ),
/*        child: Image.network(
          url,
          width: 300,
          height: 450,
//              fit: BoxFit.fill,
          fit: BoxFit.scaleDown,
        ),*/
      ),
/*      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              url,
              width: 300,
              height: 450,
//              fit: BoxFit.fill,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),*/
    );

/*    return Card(
       return row;
    );*/
  }

  @override
  void initState() {
    super.initState();
    getContent();
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
        dataEntity = autogenerated;
      });
    }, errorCallBack: (errorMsg) {
      print("error:" + errorMsg);
    });
  }
}
