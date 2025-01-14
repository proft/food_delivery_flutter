import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/components/my_button.dart';
import 'package:food_delivery_flutter/components/my_cart_tile.dart';
import 'package:food_delivery_flutter/models/restaurant.dart';
import 'package:food_delivery_flutter/views/payment_view.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
      final userCart = restaurant.cart;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                                "Are you sure you want to clear the cart"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    restaurant.clearCart();
                                  },
                                  child: const Text("Yes")),
                            ],
                          ));
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Column(
          children: [
            // carts
            Expanded(
              child: Column(
                children: [
                  userCart.isEmpty
                      ? const Expanded(
                          child: Center(child: Text("Cart is empty")))
                      : Expanded(
                          child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                final cartTime = userCart[index];

                                return MyCartTile(cartItem: cartTime);
                              }))
                ],
              ),
            ),
            // pay button

            MyButton(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentView())), text: "Go to checkout"),

            const SizedBox(height: 25)
          ],
        ),
      );
    });
  }
}
