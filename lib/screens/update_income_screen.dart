import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../models/finance_model.dart'; 

class UpdateIncomeScreen extends StatefulWidget {
  @override
  _UpdateIncomeScreenState createState() => _UpdateIncomeScreenState();
}

class _UpdateIncomeScreenState extends State<UpdateIncomeScreen> {
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the current income
    final currentIncome = Provider.of<FinanceModel>(context, listen: false).totalIncome;
    _amountController.text = currentIncome.toStringAsFixed(2); // Format to 2 decimal places
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Income'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Income:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10),
            Text(
              '₹${Provider.of<FinanceModel>(context).totalIncome.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            Text(
              'Update Income:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Enter new income',
                prefixText: '₹', // Rupee symbol before the input
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_amountController.text) ?? 0;
                if (amount >= 0) {
                  Provider.of<FinanceModel>(context, listen: false).updateIncome(amount);
                  Navigator.pop(context); // Return to the previous screen
                } else {
                  // Show an error if the input is invalid
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid amount')),
                  );
                }
              },
              child: Text('Update Income'),
            ),
          ],
        ),
      ),
    );
  }
}
