import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/finance_model.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Report'),
      ),
      body: Consumer<FinanceModel>(
        builder: (context, financeModel, child) {
          final transactions = financeModel.transactions;

          // Generate data for the chart
          final transactionData =
              transactions.fold<Map<String, double>>({}, (map, transaction) {
            map[transaction.category] =
                (map[transaction.category] ?? 0) + transaction.amount;
            return map;
          });

          final chartData = transactionData.entries.map((entry) {
            return PieChartSectionData(
              color: _getColorForCategory(entry.key),
              value: entry.value,
              title: '${entry.key}: ₹${entry.value.toStringAsFixed(2)}',
              radius: 60,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0)),
            );
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Transaction Summary',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: chartData.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: PieChart(
                                PieChartData(
                                  sections: chartData,
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildLegend(transactionData),
                          ],
                        )
                      : Center(
                          child: Text('No transactions available'),
                        ),
                ),
                const SizedBox(height: 20),
                _buildSummary(financeModel),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLegend(Map<String, double> transactionData) {
    return Column(
      children: transactionData.keys.map((category) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                color: _getColorForCategory(category),
              ),
              const SizedBox(width: 8),
              Text(category, style: TextStyle(fontSize: 16)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSummary(FinanceModel financeModel) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
                'Total Income: ₹${financeModel.totalIncome.toStringAsFixed(2)}'),
            const SizedBox(height: 5),
            Text(
                'Total Expenses: ₹${financeModel.totalExpenses.toStringAsFixed(2)}'),
            const SizedBox(height: 5),
            Text('Balance: ₹${financeModel.balance.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Color _getColorForCategory(String category) {
    // Define colors for different categories
    switch (category) {
      case 'Utility Bills':
        return Colors.blue;
      case 'Education':
        return Colors.orange;
      case 'Savings':
        return Colors.green;
      case 'Investment':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
