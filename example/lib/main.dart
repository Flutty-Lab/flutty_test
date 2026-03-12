import 'package:flutter/material.dart';

void main() {}

class ExampleCard extends StatelessWidget {
  const ExampleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('Hello from flutty_test example'),
      ),
    );
  }
}
