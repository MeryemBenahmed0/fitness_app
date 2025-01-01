import 'package:hive/hive.dart';

part 'user_profile.g.dart';  // This is necessary for code generation

@HiveType(typeId: 2)
class UserProfile {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String sex;

  @HiveField(2)
  final int age;

  @HiveField(3)
  final double height;

  @HiveField(4)
  final double weight;

  UserProfile({
    required this.name,
    required this.sex,
    required this.age,
    required this.height,
    required this.weight,
  });
}
