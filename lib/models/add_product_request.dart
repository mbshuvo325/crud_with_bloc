// To parse this JSON data, do
//
//     final createProductRequest = createProductRequestFromMap(jsonString);

import 'dart:convert';

class CreateProductRequest {
  CreateProductRequest({
    required this.name,
    required this.price,
    this.id,
  });

  String name;
  double price;
  String? id;

  factory CreateProductRequest.fromJson(String str) => CreateProductRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateProductRequest.fromMap(Map<String, dynamic> json) => CreateProductRequest(
    name: json["name"],
    price: json["price"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "price": price,
    "id" : id,
  };
}
