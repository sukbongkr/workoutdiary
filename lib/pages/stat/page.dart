import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StatPage extends HookWidget {
  const StatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('통계'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('통계', style: Theme.of(context).textTheme.titleLarge),
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
