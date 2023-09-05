import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DetailsScreen extends HookWidget {
  const DetailsScreen({required this.label, Key? key}) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen - $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Details for $label - Counter: ${counter.value}',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                counter.value += 2;
              },
              child: const Text('Increment counter'),
            ),
          ],
        ),
      ),
    );
  }
}
