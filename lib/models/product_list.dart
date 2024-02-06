import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

import '../data/dummy_data.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;
  
  List<Product> get items => [..._items];
  
  List<Product> get favoriteItens => _items.where((prod) => prod.isFavorite).toList();
  
  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); // Chama o notificador sempre que houver uma mudança na lista
  }
}

// Versão global

/*
 bool _showFavoriteOnly = false;
  List<Product> _items = dummyProducts;
  List<Product> get items {
    if(_showFavoriteOnly)
      return _items.where((prod) => prod.isFavorite).toList();
    return [..._items];
  } // Retorna um clone dos itens

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners(); 
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners(); 
  }
  */