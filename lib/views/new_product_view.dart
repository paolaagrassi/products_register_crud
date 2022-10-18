import 'package:flutter/material.dart';
import 'package:products_register_crud/views/widgets/widgets.dart';

class NewProductView extends StatefulWidget {
  const NewProductView({Key? key}) : super(key: key);

  @override
  State<NewProductView> createState() => _NewProductViewState();
}

class _NewProductViewState extends State<NewProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Produtos'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: const [
            BuildTextField(
              labelText: Text('Produto'),
            ),
            Divider(),
            BuildTextField(
              labelText: Text('Preço'),
            ),
            Divider(),
            BuildTextField(
              labelText: Text('Descrição'),
            ),
            Spacer(),
            BuildButton(
              buttonTitle: 'Registrar',
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
