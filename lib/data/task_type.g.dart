// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTypeAdapter extends TypeAdapter<TaskType> {
  @override
  final int typeId = 4;

  @override
  TaskType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskType(
      image: fields[1] as String,
      taskTypeEnum: fields[2] as TaskTypeEnum,
    );
  }

  @override
  void write(BinaryWriter writer, TaskType obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.taskTypeEnum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
