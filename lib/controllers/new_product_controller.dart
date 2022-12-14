import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'new_product_controller.g.dart';

class NewProductController = _NewProductControllerBase
    with _$NewProductController;

abstract class _NewProductControllerBase with Store {
  late final Dio dio;

  @observable
  bool isLoading = false;

  @action
  loadIncrement() {
    isLoading = true;
  }

  late TextEditingController nameTextEditingController =
      TextEditingController();
  late TextEditingController priceTextEditingController =
      TextEditingController();
  late TextEditingController descriptionTextEditingController =
      TextEditingController();

  _NewProductControllerBase() {
    final httpLoger = PrettyDioLogger();
    dio = Dio()..interceptors.add(httpLoger);
  }

  Future<bool> addProduct({
    required String name,
    required double price,
    required String description,
  }) async {
    await dio.post('http://192.168.1.7:8080/api/products', data: {
      'name': name,
      'price': price,
      'description': description,
    });
    return false;
  }

  Future<bool> updateProduct({
    required String id,
    required String name,
    required double price,
    required String description,
  }) async {
    await dio.put('http://192.168.1.7:8080/api/products/$id', data: {
      'name': name,
      'price': price,
      'description': description,
    });
    return false;
  }
}
