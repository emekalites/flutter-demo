import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../drawer.dart';
import '../scoped_models/main.dart';

class ProductsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
           return IconButton(
            icon: Icon(model.showFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              model.toggleDisplayMode();
            },
          );
          },),
        ],
      ),
      body: Products(),
    );
  }
}
