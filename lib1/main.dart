import 'package:flutter/material.dart';

// import './pages/auth.dart';
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
  List<Map<String, String>> _products = [];

  void _addProduct(Map<String, String> product) {
    setState(() => _products.add(product));
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
      // home: Auth(),
      routes: {
        '/': (BuildContext context) =>
            Products(_products, _addProduct, _deleteProduct),
        '/admin': (BuildContext context) => ProductsAdmin(),
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
            builder: (BuildContext context) =>
                Product(_products[index]['title'], _products[index]['image']),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              Products(_products, _addProduct, _deleteProduct),
        );
      },
    );
  }
}
