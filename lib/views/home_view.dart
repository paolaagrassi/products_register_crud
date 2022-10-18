import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:products_register_crud/models/product_model.dart';
import 'package:products_register_crud/views/new_product_view.dart';
import 'package:products_register_crud/views/widgets/custom_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ProductModel> productList = <ProductModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        splashColor: Colors.black,
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewProductView(),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ExpansionTileCard(
              title: Text('Exemplo ${index.toString()}'),
              subtitle: const Text('R\$ '),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      BuildButton(
                        buttonTitle: 'Editar',
                        width: 150,
                      ),
                      BuildButton(
                        buttonTitle: 'Deletar',
                        width: 150,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
