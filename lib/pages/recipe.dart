import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double desiredWidth = size.width * 0.875;
    double headerHeight = size.height * 0.4125;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Screen'),
      ),
      body: Center(
        child: Container(
          width: desiredWidth,
          height: headerHeight,
          color: Colors.purple[100],
          child: const Center(
            child: Text('Hello, Recipe Screen!'),
          ),
        ),
      ),
    );
  }
}
