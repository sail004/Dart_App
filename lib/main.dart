import 'package:flutter/material.dart';
import 'circular_progress_widget.dart';
import 'screen2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'APIManager.dart';

void main() {
  runApp(MyApp());


  APIManager().getData({}, 'Main_Page').then((data) {
    products = data;
    print(products);
  });
}

List<Map<String, dynamic>> products = [];

final List<String> cardTitles = ['Вода', 'Завтрак', 'Обед', 'Ужин', 'Перекусы'];

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> generatedItems = generateItems(cardTitles);
    return MaterialApp(
      title: 'My App',
      routes: {
        '/breakfastScreen': (context) => BreakfastScreen(items: products),
      },
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomePage(cardTitles: cardTitles),
    );
  }

  List<Map<String, dynamic>> generateItems(List<String> items) {
    return items.map((item) => {'name': item}).toList();
  }
}

class HomePage extends StatelessWidget {
  int eaten = 0;
  int left = 0;
  int burned = 0;
  int carbs = 0;
  int protein = 0;
  int fat = 0;
  int water = 0;
  int breakfast = 0;
  int lunch = 0;
  int dinner = 0;
  int snacks = 0;

  final List<String> cardTitles;

  HomePage({required this.cardTitles});

  final List<String> cardValues = [
    '0 / 2Л',
    '0 / 530',
    '0 / 530',
    '0 / 530',
    '0 / 200'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: CustomScrollView(

        slivers: <Widget>[

      const SliverAppBar(
      backgroundColor: Colors.white,
        pinned: true,
        expandedHeight: 70.0,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            'Сегодня',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
        actions: [
          Icon(Icons.arrow_forward_ios, color: Colors.black),
        ],
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [
          SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('$left\nCъедено',
                        textAlign: TextAlign.center),
                    SizedBox(height: 10),
                  ],
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green[700],
                    ),
                    child: Center(
                      child: Text(
                        '$eaten\nОсталось',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text('$burned\nСожжено',
                        textAlign: TextAlign.center),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 47,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Углеводы'),
                      SizedBox(height: 5),
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('$carbs/700г'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Белки'),
                      SizedBox(height: 5),
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('$protein / 700 г'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Жиры'),
                      SizedBox(height: 5),
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('$fat / 700 г'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Column(
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cardTitles[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        cardValues[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/breakfastScreen',
                            arguments: cardTitles[index],
                          );
                        },
                        icon: Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ),
      ],

      ),
    );

  }
}