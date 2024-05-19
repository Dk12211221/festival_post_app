import 'package:festival_post_app/festival_selection_page.dart';
import 'package:flutter/material.dart';
import 'pages/festival_selection_page.dart';
import 'pages/post_editing_page.dart';
import 'pages/history_page.dart';
import 'models/post.dart';

void main() {
  runApp(FestivalPostApp());
}

class FestivalPostApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festival Post App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Festival Post App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostEditingPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: FestivalSelectionPage(),
    );
  }
}
