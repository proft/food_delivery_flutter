import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/models/cart.dart';
import 'package:food_delivery_flutter/models/food.dart';
import 'package:intl/intl.dart';

class Restaurant extends ChangeNotifier {
  List<Food> get menu => _menu;

  List<CartItem> get cart => _cart;

  final List<CartItem> _cart = [];

  String _deliveryAddress = '77 Hollywood Blv';

  String get deliveryAddress => _deliveryAddress;

  final List<Food> _menu = [
    Food(
        name: "Classic cheeseburger",
        description:
            "This burger starts with a toasted sesame seed bun, wrapped around a perfectly seasoned, mouth-watering hamburger",
        imagePath: "lib/images/burgers/burgers1.jpg",
        price: 2.99,
        category: FoodCategory.burgers,
        addons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avo", price: 0.99)
        ]),
    Food(
        name: "Caesar Salad",
        description: "Crisp romaine lettuce",
        imagePath: "lib/images/salads/salads1.jpeg",
        price: 6.99,
        category: FoodCategory.salads,
        addons: [
          Addon(name: "Grilled Chicken", price: 0.99),
          Addon(name: "Anchovies", price: 1.39),
          Addon(name: "Extra Parmesan", price: 1.99)
        ]),
    Food(
        name: "Apple Pie",
        description: "Classical apple pie",
        imagePath: "lib/images/desserts/desserts1.jpg",
        price: 3.45,
        category: FoodCategory.desserts,
        addons: [
          Addon(name: "Caramel Sauce", price: 0.99),
          Addon(name: "Vanilla Ice Cream", price: 1.59),
          Addon(name: "Cinnamon Spice", price: 1.79)
        ]),
    Food(
        name: "Lemonade",
        description: "Refreshing lemonade made with real lemons",
        imagePath: "lib/images/drinks/drink1.jpg",
        price: 2.99,
        category: FoodCategory.drinks,
        addons: [
          Addon(name: "Strawberry flavor", price: 0.99),
          Addon(name: "Mint Leaves", price: 1.99),
          Addon(name: "Ginger Zest", price: 0.99)
        ])
  ];

  void addToCart(Food food, List<Addon> selectedAddons) {
    CartItem? carItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;
      bool isSameAddons = ListEquality().equals(item.selectedAddons, selectedAddons);
      return isSameFood && isSameAddons;
    });

    if (carItem != null) {
      carItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    int index = _cart.indexOf(cartItem);
    if (index != -1) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity--;
      } else {
        _cart.removeAt(index);
      }
    }

    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt.");
    receipt.writeln();

    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("--------");

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln("   Addons: ${_formatAddons(cartItem.selectedAddons)}");
        receipt.writeln();
      }
    }

    receipt.writeln();

    receipt.writeln("Total items: ${getTotalItemCount()}");
    receipt.writeln("Total price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();

    receipt.writeln("Delivering to: $deliveryAddress");

    return receipt.toString();
  }

  String _formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }

  String _formatAddons(List<Addon> addons) {
    return addons.map((e) => "${e.name} (${_formatPrice(e.price)})").join(", ");
  }

  // Delivery

  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }
}
