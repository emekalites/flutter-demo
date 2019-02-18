import 'package:flutter/material.dart';

import '../widgets/products/products.dart';
import '../drawer.dart';
import '../models/product.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> _products;

  ProductsPage(this._products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
      ),
      body: Products(_products),
    );
  }
}
