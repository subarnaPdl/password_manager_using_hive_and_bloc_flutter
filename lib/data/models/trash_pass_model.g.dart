// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trash_pass_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrashSuperPassModelAdapter extends TypeAdapter<TrashSuperPassModel> {
  @override
  final int typeId = 2;

  @override
  TrashSuperPassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrashSuperPassModel(
      title: fields[0] as String,
      passModel: (fields[1] as List).cast<TrashPassModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TrashSuperPassModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.passModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrashSuperPassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrashPassModelAdapter extends TypeAdapter<TrashPassModel> {
  @override
  final int typeId = 3;

  @override
  TrashPassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrashPassModel(
      username: fields[0] as String,
      password: fields[1] as String,
      notes: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TrashPassModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrashPassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
