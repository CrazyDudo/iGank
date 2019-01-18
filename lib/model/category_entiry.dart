class CategoryEntity {
  bool error;
  List<Results> results;

  CategoryEntity({this.error, this.results});

  CategoryEntity.fromJson(Map<String, dynamic> json) {
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
  String enName;
  String name;
  int rank;

  Results({this.sId, this.enName, this.name, this.rank});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    enName = json['en_name'];
    name = json['name'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['en_name'] = this.enName;
    data['name'] = this.name;
    data['rank'] = this.rank;
    return data;
  }
}