import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:telentproapp/models/add_product_request.dart';
import 'package:telentproapp/models/get_all_prouct_response.dart';

class UserRepository {
  static const String baseUrl =
      "https://techtunes999.000webhostapp.com";

  Future<List<Product>> getAllProduct() async {
    var response = await http.get(Uri.parse("$baseUrl/product_retrive.php"));
    GetAllProduct userList = json.decode(response.body);
    List<Product> product = userList.data!.map((pro) => Product.fromMap(pro as Map<String,dynamic>)).toList();
    return product;
  }

  Future<String> createProduct(CreateProductRequest request) async {
    var response = await http.post(Uri.parse("$baseUrl/insert_product.php"),
      body:request.toMap(),
    );
    var result = jsonDecode(response.body);
    return result;
  }

  Future<bool> updateProduct(CreateProductRequest request) async {
    var response = await http.put(Uri.parse( "$baseUrl/update_product.php"),
      body: request.toMap(),
    );
    var result = jsonDecode(response.body);
    return result;
  }

  Future<bool> deleteUser(String id) async {
    var response = await http.post(Uri.parse("$baseUrl/delete_product.php"),body: {
      "pro_id" : id
    });
    var result = jsonDecode(response.body);
    return result;
  }
}