import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Routine {
  const Routine({
    required this.name,
    required this.description,
  });

  final String name;
  final String description;
  //운동 리스트
}

class ExercisePage extends HookWidget {
  /// Creates a RootScreen
  const ExercisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Routine> dummyData = [
      const Routine(
        name: '밀기',
        description: "아아 그것은 훌륭한 운동이다",
      ),
      const Routine(
        name: '당기기',
        description: "아아 그것은 훌륭한 운동이다",
      ),
    ];

    //시작할 때 루틴 목록을 불러오자

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('운동루틴 선택', style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            Expanded(
              child: ListView.builder(
                itemCount: dummyData.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(dummyData[index].name),
                  subtitle: Text(dummyData[index].description),
                  onTap: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
