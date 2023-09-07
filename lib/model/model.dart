import 'dart:convert';

class Exercise {
  final int id;
  final String name;
  final String description;
  final String? image;
  final String category;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image ?? "",
      'category': category,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'] != "" ? map['image'] : null,
      category: map['category'],
    );
  }
}

class Routine {
  final int id;
  final String name;
  final String description;
  final List<int> exerciseIds;

  Routine({
    required this.id,
    required this.name,
    required this.description,
    required this.exerciseIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'exerciseIds': jsonEncode(exerciseIds),
    };
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    return Routine(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      exerciseIds: List<int>.from(jsonDecode(map['exerciseIds'])),
    );
  }
}

class Workout {
  final int id;
  final DateTime startDate;
  final DateTime endDate;
  final List<int> detailIds;

  Workout({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.detailIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'detailIds': jsonEncode(detailIds),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      detailIds: List<int>.from(jsonDecode(map['detailIds'])),
    );
  }
}

class WorkoutDetail {
  final int id;
  final int exerciseId;
  final DateTime timestamp;
  final int reps;
  final double weight;
  final Duration duration; // 운동하는 데 걸린 시간

  WorkoutDetail({
    required this.id,
    required this.exerciseId,
    required this.timestamp,
    required this.reps,
    required this.weight,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exerciseId': exerciseId,
      'timestamp': timestamp.toIso8601String(),
      'reps': reps,
      'weight': weight,
      'duration': duration.inSeconds, // 초 단위로 저장
    };
  }

  factory WorkoutDetail.fromMap(Map<String, dynamic> map) {
    return WorkoutDetail(
      id: map['id'],
      exerciseId: map['exerciseId'],
      timestamp: DateTime.parse(map['timestamp']),
      reps: map['reps'],
      weight: map['weight'],
      duration: Duration(seconds: map['duration']), // 초 단위로 불러옴
    );
  }
}
