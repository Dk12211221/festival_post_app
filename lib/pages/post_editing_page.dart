import 'dart:io';
import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";
import '../models/post.dart';
import '../models/festival.dart';
import '../data/repository.dart';

class PostEditingPage extends StatefulWidget {
  final Post? post;

  PostEditingPage({this.post});

  @override
  _PostEditingPageState createState() => _PostEditingPageState();
}

class _PostEditingPageState extends State<PostEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  String? _selectedFestivalId;
  File? _imageFile;

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
  void initState() {
    super.initState();
    if (widget.post != null) {
      _contentController.text = widget.post!.content;
      _selectedFestivalId = widget.post!.festivalId;
      _imageFile = File(widget.post!.imageUrl);
    }
  }

  Future<void> _pickImage() async {
    var ImageSource;
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _savePost() {
    if (_formKey.currentState!.validate()) {
      final post = Post(
        id: widget.post?.id ?? DateTime.now().toString(),
        festivalId: _selectedFestivalId!,
        content: _contentController.text,
        imageUrl: _imageFile?.path ?? '',
      );

      if (widget.post == null) {
        postRepository.addPost(post);
      } else {
        postRepository.updatePost(post);
      }

      Navigator.pop(context, post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? 'Create Post' : 'Edit Post'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _savePost,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedFestivalId,
                decoration: InputDecoration(labelText: 'Festival'),
                items: festivals.map((festival) {
                  return DropdownMenuItem(
                    value: festival.id,
                    child: Text(festival.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFestivalId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a festival';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _imageFile == null
                  ? TextButton.icon(
                icon: Icon(Icons.image),
                label: Text('Select Image'),
                onPressed: _pickImage,
              )
                  : Column(
                children: [
                  Image.file(
                    _imageFile!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text('Change Image'),
                    onPressed: _pickImage,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }
}

class ImagePicker {
  pickImage({required source}) {}
}
