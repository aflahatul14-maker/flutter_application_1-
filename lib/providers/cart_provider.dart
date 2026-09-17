import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/produk.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get totalItemsCount {
    var total = 0;
    _items.forEach((key, item) {
      total += item.quantity;
    });
    return total;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, item) {
      total += item.produk.price * item.quantity;
    });
    return total;
  }

  void addItem(Produk produk) {
    if (_items.containsKey(produk.id)) {
      _items.update(
        produk.id,
        (existing) => CartItem(
          produk: existing.produk,
          quantity: existing.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        produk.id,
        () => CartItem(produk: produk, quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String produkId) {
    if (!_items.containsKey(produkId)) return;

    if (_items[produkId]!.quantity > 1) {
      _items.update(
        produkId,
        (existing) => CartItem(
          produk: existing.produk,
          quantity: existing.quantity - 1,
        ),
      );
    } else {
      _items.remove(produkId);
    }
    notifyListeners();
  }
}