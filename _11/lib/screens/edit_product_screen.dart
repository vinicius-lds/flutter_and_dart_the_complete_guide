import 'package:_11/providers/product.dart';
import 'package:_11/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Product _product = Product(
    id: "",
    title: "",
    description: "",
    price: 0,
    imageUrl: "",
  );

  Product _productInitialValues = Product(
    id: "",
    title: "",
    description: "",
    price: 0,
    imageUrl: "",
  );

  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String?;
      if (productId != null) {
        _product = Provider.of<Products>(context).findById(productId);
        _productInitialValues = Product(
          id: _product.id,
          title: _product.title,
          description: _product.description,
          price: _product.price,
          imageUrl: _product.imageUrl,
        );
        _imageUrlController.text = _productInitialValues.imageUrl;
      }
      _isInit = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    setState(() => _isLoading = true);
    try {
      if (_product.id.isEmpty) {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_product);
      } else {
        await Provider.of<Products>(context, listen: false)
            .updateProduct(_product.id, _product);
      }
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An error occurred!'),
          content: const Text('Something went wrong.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Okay'),
            )
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product'), actions: [
        IconButton(
          onPressed: _saveForm,
          icon: const Icon(Icons.save),
        )
      ]),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _productInitialValues.title,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                        onSaved: (value) => _product = Product(
                          id: _product.id,
                          title: value ?? "",
                          description: _product.description,
                          price: _product.price,
                          imageUrl: _product.imageUrl,
                          isFavorite: _product.isFavorite,
                        ),
                      ),
                      TextFormField(
                        initialValue: _productInitialValues.price.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Price',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Number is not valid';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Number should be greater than zero';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode),
                        onSaved: (value) => _product = Product(
                          id: _product.id,
                          title: _product.title,
                          description: _product.description,
                          price: double.parse(value ?? "0"),
                          imageUrl: _product.imageUrl,
                          isFavorite: _product.isFavorite,
                        ),
                      ),
                      TextFormField(
                        initialValue: _productInitialValues.description,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          if (value.length < 11) {
                            return 'Min length is 11';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) => _product = Product(
                          id: _product.id,
                          title: _product.title,
                          description: value ?? "",
                          price: _product.price,
                          imageUrl: _product.imageUrl,
                          isFavorite: _product.isFavorite,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            margin: const EdgeInsets.only(top: 8, right: 11),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.green),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? const Text('Enter a URL')
                                : FittedBox(
                                    child:
                                        Image.network(_imageUrlController.text),
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Image URL',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                if (!value.startsWith("http") &&
                                    !value.startsWith("https")) {
                                  return 'Url is invalid';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.url,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onEditingComplete: () => setState(() {}),
                              onFieldSubmitted: (value) => _saveForm(),
                              onSaved: (value) => _product = Product(
                                id: _product.id,
                                title: _product.title,
                                description: _product.description,
                                price: _product.price,
                                imageUrl: value ?? "",
                                isFavorite: _product.isFavorite,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
