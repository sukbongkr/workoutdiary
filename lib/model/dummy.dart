import 'package:workoutdiary/model/model.dart';

List<Exercise> exercises = [
  Exercise(
      id: 1,
      name: 'Push-up',
      description: 'Chest exercise',
      image: null,
      category: 'Chest'),
  Exercise(
      id: 2,
      name: 'Squat',
      description: 'Leg exercise',
      image: null,
      category: 'Legs'),
  Exercise(
      id: 3,
      name: 'Pull-up',
      description: 'Back exercise',
      image: null,
      category: 'Back'),
  Exercise(
      id: 4,
      name: 'Bicep Curl',
      description: 'Arm exercise',
      image: null,
      category: 'Arms'),
];

// Routine 더미 데이터
List<Routine> routines = [
  Routine(
      id: 1,
      name: 'Chest Day',
      description: 'Routine for chest',
      exerciseIds: [1, 2, 3, 4]),
  Routine(
      id: 2,
      name: 'Leg Day',
      description: 'Routine for legs',
      exerciseIds: [2]),
  Routine(
      id: 3,
      name: 'Back Day',
      description: 'Routine for back',
      exerciseIds: [3, 4]),
];

List<WorkoutDetail> workoutDetails = [
  WorkoutDetail(
      id: 1,
      exerciseId: 1,
      timestamp: DateTime.now().subtract(Duration(minutes: 40)),
      reps: 10,
      weight: 0.0,
      duration: Duration(minutes: 5)),
  WorkoutDetail(
      id: 2,
      exerciseId: 2,
      timestamp: DateTime.now().subtract(Duration(minutes: 30)),
      reps: 12,
      weight: 20.0,
      duration: Duration(minutes: 7)),
  WorkoutDetail(
      id: 3,
      exerciseId: 3,
      timestamp: DateTime.now().subtract(Duration(minutes: 20)),
      reps: 8,
      weight: 0.0,
      duration: Duration(minutes: 4)),
  WorkoutDetail(
      id: 4,
      exerciseId: 4,
      timestamp: DateTime.now().subtract(Duration(minutes: 10)),
      reps: 10,
      weight: 10.0,
      duration: Duration(minutes: 6)),
];

// Workout 더미 데이터
List<Workout> workouts = [
  Workout(
      id: 1,
      startDate: DateTime.now().subtract(Duration(minutes: 40)),
      endDate: DateTime.now(),
      detailIds: [1, 4]),
  Workout(
      id: 2,
      startDate: DateTime.now().subtract(Duration(days: 1, minutes: 30)),
      endDate: DateTime.now().subtract(Duration(days: 1)),
      detailIds: [2, 3]),
];
