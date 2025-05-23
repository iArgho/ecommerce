import 'dart:convert';

import 'package:eCommerce/data/model/category_model.dart';
import 'package:eCommerce/data/model/product_model.dart';
import 'package:eCommerce/utils/url.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(Urls.products));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(Urls.categories));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((name) => Category.fromJson(name)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
