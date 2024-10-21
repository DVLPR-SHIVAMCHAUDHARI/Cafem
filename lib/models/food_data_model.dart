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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (img != null) {
      data["img"] = img;
    }
    data["price"] = price;
    data["title"] = title;
    data["desc"] = desc;
    return data;
  }
}
