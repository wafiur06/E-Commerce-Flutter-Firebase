import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            title: Text('Hello! Bloc'),
            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            subtitle: Text('Welcome to Laza'),
            subtitleTextStyle: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}
