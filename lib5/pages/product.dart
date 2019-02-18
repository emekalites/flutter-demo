import 'package:flutter/material.dart';
import 'dart:async';
import 'package:html_unescape/html_unescape.dart';
import 'package:scoped_model/scoped_model.dart';

import '../ui_elements/title_default.dart';
import '../scoped_models/main.dart';

var unescape = new HtmlUnescape();
var naira = unescape.convert("&#8358;");

class ProductPage extends StatelessWidget {
  final int index;

  ProductPage(this.index);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('back button pressed');
        Navigator.pop(context, false);
        return Future.value(false); // allows or dissallows popping back
      },
      child: ScopedModelDescendant<MainModel>( builder: (BuildContext context, Widget child, MainModel model) {
        final product = model.allProducts[index];
        return Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(product.image),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TitleDefault(product.title),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Union Square, San Fransisco',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      '|',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Text(
                    naira + product.price.toString(),
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
      },)
    );
  }
}
