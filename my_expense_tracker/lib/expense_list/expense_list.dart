import 'package:flutter/material.dart';
import 'package:my_expense_tracker/expense_list/expense_item.dart';
import 'package:my_expense_tracker/models/expense_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expense,
    required this.onRemove,
  });

  final void Function(ExpenseModel expense) onRemove;
  final List<ExpenseModel> expense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          margin: Theme.of(context).cardTheme.margin,
          decoration: const BoxDecoration(color: Colors.red),
          child: const Center(
            child: Icon(
              Icons.delete,
              size: 35,
            ),
          ),
        ),
        onDismissed: (direction) {
          // once a subject is dimissed we need to clear/remove it from the registered list
          // how do I go about that?
          onRemove(expense[index]);
          // simply defining a method that gets the index of the dismissed expense
          // and removes it from the registered expense
        },
        key: ValueKey(expense[index]),
        child: ExpenseItem(expense: expense[index]),
      ),
    );
  }
}
