import 'package:flutter/material.dart';
import 'package:vendorapp/screens/app_properties.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(child: Column(children: [])))),
    );
  }
}
