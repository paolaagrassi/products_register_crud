import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NewProductController {
  late final Dio dio;

  NewProductController() {
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
