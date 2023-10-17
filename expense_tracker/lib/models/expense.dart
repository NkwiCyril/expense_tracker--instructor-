import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid(); // Universal Unique IDentifier

final formatted = DateFormat.yMd();

enum Category {food, travel, leisure, work } 
// storing categories as an enum to avoid typos or changes in category names

final categoryIcons = {
  Category.food : Icons.lunch_dining,
  Category.leisure : Icons.movie,
  Category.travel : Icons.flight_takeoff,
  Category.work : Icons.work
}; // mapping each category to their corresponding icons with help of a categoryIcons object


class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category
}) : id = uuid.v4(); // id generated based on random numbers

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate { 
    // getter to format date of expense to  be human readable m/d/y
    return formatted.format(date);
  }
}

class ExpenseBucket {

  ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) 
      : expenses = allExpenses
      // using the where() constructor function to get elements of a list that satisfy a certain condition 
      // and add to a newList (allExpense in this case)
            .where((expense) => category == expense.category).toList();
  
  final List<Expense> expenses;
  final Category category;

  double get totalExpenses {

    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }

}