class XianduDataEntity {
  bool error;
  List<Results> results;

  XianduDataEntity({this.error, this.results});

  XianduDataEntity.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String sId;
  String content;
  String cover;
  int crawled;
  String createdAt;
  bool deleted;
  String publishedAt;
  String raw;
  Site site;
  String title;
  String uid;
  String url;

  Results(
      {this.sId,
        this.content,
        this.cover,
        this.crawled,
        this.createdAt,
        this.deleted,
        this.publishedAt,
        this.raw,
        this.site,
        this.title,
        this.uid,
        this.url});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    cover = json['cover'];
    crawled = json['crawled'];
    createdAt = json['created_at'];
    deleted = json['deleted'];
    publishedAt = json['published_at'];
    raw = json['raw'];
    site = json['site'] != null ? new Site.fromJson(json['site']) : null;
    title = json['title'];
    uid = json['uid'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['content'] = this.content;
    data['cover'] = this.cover;
    data['crawled'] = this.crawled;
    data['created_at'] = this.createdAt;
    data['deleted'] = this.deleted;
    data['published_at'] = this.publishedAt;
    data['raw'] = this.raw;
    if (this.site != null) {
      data['site'] = this.site.toJson();
    }
    data['title'] = this.title;
    data['uid'] = this.uid;
    data['url'] = this.url;
    return data;
  }
}

class Site {
  String catCn;
  String catEn;
  String desc;
  String feedId;
  String icon;
  String id;
  String name;
  int subscribers;
  String type;
  String url;

  Site(
      {this.catCn,
        this.catEn,
        this.desc,
        this.feedId,
        this.icon,
        this.id,
        this.name,
        this.subscribers,
        this.type,
        this.url});

  Site.fromJson(Map<String, dynamic> json) {
    catCn = json['cat_cn'];
    catEn = json['cat_en'];
    desc = json['desc'];
    feedId = json['feed_id'];
    icon = json['icon'];
    id = json['id'];
    name = json['name'];
    subscribers = json['subscribers'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_cn'] = this.catCn;
    data['cat_en'] = this.catEn;
    data['desc'] = this.desc;
    data['feed_id'] = this.feedId;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['name'] = this.name;
    data['subscribers'] = this.subscribers;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}
