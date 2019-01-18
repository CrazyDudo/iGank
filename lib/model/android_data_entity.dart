import 'package:json_annotation/json_annotation.dart';

part 'android_data_entity.g.dart';


@JsonSerializable()
class AndroidDataEntity extends Object {

  @JsonKey(name: 'error')
  bool error;

  @JsonKey(name: 'results')
  List<Results> results;

  AndroidDataEntity(this.error,this.results,);

  factory AndroidDataEntity.fromJson(Map<String, dynamic> srcJson) => _$AndroidDataEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AndroidDataEntityToJson(this);

}


@JsonSerializable()
class Results extends Object {

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'images')
  List<String> images;

  @JsonKey(name: 'publishedAt')
  String publishedAt;

  @JsonKey(name: 'source')
  String source;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'used')
  bool used;

  @JsonKey(name: 'who')
  String who;

  Results(this.id,this.createdAt,this.desc,this.images,this.publishedAt,this.source,this.type,this.url,this.used,this.who,);

  factory Results.fromJson(Map<String, dynamic> srcJson) => _$ResultsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

}


