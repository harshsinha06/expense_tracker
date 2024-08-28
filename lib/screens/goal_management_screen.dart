import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/finance_model.dart';

class GoalManagementScreen extends StatelessWidget {
  const GoalManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Financial Goals'),
      ),
      body: Consumer<FinanceModel>(
        builder: (context, financeModel, child) {
          final goals = financeModel.goals;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(goal.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(goal.description),
                            Text('Target: ₹${goal.targetAmount.toStringAsFixed(2)}'),
                            Text('Current: ₹${goal.currentAmount.toStringAsFixed(2)}'),
                            LinearProgressIndicator(
                              value: goal.progress / 100,
                              minHeight: 10,
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            _showUpdateGoalDialog(context, financeModel, goal.name);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showAddGoalDialog(context, financeModel);
                  },
                  child: const Text('Add New Goal'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context, FinanceModel financeModel) {
    final nameController = TextEditingController();
    final targetAmountController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Goal Name'),
              ),
              TextField(
                controller: targetAmountController,
                decoration: const InputDecoration(labelText: 'Target Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text;
                final targetAmount = double.tryParse(targetAmountController.text) ?? 0;
                final description = descriptionController.text;

                financeModel.addGoal(
                  name: name,
                  targetAmount: targetAmount,
                  currentAmount: 0,
                  description: description,
                );

                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateGoalDialog(BuildContext context, FinanceModel financeModel, String goalName) {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Goal Progress'),
          content: TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Add Amount'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final amount = double.tryParse(amountController.text) ?? 0;
                financeModel.updateGoalProgress(goalName, amount);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
