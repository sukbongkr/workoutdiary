import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:workoutdiary/model/dummy.dart';

class RoutineSelect extends HookWidget {
  /// Creates a RootScreen
  const RoutineSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //시작할 때 루틴 목록을 불러오자

    return Scaffold(
      appBar: AppBar(
        title: const Text('운동하기'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('운동루틴 선택', style: Theme.of(context).textTheme.titleLarge),
          const Padding(padding: EdgeInsets.all(4)),
          Expanded(
            child: ListView.builder(
              itemCount: routines.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(routines[index].name),
                subtitle: Text(routines[index].description),
                onTap: () {
                  context.go('/workout/${routines[index].id}');
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
