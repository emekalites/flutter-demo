import '../models/user.dart';
import './connected_products.dart';

class UserModel extends ConnectedProducts {
  void login(String email, String password) {
    authedUser = User(id: '20', email: email, password: password);
  }
}
