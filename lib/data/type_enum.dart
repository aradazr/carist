import 'package:hive_flutter/hive_flutter.dart';


part 'type_enum.g.dart';

@HiveType(typeId: 5)

enum TaskTypeEnum{
  @HiveField(1)
  engine,
  @HiveField(2)
  oil,
  @HiveField(3)
  wheel,
  @HiveField(4)
  gearbox,
  @HiveField(5)
  electricity,
  @HiveField(6)
  brake,
  @HiveField(7)
  light,
  @HiveField(8)
  others
}