import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_flutter/components/my_button.dart';
import 'package:food_delivery_flutter/models/food.dart';
import 'package:food_delivery_flutter/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodView extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};

  FoodView({super.key, required this.food}) {
    for (Addon addon in food.addons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    Navigator.pop(context);

    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.addons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(widget.food.imagePath),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.food.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Text('\$${widget.food.price}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary)),
                    const SizedBox(height: 10),
                    Text(widget.food.description),
                    const SizedBox(height: 10),
                    Divider(color: Theme.of(context).colorScheme.secondary),
                    const SizedBox(height: 10),
                    Text("Addons",
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary),
                          borderRadius: BorderRadius.circular(8)),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: widget.food.addons.length,
                          itemBuilder: (context, index) {
                            Addon addon = widget.food.addons[index];
                            return CheckboxListTile(
                                title: Text(addon.name),
                                subtitle: Text('\$${addon.price}',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                value: widget.selectedAddons[addon],
                                onChanged: (bool? value) {
                                  setState(() {
                                    widget.selectedAddons[addon] = value!;
                                  });
                                });
                          }),
                    )
                  ],
                ),
              ),
              MyButton(
                onTap: () => addToCart(widget.food, widget.selectedAddons),
                text: "Add to card",
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
      SafeArea(
        child: Opacity(
          opacity: 0.6,
          child: Container(
            margin: const EdgeInsets.only(left: 25),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      )
    ]);
  }
}
