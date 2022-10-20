import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products_register_crud/controllers/controllers.dart';
import 'package:products_register_crud/models/product_model.dart';
import 'package:validatorless/validatorless.dart';
import './widgets/widgets.dart';

class NewProductView extends StatefulWidget {
  const NewProductView({this.productModel, Key? key}) : super(key: key);
  final ProductModel? productModel;
  @override
  State<NewProductView> createState() => _NewProductViewState();
}

class _NewProductViewState extends State<NewProductView> {
  final _controller = NewProductController();

  final _formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  bool isLoading = false;

  @override
  void initState() {
    _controller.nameTextEditingController.text =
        widget.productModel?.name ?? '';
    _controller.priceTextEditingController.text =
        UtilBrasilFields.obterReal(widget.productModel?.price ?? 0.0);
    _controller.descriptionTextEditingController.text =
        widget.productModel?.description ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productModel == null
            ? 'Registrar Produto'
            : 'Editar Produto'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      onChanged: () {
                        final isCurrentFormValid =
                            _formKey.currentState!.validate();

                        if (isFormValid != isCurrentFormValid) {
                          setState(() {
                            isFormValid = isCurrentFormValid;
                          });
                        }
                      },
                      child: Column(
                        children: [
                          BuildTextField(
                            labelText: 'Produto',
                            controller: _controller.nameTextEditingController,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required(
                                    'Campo não pode ser nulo'),
                              ],
                            ),
                          ),
                          const Divider(),
                          BuildTextField(
                            labelText: 'Preço',
                            controller: _controller.priceTextEditingController,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required(
                                    'Campo não pode ser nulo'),
                              ],
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CentavosInputFormatter(),
                            ],
                          ),
                          const Divider(),
                          BuildTextField(
                            labelText: 'Descrição',
                            controller:
                                _controller.descriptionTextEditingController,
                          ),
                          const Spacer(),
                          BuildButton(
                            buttonTitle: (widget.productModel == null
                                ? 'Registrar'
                                : 'Salvar'),
                            width: double.infinity,
                            height: 50,
                            onPressed: isFormValid
                                ? () {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    final productControllerName = _controller
                                        .nameTextEditingController.text;
                                    final productControllerPrice =
                                        UtilBrasilFields
                                            .converterMoedaParaDouble(
                                      _controller
                                          .priceTextEditingController.text,
                                    );
                                    final productControllerDescription =
                                        _controller
                                            .descriptionTextEditingController
                                            .text;

                                    final newProductFormIsEmpty =
                                        (widget.productModel == null);

                                    newProductFormIsEmpty
                                        ? _controller.addProduct(
                                            name: productControllerName,
                                            price: productControllerPrice,
                                            description:
                                                productControllerDescription,
                                          )
                                        : _controller.updateProduct(
                                            id: widget.productModel!.id,
                                            name: productControllerName,
                                            price: productControllerPrice,
                                            description:
                                                productControllerDescription,
                                          );

                                    Navigator.of(context).pop();
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: const Color.fromARGB(220, 255, 255, 255),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
