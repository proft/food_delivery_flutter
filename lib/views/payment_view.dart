import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:food_delivery_flutter/components/my_button.dart';
import 'package:food_delivery_flutter/views/delivery_progress_view.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void handlePay() {
    if (formState.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Confirm payment "),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text("Card number: $cardNumber"),
                      Text("Expiry: $expiryDate"),
                      Text("Card holder: $cardHolderName"),
                      Text("CVV: $cvvCode"),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DeliveryProgressView(),),);
                      },
                      child: const Text("Yes")),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Checkout"),
      ),
      body: Column(
        children: [
          // Credit card
          CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (p0) {}),

          CreditCardForm(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: (data) {
                setState(() {
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cardHolderName = data.cardHolderName;
                  cvvCode = data.cvvCode;
                });
              },
              formKey: formState),

          const Spacer(),

          MyButton(onTap: handlePay, text: "Pay now"),
          const SizedBox(height: 25)
        ],
      ),
    );
  }
}
