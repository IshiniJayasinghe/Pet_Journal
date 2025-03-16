import 'package:flutter/material.dart';
import '../../constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = "Credit Card"; // ✅ Default payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: const Color.fromARGB(255, 249, 213, 54),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text("Credit Card / Debit Card"),
              trailing: Radio<String>(
                value: "Credit Card",
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text("Cash on Delivery"),
              trailing: Radio<String>(
                value: "Cash on Delivery",
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Payment Successful"),
                      content: Text("You have selected: $selectedPaymentMethod"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context); // ✅ Go back to cart screen
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kTextColor,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                "Confirm Payment",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
