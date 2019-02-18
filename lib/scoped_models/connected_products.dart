import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http; // named inport
import 'dart:convert';
import 'dart:async';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  String _selProductId;
  User _authedUser;
  bool _isLoading = false;
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts => List.from(_products); // immutability

  String get selectProductId => _selProductId;

  Product get selectedProduct => (selectProductId == null)
      ? null
      : _products.firstWhere((Product product) {
          return product.id == _selProductId;
        });

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  bool get showFavorites => _showFavorites;

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return List.from(
          _products.where((Product product) => product.isFavorite));
    }
    return List.from(_products);
  }

  Future<dynamic> addProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://cdn1.medicalnewstoday.com/content/images/articles/321/321618/dark-chocolate-and-cocoa-beans-on-a-table.jpg',
      'price': price,
      'userEmail': _authedUser.email,
      'userId': _authedUser.id,
    };
    return http
        .post('https://flutter-demo-f6637.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
        id: responseData['name'],
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: _authedUser.email,
        userId: _authedUser.id,
      );

      _isLoading = false;
      _products.add(newProduct);
      notifyListeners();
    }).catchError(() {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<dynamic> updateProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image':
          'https://cdn1.medicalnewstoday.com/content/images/articles/321/321618/dark-chocolate-and-cocoa-beans-on-a-table.jpg',
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId,
    };
    return http
        .put(
            'https://flutter-demo-f6637.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updateData))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: responseData['title'],
        description: responseData['description'],
        image: responseData['image'],
        price: responseData['price'],
        userEmail: responseData['userEmail'],
        userId: responseData['userId'],
      );
      _isLoading = false;
      _products[selectedProductIndex] = updatedProduct;
      notifyListeners();
    }).catchError(() {
      _isLoading = false;
      notifyListeners();
    });
  }

  void deleteProduct() {
    _isLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();
    http
        .delete(
            'https://flutter-demo-f6637.firebaseio.com/products/${deletedProductId}.json')
        .then((_) {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<dynamic> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://flutter-demo-f6637.firebaseio.com/products.json')
        .then((http.Response response) {
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productID, dynamic productData) {
        final Product product = Product(
          id: productID,
          title: productData['title'],
          description: productData['description'],
          image: productData['image'],
          price: productData['price'],
          userEmail: productData['userEmail'],
          userId: productData['userId'],
        );
        fetchedProductList.add(product);
      });
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
      _selProductId = null;
    }).catchError(() {
      _isLoading = false;
      notifyListeners();
    });
  }

  void selectProduct(String productId) {
    _selProductId = productId;
    notifyListeners();
  }

  void toggleFavorite() {
    final bool isCurrentlyFavorite = _products[selectedProductIndex].isFavorite;
    final Product updatedProduct = Product(
      id: selectedProduct.id,
      title: selectedProduct.title,
      description: selectedProduct.description,
      image: selectedProduct.image,
      price: selectedProduct.price,
      isFavorite: !isCurrentlyFavorite,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {
  
  Future<Map<String, dynamic>> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final http.Response response = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyAvQTLRsg3Bpu-TJ8Mh3hZh350nlHVHbV0',
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong!';

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Login successful!';
      _authedUser = User(id: '20', email: email, password: password);
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'Email was not found';
    }else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'Password is invalid';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  Future<Map<String, dynamic>> signup(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final http.Response response = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyAvQTLRsg3Bpu-TJ8Mh3hZh350nlHVHbV0',
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong!';

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Registration completed';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'Email already exists';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }
}

mixin UtilityModel on ConnectedProductsModel {
  //getter
  bool get isLoading {
    return _isLoading;
  }
}
