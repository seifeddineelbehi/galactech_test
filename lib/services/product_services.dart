import 'package:flutter_template/model/product.dart';
import 'package:flutter_template/utils/apis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ProductServices {
  static Future<Object?> GetAllProducts({
    required String endpoint,
  }) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
    };
    Uri uri = Uri.http(endpoint, GETPRODUCT);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      if (response.statusCode == 200) {
        Map<String, dynamic> productFromServer = json.decode(response.body);
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        List<ProductModel> data = [];
        productFromServer["products"].forEach((product) {
          ProductModel productModel = ProductModel(
              id: product["id"],
              image: product["images"][0],
              description: product["description"],
              title: product["title"]);
          data.add(productModel);
        });
        return data;
      } else {
        return "Failure";
      }
      // }
    } catch (exception) {
      return "Failure";
    }
  }

  static Future<Object?> GetProductsById({
    required String endpoint,
    required List<Map> list,
  }) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
    };
    List<ProductModel> products = [];

    for (int i = 0; i < list.length; i++) {
      print("cccccccccccccccccccc");
      print(list[i]["id"]);

      Uri uri = Uri.parse('https://' + endpoint + GETPRODUCT + list[i]["id"]);

      try {
        var response = await http.get(uri, headers: requestHeaders);
        if (response.statusCode == 200) {
          Map<String, dynamic> productFromServer = json.decode(response.body);
          ProductModel productModel = ProductModel(
            id: productFromServer["id"],
            image: productFromServer["images"][0],
            description: productFromServer["description"],
            title: productFromServer["title"],
            note: list[i]["note"],
          );
          products.add(productModel);
        } else {
          return "Failure";
        }
        // }
      } catch (exception) {
        return "Failure";
      }
    }
    print(products);
    return products;
  }

  static Future<Object?> GetProductById({
    required String endpoint,
    required String id,
  }) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
    };

    print("cccccccccccccccccccc");

    Uri uri = Uri.parse('https://' + endpoint + GETPRODUCT + id);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      if (response.statusCode == 200) {
        Map<String, dynamic> productFromServer = json.decode(response.body);
        ProductModel productModel = ProductModel(
            id: productFromServer["id"],
            image: productFromServer["images"][0],
            description: productFromServer["description"],
            title: productFromServer["title"],
            note: "");

        return productModel;
      } else {
        return "Failure";
      }
      // }
    } catch (exception) {
      return "Failure";
    }
  }
}
