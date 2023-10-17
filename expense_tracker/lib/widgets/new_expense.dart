import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _choosenDate;
  Category _selectedCategory = Category.work;

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    // clear this method in memory once not in use anymore ??
    super.dispose();
  }

  void _presentDatePicker() async {
    // flutter should wait for a date to be received and stored in _selectedDate
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;

    final selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate,
    );

    setState(() {
      _choosenDate = selectedDate;
    });
  }

  void _saveExpense() {
    // method to check is all fields are correctly inputted

    final enteredAmount = double.tryParse(_amountController.text);
    final checkAmount = enteredAmount == null || enteredAmount <= 0;

    if (_textController.text.trim().isEmpty ||
        checkAmount ||
        _choosenDate == null) {
      // display an error message
      // is nothing is gotten from the title field
      // no amount inputted or it is less than or equal to 0
      // selected date is equal to null
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please input a valid Title, Amount and Date in order to save the current expense.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay!')),
          ],
        ),
      );
    } else {
      widget.onAddExpense(
        Expense(
            title: _textController.text,
            amount: enteredAmount,
            date: _choosenDate!,
            category: _selectedCategory),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 55, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            // to get input from the users
                            controller: _textController,
                            decoration:
                                const InputDecoration(label: Text('Title')),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '\$ ',
                              label: Text("Amount"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  TextField(
                    // to get input from the users
                    controller: _textController,
                    decoration: const InputDecoration(label: Text('Title')),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              _choosenDate == null
                                  ? 'No date selected'
                                  : formatted.format(_choosenDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _choosenDate == null
                                  ? 'No date selected'
                                  : formatted.format(_choosenDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                if (width >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: _saveExpense,
                        child: const Text("Save Expense"),
                      ),
                    ],
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: _saveExpense,
                          child: const Text("Save Expense"),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
