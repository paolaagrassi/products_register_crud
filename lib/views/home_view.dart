import 'package:flutter/material.dart';
import 'package:products_register_crud/controllers/controllers.dart';
import 'package:products_register_crud/models/product_model.dart';
import 'package:products_register_crud/views/new_product_view.dart';
import 'package:products_register_crud/views/widgets/product_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ProductModel> productList = <ProductModel>[];

  final _controller = HomeViewController();

  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  Future<void> fetchAllProducts() async {
    _controller.getAllProducts().then((products) {
      if (products != null) {
        setState(() {
          productList = products;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        splashColor: Colors.black,
        icon: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewProductView(),
            ),
          );
          fetchAllProducts();
        },
      ),
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, count) {
          final productModel = productList[count];

          return ProductCard(
            cardTitle: productModel.name,
            cardPrice: productModel.price,
            productModel: productModel,
            onDelete: () async {
              await _controller.deleteProduct(id: productModel.id);
              setState(() {
                fetchAllProducts();
              });
            },
            onUpdate: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewProductView(
                    productModel: productModel,
                  ),
                ),
              );

              setState(() {
                fetchAllProducts();
              });
            },
          );
        },
      ),
    );
  }
}
