import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class FinanceModel extends ChangeNotifier {
  double _totalIncome = 20000;
  double _totalExpenses = 0;
  double _balance = 20000;
  final List<Transaction> _transactions = [];
  final List<FinancialGoal> _goals = [];

  double get totalIncome => _totalIncome;
  double get totalExpenses => _totalExpenses;
  double get balance => _balance;
  List<Transaction> get transactions => _transactions;
  List<FinancialGoal> get goals => _goals;

  FinanceModel() {
    _initializeDefaultTransactions();
    _initializeDefaultGoals();
  }

  void _initializeDefaultTransactions() {
    addTransaction(
      amount: 10000,
      category: 'Utility Bills',
      description: 'Rent',
    );
    addTransaction(
      amount: 349,
      category: 'Utility Bills',
      description: 'Mobile Recharge',
    );
    addTransaction(
      amount: 200,
      category: 'Education',
      description: 'Stationery',
    );
    addTransaction(
      amount: 3000,
      category: 'Savings',
      description: 'Contribution to goal: Vacation',
    );
  }

  void _initializeDefaultGoals() {
    addGoal(
      name: 'Vacation',
      targetAmount: 10000,
      currentAmount: 3000,
      description: 'Trip to Ladakh',
    );
  }

  void updateIncome(double amount) {
    _totalIncome = amount;
    _balance = amount - _totalExpenses;
    notifyListeners();
  }

  void addTransaction({
    required double amount,
    required String category,
    required String description,
  }) {
    final transaction = Transaction(
      amount: amount,
      category: category,
      description: description,
      date: DateTime.now(),
    );
    _transactions.add(transaction);
    _totalExpenses += amount;
    _balance = _totalIncome - _totalExpenses;
    notifyListeners();
  }

  void addGoal({
    required String name,
    required double targetAmount,
    required double currentAmount,
    required String description,
  }) {
    final goal = FinancialGoal(
      name: name,
      targetAmount: targetAmount,
      currentAmount: currentAmount,
      description: description,
    );
    _goals.add(goal);
    notifyListeners();
  }

  void updateGoalProgress(String name, double amount) {
    final goal = _goals.firstWhere((goal) => goal.name == name);
    goal.currentAmount += amount;

    // Add a transaction for the goal update
    addTransaction(
      amount: amount,
      category: 'Savings',
      description: 'Contribution to goal: ${goal.name}',
    );

    // Adjust balance
    _balance -= amount;

    notifyListeners();
  }

  // Method to calculate total for Savings and Investment
  double getTotalSavingsAndInvestment() {
    return _transactions
        .where((transaction) =>
            transaction.category == 'Savings' ||
            transaction.category == 'Investment')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }
}

class Transaction {
  final double amount;
  final String category;
  final String description;
  final DateTime date;

  Transaction({
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
  });

  String get formattedDate => DateFormat('yyyy-MM-dd').format(date);
  String get formattedTime => DateFormat('HH:mm').format(date);
}

class FinancialGoal {
  final String name;
  final double targetAmount;
  double currentAmount;
  final String description;

  FinancialGoal({
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    required this.description,
  });

  double get progress => (currentAmount / targetAmount) * 100;
}
