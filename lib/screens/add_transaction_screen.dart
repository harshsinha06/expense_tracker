import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/finance_model.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;

  final List<String> _categories = [
    'Food',
    'Chai',
    'Transportation',
    'Utility Bills',
    'Entertainment',
    'Education',
    'Savings',
    'Investment'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Enter amount',
                prefixText: '₹',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            Text(
              'Category:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              hint: Text('Select a category'),
              isExpanded: true,
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Enter description',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_amountController.text) ?? 0;
                final description = _descriptionController.text;

                if (_selectedCategory != null && amount > 0) {
                  // Add transaction logic
                  Provider.of<FinanceModel>(context, listen: false)
                      .addTransaction(
                    amount: amount,
                    category: _selectedCategory!,
                    description: description,
                  );
                  Navigator.pop(context); // Return to the previous screen
                } else {
                  // Show an error if the input is invalid
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Please enter a valid amount and select a category')),
                  );
                }
              },
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
