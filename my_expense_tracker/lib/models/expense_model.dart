
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatted = DateFormat.yMd(); // yearMonthday
enum Category {food, leisure, work, travel, shopping}

const categoryIcons = {
  Category.food : Icons.lunch_dining,
  Category.leisure : Icons.movie,
  Category.work : Icons.work,
  Category.travel : Icons.flight_takeoff,
  Category.shopping : Icons.shopping_bag
};

class ExpenseModel {

  ExpenseModel({
    required this.amount,
    required this.title,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String title;
  final Category category;
  final int amount;
  final String id;
  final DateTime date;

  String get formattedDate {
    return formatted.format(date); // return human-readable date format
  }

}

class ExpenseBucket {

  final List<ExpenseModel> expenses;
  final Category category;

  ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(
    List<ExpenseModel> allExpenses,
    this.category,) 
    : expenses = allExpenses.where((expense) => category == expense.category).toList();

  int get totalExpenses {

    int sum = 0;

    for (final expense in expenses) {

      sum = sum +  expense.amount;

    }

    return sum;

  }

}

