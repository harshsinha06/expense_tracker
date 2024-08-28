import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/finance_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: Consumer<FinanceModel>(
        builder: (context, financeModel, child) {
          final transactions = financeModel.transactions;

          // Function to get the appropriate icon based on category
          IconData getCategoryIcon(String category) {
            switch (category) {
              case 'Food':
                return FontAwesomeIcons.utensils;
              case 'Chai':
                return FontAwesomeIcons.mugSaucer;
              case 'Transportation':
                return FontAwesomeIcons.car;
              case 'Utility Bills':
                return FontAwesomeIcons.lightbulb;
              case 'Entertainment':
                return FontAwesomeIcons.film;
              case 'Education':
                return FontAwesomeIcons.graduationCap;
              case 'Savings':
                return FontAwesomeIcons.piggyBank;
              default:
                return FontAwesomeIcons.moneyBillWave;
            }
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        title: Text(transaction.description),
                        subtitle: Text(transaction.category),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '₹${transaction.amount.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(DateFormat('yyyy-MM-dd')
                                .format(transaction.date)),
                            Text(DateFormat('HH:mm').format(transaction.date)),
                          ],
                        ),
                        leading: Icon(
                          getCategoryIcon(transaction.category),
                          color: transaction.amount > 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
