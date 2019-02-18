import '../models/product.dart';
import './connected_products.dart';

class ProductsModel extends ConnectedProducts {
  bool _showFavorites = false;

  List<Product> get allProducts => List.from(products); // immutability
  int get selectProductIndex => selProductIndex;
  Product get selectedProduct =>
      (selectProductIndex == null) ? null : products[selectProductIndex];
  bool get showFavorites => _showFavorites;
  List<Product> get displayedProducts {
    if (_showFavorites) {
      return List.from(products.where((Product product) => product.isFavorite));
    }
    return List.from(products);
  }

  void updateProduct(String title, String description, String image, double price) {
    final Product updatedProduct = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );
    products[selectProductIndex] = updatedProduct;
    selProductIndex = null;
  }

  void deleteProduct() {
    products.removeAt(selectProductIndex);
    selProductIndex = null;
  }

  void selectProduct(int index) {
    selProductIndex = index;
  }

  void toggleFavorite() {
    final bool isCurrentlyFavorite = products[selectProductIndex].isFavorite;
    final Product updatedProduct = Product(
      title: selectedProduct.title,
      description: selectedProduct.description,
      image: selectedProduct.image,
      price: selectedProduct.price,
      isFavorite: !isCurrentlyFavorite,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );
    products[selectProductIndex] = updatedProduct;
    selProductIndex = null;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
