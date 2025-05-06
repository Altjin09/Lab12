import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/users.dart';

class GlobalProvider extends ChangeNotifier {
  UserModel? currentUser;
  List<ProductModel> products = [];
  List<ProductModel> cartItems = [];
  int currentIdx = 0;
  List<ProductModel> favorites = [];
  bool get isLoggedIn => currentUser != null;

  void toggleFavorite(ProductModel product) {
    if (favorites.contains(product)) {
      favorites.remove(product);
    } else {
      favorites.add(product);
    }
    notifyListeners();
  }

  void setProducts(List<ProductModel> data) {
    products = data;
    notifyListeners();
  }

  void addCartItems(ProductModel item) {
    if (cartItems.contains(item)) {
      cartItems.remove(item);
    } else {
      cartItems.add(item);
    }
    notifyListeners();
  }

  void changeCurrentIdx(int idx) {
    currentIdx = idx;
    notifyListeners();
  }

  void increaseQauntity(ProductModel product) {
    product.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(ProductModel product) {
    if (product.quantity > 1) {
      product.quantity--;
    } else {
      cartItems.remove(product);
    }
    notifyListeners();
  }

  void setUser(UserModel user) {
    currentUser = user;
    notifyListeners();
  }
}
