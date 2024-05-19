import 'dart:io';
import 'package:flutter/material.dart';
import '../data/repository.dart';
import 'post_editing_page.dart';
import '../models/post.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = postRepository.posts;

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            leading: post.imageUrl != null
                ? Image.file(
              File(post.imageUrl),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : null,
            title: Text(post.content),
            subtitle: Text('Festival ID: ${post.festivalId}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostEditingPage(post: post),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
