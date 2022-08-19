import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/model/product.dart';
import 'package:flutter_template/services/product_services.dart';
import 'package:flutter_template/utils/apis.dart';
import 'package:flutter_template/utils/sqldb.dart';

abstract class ProductRepository {
  GetAllProducts();
  GetProductById(int id);
}

class ProductViewModel with ChangeNotifier implements ProductRepository {
  List<ProductModel>? _resultData;
  List<ProductModel>? favoriteList;
  bool? _loading = false;
  SqlDb sqlDb = SqlDb();
  setLoading(bool type) {
    _loading = type;
    notifyListeners();
  }

  setResultMessage(List<ProductModel> result) {
    _resultData = result;
    notifyListeners();
  }

  setFavorites(List<ProductModel> result) {
    favoriteList = result;
    notifyListeners();
  }

  addToFavoriteList(ProductModel product, String note) async {
    try {
      int response = await sqlDb
          .insertData("INSERT INTO 'products' ('id','note') VALUES ('" + product.id.toString() + "','" + note + "')");
      await GetProductById(product.id);
      notifyListeners();
    } catch (e) {
      int response = await sqlDb.deleteData("DELETE FROM 'products' WHERE id = " + product.id.toString());
      print(response);
      favoriteList?.removeWhere((item) => item.id == product.id);
      notifyListeners();
    }
  }

  generateFavoriteList() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM 'products'");
    var result = await ProductServices.GetProductsById(endpoint: URL, list: response);
    if (result is List<ProductModel>) {
      print("bbbbbbbbbbbbbbb");
      setFavorites(result);
    }
    notifyListeners();
  }

  addNote(ProductModel product, String note) async {
    int response =
        await sqlDb.updateData("UPDATE 'products' SET 'note' = '" + note + "' WHERE id = " + product.id.toString());
    print(response);
    for (int i = 0; i < favoriteList!.length; i++) {
      if (favoriteList![i].id == product.id) {
        favoriteList![i].note = note;
        notifyListeners();
      }
    }
  }

  bool get Loading {
    return _loading!;
  }

  List<ProductModel> get ResultData {
    return _resultData!;
  }

  List<ProductModel> get getFavoriteList {
    return favoriteList!;
  }

  @override
  GetAllProducts() async {
    setLoading(true);

    var result = await ProductServices.GetAllProducts(endpoint: URL);
    if (result is List<ProductModel>) {
      setResultMessage(result);
    }
    setLoading(false);
  }

  @override
  GetProductById(int? id) async {
    setLoading(true);

    var result = await ProductServices.GetProductById(endpoint: URL, id: id.toString());
    if (result is ProductModel) {
      favoriteList?.add(result);
      notifyListeners();
    }
    print(favoriteList);
    setLoading(false);
  }
}
