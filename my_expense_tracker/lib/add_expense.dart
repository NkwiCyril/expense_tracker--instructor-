
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_expense_tracker/models/expense_model.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.onAddExpense});

  final void Function(ExpenseModel expense) onAddExpense;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

  final _amountController = TextEditingController();
  final _textController = TextEditingController();  
  DateTime? _choosenDate;
  Category _category = Category.leisure;

  void _showCalendar() async {
    final initialDate = DateTime.now();
    final firstDate = DateTime(initialDate.year - 1, initialDate.month, initialDate.day);
    final lastDate = initialDate;

    final selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
    );
    setState(() {
      _choosenDate = selectedDate;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _textController.dispose();

    super.dispose();
  }

  void _saveAddedExpense() {

    final inputtedAmount = int.tryParse(_amountController.text);
    final checkAmount = inputtedAmount == null || inputtedAmount <= 0 ; 

    if (_textController.text.trim().isEmpty || checkAmount || _choosenDate == null) {
      showDialog(context: context, builder: (ctx) {
        return AlertDialog(
          content: Text("Please correctly input a Title, an  Amount and a Date in order to save your expense.", style: GoogleFonts.montserrat(),),
          actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Okay!"),
                )
          ],
        );
      });
    } else {
        widget.onAddExpense(
          ExpenseModel(amount: inputtedAmount, title: _textController.text, date: _choosenDate!, category: _category)
        );   
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expense added successfully!',),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pop(context); 

    }    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text(
                'Title',
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const Text('Amount',
                    ),
                    suffixText: 'XAF',suffixStyle: GoogleFonts.montserrat()
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _choosenDate == null
                        ? 'No date selected'
                        : formatted.format(_choosenDate!),
                  ),
                  IconButton(
                    onPressed: _showCalendar,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              )
            ],
          ),   
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                DropdownButton(
                  value: _category,
                  items: Category.values.map((category) {
                  return DropdownMenuItem(
                        value: category, // don't forget the value property so the item is displayed on the dropdown
                        child: Text(category.name.toUpperCase(),
                        ),
                      );
                }).toList(), // items needs to be a list rather then an object
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                    });
                  }
                ),
                const Spacer(),
              ],
            ),
          ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel',
                      ),
                    ),
                    ElevatedButton(
                        onPressed: _saveAddedExpense, 
                        child: const Text(
                          "Save Expense",
                        ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}