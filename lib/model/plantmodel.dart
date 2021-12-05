import 'package:flutter/cupertino.dart';

class PlantCategoryModel {
  int id;
  Images img;
  String permalink;
  String name;

  PlantCategoryModel({this.id, this.name, this.img, this.permalink});

  PlantCategoryModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    img = json['image'] != null ? new Images.fromJson(json['image']) : null;
    permalink = json['permalink'];
    name = json['name'];

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    if (this.img != null) {
      data['image'] = this.img.toJson();
    }
    data['permalink'] = this.permalink;
    data['name'] = this.name;
    return data;
  }

}
class Images {
  int id;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String src;
  String name;
  String alt;

  Images(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.name,
        this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}