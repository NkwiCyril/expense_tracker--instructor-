import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredList = [
    Expense(
        title: "dummy data",
        amount: 23.1,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "dummy data",
        amount: 23.1,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredList.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredList.indexOf(expense);
    // get the index of the registered expense
    setState(() {
      _registeredList
          .remove(expense); // removes the expense from the registered list
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
            label: 'undo',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            onPressed: () {
              setState(() {
                _registeredList.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true, // stay away from the device features like the camera
      isScrollControlled: true, // extends the height of the modal sheet
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    final screenWidth = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text(
        'No Expense created yet. Start creating now!',
      ),
    );

    final Widget screenContent = _registeredList.isEmpty
        ? mainContent
        : ExpenseList(
            expense: _registeredList,
            onRemoveExpense: _removeExpense,
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: screenWidth < 600
          ? Column(
              children: [
                Chart(expenses: _registeredList),
                Expanded(
                  child: screenContent,
                ),
              ],
            )
          : Row(children: [
              Expanded(
                child: Chart(expenses: _registeredList),
              ),
              Expanded(
                child: screenContent,
              ),
            ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _openAddExpenseOverlay,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
