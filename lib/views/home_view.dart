import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:products_register_crud/controllers/controllers.dart';
import 'package:products_register_crud/views/new_product_view.dart';
import 'package:products_register_crud/views/widgets/product_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = HomeViewController();

  final _addController = NewProductController();

  @override
  void initState() {
    _controller.fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: IconButton(
          splashColor: Colors.black,
          icon: const Icon(
            Icons.add,
            color: Colors.blueGrey,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewProductView(),
              ),
            );
            _controller.fetchAllProducts();
          },
        ),
        appBar: AppBar(
          title: const Text('Lista de Produtos'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Observer(builder: (context) {
          return _controller.productList.isEmpty
              ? buildEmptyLayout()
              : ListView.builder(
                  itemCount: _controller.productList.length,
                  itemBuilder: (context, count) {
                    final productModel = _controller.productList[count];

                    return ProductCard(
                      cardTitle: productModel.name,
                      cardPrice: productModel.price,
                      productModel: productModel,
                      cardDescription: productModel.description,
                      onDelete: () async {
                        await _controller.deleteProduct(id: productModel.id);

                        _controller.fetchAllProducts();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Produto "${productModel.name}" foi removido com sucesso!',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            action: SnackBarAction(
                              label: 'Desfazer',
                              textColor: Colors.blue,
                              onPressed: () {
                                _addController
                                    .addProduct(
                                        name: productModel.name,
                                        price: productModel.price,
                                        description: productModel.description)
                                    .then((value) {
                                  _controller.fetchAllProducts();
                                });
                              },
                            ),
                            duration: const Duration(seconds: 5),
                          ),
                        );
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

                        _controller.fetchAllProducts();
                      },
                    );
                  },
                );
        }));
  }

  Widget buildEmptyLayout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty_list.png',
            width: 200,
          ),
          const Padding(padding: EdgeInsets.all(30)),
          const Text(
            'A lista de produtos está vazia.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
