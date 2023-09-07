//운동 페이지는 뒤로가기 없다.
//운동 후 세트 추가하기와 운동 종료하기 버튼이 있다.
//운동 종료하기 버튼을 누르면 workout페이지로 다시 돌아간다.

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExercisePage extends HookWidget {
  const ExercisePage({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    //상태 -> 운동시작 : ready 운동중:busy 운동종료 후 기록:end
    final exerciseState = useState('ready');

    return const Scaffold(
      body: Column(
        children: [
          //운동시작 버튼
          //운동시작되면 타이머 버튼으로 바뀜
          //운동종료하면 기록창보여주기
        ],
      ),
    );
  }
}
