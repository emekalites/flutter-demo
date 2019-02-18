import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct;

  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () {
        addProduct({'title': 'Sweets', 'image': 'assets/food.jpg',});
      },
      child: Text('Add Product'),
    );
  }
}
