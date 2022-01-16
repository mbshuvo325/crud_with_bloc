import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:telentproapp/models/add_product_request.dart';
import 'package:telentproapp/models/get_all_prouct_response.dart';

class UserRepository {
  static const String baseUrl =
      "https://techtunes999.000webhostapp.com";

  Future<List<Product>> getAllProduct() async {
    var response = await http.get(Uri.parse("$baseUrl/product_retrive.php"));
    final userList = json.decode(response.body);
    List<Product> product = (userList["data"] as List<dynamic>).map((pro) => Product.fromMap(pro)).toList();
    return product;
  }

  Future<String> createProduct(CreateProductRequest request) async {
    var body = {
      "name" : request.name,
      "price" : request.price
    };
    var response = await http.post(Uri.parse("$baseUrl/insert_product.php"),
      body:body,
    );
    return response.body;
  }

  Future<String> updateProduct(CreateProductRequest request) async {
    var body = {
      "name" : request.name,
      "price" : request.price,
      "pro_id" : request.id
    };
    var response = await http.post(Uri.parse( "$baseUrl/update_product.php"),
      body: body,
    );
    return response.body;
  }

  Future<String> deleteProduct(String id) async {
    var body = {
      "pro_id" : id
    };
    var response = await http.post(Uri.parse("$baseUrl/delete_product.php"),body: body);
    return response.body;
  }
}