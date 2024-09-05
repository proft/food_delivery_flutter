import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_flutter/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Deliver now",
              style: TextStyle(color: Theme
                  .of(context)
                  .colorScheme
                  .primary)),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                Consumer<Restaurant>(
                    builder: (context, restaurant, child) =>
                        Text(restaurant.deliveryAddress,
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontWeight: FontWeight.bold))),
                Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .inversePrimary,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void openLocationSearchBox(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text("Your location"),
              content: TextField(
                controller: textController,
                decoration: const InputDecoration(hintText: "Search address"),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    textController.clear();
                  },
                  child: const Text("Cancel"),
                ),
                MaterialButton(
                  onPressed: () {
                    String newAddress = textController.text;
                    context.read<Restaurant>().updateDeliveryAddress(newAddress);
                    Navigator.pop(context);
                    textController.clear();
                  },
                  child: const Text("Save"),
                )
              ],
            ));
  }
}
