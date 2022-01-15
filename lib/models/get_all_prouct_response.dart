// To parse this JSON data, do
//
//     final getAllProduct = getAllProductFromMap(jsonString);

import 'dart:convert';

class GetAllProduct {
  GetAllProduct({
    this.data,
    this.success,
  });

  List<Product>? data;
  String? success;

  factory GetAllProduct.fromJson(String str) => GetAllProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllProduct.fromMap(Map<String, dynamic> json) => GetAllProduct(
    data: List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
    success: json["success"],
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "success": success,
  };
}

class Product {
  Product({
    this.proId,
    this.name,
    this.price,
  });

  String? proId;
  String? name;
  String? price;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    proId: json["pro_id"],
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "pro_id": proId,
    "name": name,
    "price": price,
  };
}
