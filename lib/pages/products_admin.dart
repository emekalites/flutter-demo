import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';
import '../drawer.dart';
import '../scoped_models/main.dart';

class ProductsAdmin extends StatelessWidget {
  final MainModel model;
  ProductsAdmin(this.model);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Products',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductEdit(),
            ProductList(model),
          ],
        ),
      ),
    );
  }
}
