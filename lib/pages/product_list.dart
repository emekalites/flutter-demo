import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';
import '../scoped_models/main.dart';

var unescape = new HtmlUnescape();
var naira = unescape.convert("&#8358;");

class ProductList extends StatefulWidget {
  final MainModel model;
  ProductList(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ProductList();
  }
}

class _ProductList extends State<ProductList> {
  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(model.allProducts[index].title),
            onDismissed: (DismissDirection direction) {
              model.selectProduct(model.allProducts[index].id);
              model.deleteProduct();
            },
            background: Container(color: Colors.red),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(model.allProducts[index].image),
                  ),
                  title: Text(model.allProducts[index].title),
                  subtitle:
                      Text(naira + model.allProducts[index].price.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      model.selectProduct(model.allProducts[index].id);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ProductEdit();
                          },
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: model.allProducts.length,
      );
    });
  }
}
