import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:workoutdiary/model/dummy.dart';
import 'package:workoutdiary/model/model.dart';

class WorkoutPage extends HookWidget {
  const WorkoutPage({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    Routine routine =
        routines.firstWhere((element) => element.id == int.parse(id));
    final disabledList =
        useState<List<bool>>(List.filled(routine.exerciseIds.length, false));
    // useEffect(() {
    //   //여기에 루틴을 db에서 불러오는 코드를 작성
    //오늘날짜의 workout을 생성하는 코드를 작성
    // }, []);

    //운동이 시작되면 뒤로가기 못하게 막자
    //운동이 완전히 종료되면 workout을 db에 저장하는 코드를 작성하고
    //'/todayrecord' 페이지로

    return Scaffold(
      appBar: AppBar(
        title: const Text('WorkOut'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: routine.exerciseIds.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(exercises
                    .firstWhere(
                        (element) => element.id == routine.exerciseIds[index])
                    .name),
                subtitle: Text(exercises
                    .firstWhere(
                        (element) => element.id == routine.exerciseIds[index])
                    .description),
                onTap: () {
                  context.go('/workout/$id/${routine.exerciseIds[index]}');
                },
                enabled: !disabledList.value[index],
                trailing: disabledList.value[index]
                    ? const Icon(Icons.check, color: Colors.green)
                    : IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          disabledList.value = List.from(disabledList.value)
                            ..[index] = true;
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
