
class FoodDataModel {
  List<dynamic>? img;
  String? price;
  String? title;
  String? desc;

  FoodDataModel({this.img, this.price, this.title, this.desc});

  FoodDataModel.fromJson(Map<String, dynamic> json) {
    img = json["img"] ?? [];
    price = json["price"];
    title = json["title"];
    desc = json["desc"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(img != null) {
      _data["img"] = img;
    }
    _data["price"] = price;
    _data["title"] = title;
    _data["desc"] = desc;
    return _data;
  }
}