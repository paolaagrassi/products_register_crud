import 'package:dio/dio.dart';
import 'package:products_register_crud/models/product_model.dart';

class HomeViewController {
  late final Dio dio;

  Future<List<ProductModel>?> getAllProducts() async {
    try {
      final response = await dio.get('http://192.168.1.7:8080/api/products');
      final rawList = response.data as List;

      return rawList
          .map((rawProduct) => ProductModel.fromMap(rawProduct))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future deleteProduct({required String id}) async {
    try {
      final response =
          await dio.delete('http://192.168.1.7:8080/api/products/$id');

      final rawList = response.data as List;

      return rawList
          .map((rawProduct) => ProductModel.fromMap(rawProduct))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
