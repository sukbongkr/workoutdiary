import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExercisePage extends HookWidget {
  /// Creates a RootScreen
  const ExercisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('운동루틴 선택', style: Theme.of(context).textTheme.titleLarge),
              const Padding(padding: EdgeInsets.all(4)),
              // TextButton(
              //   onPressed: () => context.go(),
              //   child: const Text('View details'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
