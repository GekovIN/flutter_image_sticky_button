import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_sticky_button/img_sticky_button.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dynamic image with sticky button demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _picker = ImagePicker();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _pickImage(),
              child: const Text('Choose image'),
            ),

            _image != null ? ImgStickyButton(_image!, _removeImg) : const SizedBox(width: 0, height: 0)
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      var file = File(xFile.path);
      _image = file;
    }
    setState(() {});
  }

  void _removeImg() {
    _image = null;
    setState(() {});
  }
}
