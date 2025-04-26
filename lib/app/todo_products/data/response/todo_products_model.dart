// To parse this JSON data, do
//
//     final getAsOfDateModel = getAsOfDateModelFromJson(jsonString);

import 'dart:convert';

List<GetProductModel> getAsOfDateModelFromJson(String str) => List<GetProductModel>.from(json.decode(str).map((x) => GetProductModel.fromJson(x)));

String getAsOfDateModelToJson(List<GetProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetProductModel {
  int? id;
  int? pD;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  bool? isSelected;
  Rating? rating;

  GetProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.isSelected,
    this.pD
  });

  factory GetProductModel.fromJson(Map<String, dynamic> json) => GetProductModel(
    id: json["id"],
    isSelected: false,
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: json["category"],
    image: json["image"],
    pD: json["pD"],
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    // "pD":pD,
    "description": description,
    // "category": category,
    // "image": image,
    // "rating": rating?.toJson(),
  };
}




class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"]?.toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}


