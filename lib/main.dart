import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/finance_model.dart';
import 'screens/home_screen.dart';
import 'screens/add_transaction_screen.dart';
import 'screens/transaction_history_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/goal_management_screen.dart';

void main() {
  runApp(const MyFinanceApp());
}

class MyFinanceApp extends StatelessWidget {
  const MyFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FinanceModel(),
      child: MaterialApp(
        title: 'MyFinance',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/addTransaction': (context) => AddTransactionScreen(),
          '/transactions': (context) => const TransactionHistoryScreen(),
          '/settings': (context) => SettingsScreen(),
          '/goals': (context) => const GoalManagementScreen()
        },
      ),
    );
  }
}
