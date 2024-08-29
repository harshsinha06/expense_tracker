import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/finance_model.dart';
import 'update_income_screen.dart';
import 'transaction_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyFinance'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'MyFinance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Transaction History'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/transactions');
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Financial Goals'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/goals');
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Reports'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/reports');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Consumer<FinanceModel>(
        builder: (context, financeModel, child) {
          final totalSavingsAndInvestment =
              financeModel.getTotalSavingsAndInvestment();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Financial Summary',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 8,
                  child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      leading: const Icon(FontAwesomeIcons.wallet),
                      title: Text('Total Income'),
                      subtitle: Text(
                          '₹${financeModel.totalIncome.toStringAsFixed(2)}')),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransactionHistoryScreen(),
                      ),
                    );
                  },
                  child: Card(
                      elevation: 8,
                      child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          leading: const Icon(FontAwesomeIcons.moneyBillWave),
                          title: const Text('Total Expenses'),
                          subtitle: Text(
                              '₹${financeModel.totalExpenses.toStringAsFixed(2)}'))),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 8,
                  child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      leading: const Icon(FontAwesomeIcons.piggyBank),
                      title: const Text('Savings & Investment'),
                      subtitle: Text(
                          '₹${totalSavingsAndInvestment.toStringAsFixed(2)}')),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 8,
                  child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      leading:
                          const Icon(FontAwesomeIcons.wallet), // Changed icon
                      title: const Text('Balance'),
                      subtitle:
                          Text('₹${financeModel.balance.toStringAsFixed(2)}')),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/addTransaction');
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FontAwesomeIcons.plus),
                        SizedBox(width: 8),
                        Text('Add Transaction'),
                      ],
                    )),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateIncomeScreen()),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FontAwesomeIcons.wallet),
                      SizedBox(width: 8),
                      Text('Update Income'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
