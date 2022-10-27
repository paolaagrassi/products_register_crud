// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewController on _HomeViewControllerBase, Store {
  late final _$productListAtom =
      Atom(name: '_HomeViewControllerBase.productList', context: context);

  @override
  List<ProductModel> get productList {
    _$productListAtom.reportRead();
    return super.productList;
  }

  @override
  set productList(List<ProductModel> value) {
    _$productListAtom.reportWrite(value, super.productList, () {
      super.productList = value;
    });
  }

  late final _$fetchAllProductsAsyncAction =
      AsyncAction('_HomeViewControllerBase.fetchAllProducts', context: context);

  @override
  Future<void> fetchAllProducts() {
    return _$fetchAllProductsAsyncAction.run(() => super.fetchAllProducts());
  }

  @override
  String toString() {
    return '''
productList: ${productList}
    ''';
  }
}
