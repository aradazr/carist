// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTypeEnumAdapter extends TypeAdapter<TaskTypeEnum> {
  @override
  final int typeId = 5;

  @override
  TaskTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return TaskTypeEnum.engine;
      case 2:
        return TaskTypeEnum.oil;
      case 3:
        return TaskTypeEnum.wheel;
      case 4:
        return TaskTypeEnum.gearbox;
      case 5:
        return TaskTypeEnum.electricity;
      case 6:
        return TaskTypeEnum.brake;
      case 7:
        return TaskTypeEnum.light;
      case 8:
        return TaskTypeEnum.others;
      default:
        return TaskTypeEnum.engine;
    }
  }

  @override
  void write(BinaryWriter writer, TaskTypeEnum obj) {
    switch (obj) {
      case TaskTypeEnum.engine:
        writer.writeByte(1);
        break;
      case TaskTypeEnum.oil:
        writer.writeByte(2);
        break;
      case TaskTypeEnum.wheel:
        writer.writeByte(3);
        break;
      case TaskTypeEnum.gearbox:
        writer.writeByte(4);
        break;
      case TaskTypeEnum.electricity:
        writer.writeByte(5);
        break;
      case TaskTypeEnum.brake:
        writer.writeByte(6);
        break;
      case TaskTypeEnum.light:
        writer.writeByte(7);
        break;
      case TaskTypeEnum.others:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
