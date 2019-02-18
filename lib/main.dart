import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './models/product.dart';
import './scoped_models/main.dart';

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
  @override
  Widget build(BuildContext context) {
    final MainModel model = new MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
        ),
        routes: {
          '/': (BuildContext context) => Auth(),
          '/products': (BuildContext context) => ProductsPage(model),
          '/admin': (BuildContext context) => ProductsAdmin(model),
          // '/product' : (BuildContext context) => Product(products[index]['title'], products[index]['image'])
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathEl = settings.name.split('/');
          print(pathEl);
          if (pathEl[0] != '') {
            return null;
          }
          if (pathEl[1] == 'product') {
            final String productId = pathEl[2];
            final Product product = model.allProducts.firstWhere((Product product) {
return product.id == productId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(product),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage(model),
          );
        },
      ),
    );
  }
}
