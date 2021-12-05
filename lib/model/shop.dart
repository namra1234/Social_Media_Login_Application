class ShopModel {
  int id;
  String img;
  String permalink;
  String name;
  String price;

  ShopModel({this.id, this.name, this.img, this.permalink, this.price});

  ShopModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];


    img = json['images'] != null && json['images']?.length!=0 ?  json['images']?.first['src'] : "https://team3.devhostserver.com/onetreeworld/wp-content/uploads/2021/03/product-26.jpg";
    permalink = json['permalink'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['permalink'] = this.permalink;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }

}

