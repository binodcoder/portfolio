import 'package:flutter/material.dart';
import 'package:my_cv/features/expense_tracker/widgets/expenses.dart';
import '../../common_widgets/app_bar.dart';
import 'widgets/drawer/drawer.dart';
import '../quiz/quiz.dart';
import 'model/home_item.dart';

class Home extends StatelessWidget {
  final List<HomeItem> items = [
    HomeItem('Expenses', Icons.attach_money, Expenses()),
    HomeItem('Quiz', Icons.quiz, Quiz()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: items.map((item) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item.destination),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, size: 40, color: Colors.deepPurple),
                    SizedBox(height: 8),
                    Text(item.title, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
