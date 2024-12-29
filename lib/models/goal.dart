import 'package:hive/hive.dart';

part 'goal.g.dart';

@HiveType(typeId: 1)
class Goal {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime  dueDate;

  @HiveField(3)
  final String priority;

  @HiveField(4)
  final String id; // Add a unique identifier

  Goal({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.id, // Add the id in the constructor
  });
}
