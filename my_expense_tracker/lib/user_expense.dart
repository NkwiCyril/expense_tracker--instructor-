import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_expense_tracker/add_expense.dart';
import 'package:my_expense_tracker/chart/chart.dart';
import 'package:my_expense_tracker/expense_list/expense_list.dart';
import 'package:my_expense_tracker/models/expense_model.dart';

class UserExpense extends StatefulWidget {
  const UserExpense({super.key});

  @override
  State<UserExpense> createState() {
    return _UserExpenseState();
  }
}

class _UserExpenseState extends State<UserExpense> {
  final List<ExpenseModel> _registeredExpense = [
    ExpenseModel(
        amount: 231,
        title: "title",
        date: DateTime.now(),
        category: Category.food),
    ExpenseModel(
        amount: 231,
        title: "title",
        date: DateTime.now(),
        category: Category.food),
  ];

  void _addExpenseCard(ExpenseModel expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeExpense(ExpenseModel expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);

    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Expense deleted!',
          style: GoogleFonts.montserrat(),
        ),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpense.insert(
                expenseIndex,
                expense,
              );
            });
          },
        ),
      ),
    );
  }

  void _openAddExpensePanel() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return AddExpense(
            // this custom widget take a function will is executed in order
            // to save the correctly inputted fields in the modal sheet
            // takes the data and adds or pushes into the registered expense array or list
            onAddExpense: _addExpenseCard,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainScreen = _registeredExpense.isEmpty
        // condition to render expense content on the screen if there are
        ? Center(
            child: Text(
              'No expense created yet. Create one now!',
              style: GoogleFonts.inter(),
            ),
          )
        : ExpenseList(
            expense: _registeredExpense,
            onRemove: _removeExpense,
          );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker'.toLowerCase(),
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpensePanel,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Chart(expenses: _registeredExpense),
          ),
          Expanded(
            child: mainScreen,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpensePanel,
        child: const Icon(Icons.add),
      ),
    );
  }
}
