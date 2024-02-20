import 'package:hive_flutter/hive_flutter.dart';

import '../model/product.dart';

class ProductsBoxHandler {
  late Box _box;

  Future<void> openBox(String listinId) async {
    _box = await Hive.openBox(listinId);
  }

  Future<void> closeBox() async {
    return _box.close();
  }

  Future<int> addProduct(Product product) async {
    return _box.add(product);
  }

  List<Product> getProducts() {
    return _box.values.map((e) => e as Product).toList();
  }

  Future<void> updateProduct(Product product) async {
    return product.save();
  }

  Future<void> removeProduct(Product product) async {
    return _box.delete(product.key);
  }
}
