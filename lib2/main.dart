import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './pages/auth.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './pages/product.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() => _products.add(product));
  }

  void _updateProduct(int index, Map<String, dynamic> product) {
    setState(() => _products[index] = product);
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
      ),
      routes: {
        '/': (BuildContext context) => Auth(),
        '/products': (BuildContext context) => ProductsPage(_products),
        '/admin': (BuildContext context) =>
            ProductsAdmin(_addProduct, _updateProduct, _deleteProduct, _products),
        // '/product' : (BuildContext context) => Product(products[index]['title'], products[index]['image'])
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathEl = settings.name.split('/');
        print(pathEl);
        if (pathEl[0] != '') {
          return null;
        }
        if (pathEl[1] == 'product') {
          final int index = int.parse(pathEl[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => Product(
                  _products[index]['title'],
                  _products[index]['image'],
                  _products[index]['price'],
                  _products[index]['description'],
                ),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => ProductsPage(_products),
        );
      },
    );
  }
}
