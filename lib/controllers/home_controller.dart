import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:products_register_crud/models/product_model.dart';

part 'home_controller.g.dart';

class HomeViewController = _HomeViewControllerBase with _$HomeViewController;

abstract class _HomeViewControllerBase with Store {
  @observable
  List<ProductModel> productList = <ProductModel>[];

  @action
  Future<void> fetchAllProducts() async {
    getAllProducts().then((products) {
      if (products != null) {
        productList = products;
      }
    });
  }

  late final Dio dio;

  _HomeViewControllerBase() {
    final httpLogger = PrettyDioLogger();
    dio = Dio()..interceptors.add(httpLogger);
  }

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
    final response =
        await dio.delete('http://192.168.1.7:8080/api/products/$id');

    if (response.statusCode == 200) {
      log("Deleted");
    } else {
      throw "Sorry! Unable to delete this post.";
    }
  }
}
