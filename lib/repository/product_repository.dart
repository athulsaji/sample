import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRepository {
  Future<List<Product>> fetchUser() async{
    final response = await http.get(Uri.parse("https://api.github.com/users/athulsaji"));

    if(response.statusCode ==200){
      List data =jsonDecode(response.body);
      return data.map((e)=>Product.fromJson(e)).toList();

    }
    else{
      throw Exception('Failed to load product');
    }
  }
}