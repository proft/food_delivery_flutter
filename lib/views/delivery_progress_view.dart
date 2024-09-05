import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/models/restaurant.dart';
import 'package:food_delivery_flutter/services/firestore_service.dart';
import 'package:food_delivery_flutter/views/my_receipt.dart';
import 'package:provider/provider.dart';

class DeliveryProgressView extends StatefulWidget {
  const DeliveryProgressView({super.key});

  @override
  State<DeliveryProgressView> createState() => _DeliveryProgressViewState();
}

class _DeliveryProgressViewState extends State<DeliveryProgressView> {
  FirestoreService db = FirestoreService();

  @override
  void initState() {
    super.initState();
    String receipt = context.read<Restaurant>().displayCartReceipt();
    db.saveOrder(receipt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery in progress ..."),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: const Column(
        children: [MyReceipt()],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ),

          // Driver
          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Elon Musk",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              Text("Driver",
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary))
            ],
          ),

          const Spacer(),

          Row(children: [
            // Message

            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.message),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(width: 10),

            // Call

            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call),
                color: Colors.green,
              ),
            )

          ],)


        ],
      ),
    );
  }
}
