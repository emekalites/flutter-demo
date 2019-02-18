import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProducts extends Model {
  List<Product> products = [];
  int selProductIndex;
  User authedUser;

  void addProduct(String title, String description, String image, double price) {
    print(authedUser.email);
    final Product newProduct = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userEmail: authedUser.email,
      userId: authedUser.id,
    );
    products.add(newProduct);
    selProductIndex = null;
  }
}