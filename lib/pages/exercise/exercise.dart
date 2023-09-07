import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExercisePage extends HookWidget {
  const ExercisePage({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    // 상태 -> 운동시작 : ready, 운동중: busy, 운동종료 후 기록: end
    final exerciseState = useState('ready');

    return Scaffold(
      appBar: AppBar(
        // 뒤로가기 버튼 없애기

        title: Text('운동 페이지'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (exerciseState.value == 'ready')
              ElevatedButton(
                onPressed: () {
                  exerciseState.value = 'busy';
                },
                child: Text('타이머 시작'),
              ),
            if (exerciseState.value == 'busy')
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      exerciseState.value = 'end';
                    },
                    child: Text('타이머 종료'),
                  ),
                ],
              ),
            if (exerciseState.value == 'end')
              Column(
                children: [
                  Text('운동을 종료했습니다!'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // 기록 저장 기능을 추가하려면 여기에 코드를 작성해야 합니다.
                          exerciseState.value = 'ready';
                        },
                        child: Text('세트추가'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //기록을 저장하고 workout 페이지로 돌아간다.

                          Navigator.pop(context); // workout 페이지로 돌아가기
                        },
                        child: Text('종료'),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
