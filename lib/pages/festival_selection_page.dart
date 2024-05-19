import 'package:flutter/material.dart';
import '../models/festival.dart';

class FestivalSelectionPage extends StatelessWidget {
  final List<Festival> festivals = [
    Festival(
      id: '1',
      name: 'Music Fest',
      location: 'New York',
      date: DateTime(2024, 6, 21),
      imageUrl: 'https://example.com/image1.jpg',
    ),
    Festival(
      id: '2',
      name: 'Art Fest',
      location: 'Paris',
      date: DateTime(2024, 7, 15),
      imageUrl: 'https://example.com/image2.jpg',
    ),
    // Add more festivals here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Festival'),
      ),
      body: ListView.builder(
        itemCount: festivals.length,
        itemBuilder: (context, index) {
          final festival = festivals[index];
          return ListTile(
            leading: Image.network(
              festival.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(festival.name),
            subtitle: Text('${festival.location} - ${festival.date.toLocal()}'.split(' ')[0]),
            onTap: () {
              // Handle festival selection
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FestivalDetailPage(festival: festival),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FestivalDetailPage extends StatelessWidget {
  final Festival festival;

  FestivalDetailPage({required this.festival});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(festival.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(festival.imageUrl),
            SizedBox(height: 20),
            Text(festival.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(festival.location, style: TextStyle(fontSize: 18)),
            Text('${festival.date.toLocal()}'.split(' ')[0], style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
