// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SuperPassModelAdapter extends TypeAdapter<SuperPassModel> {
  @override
  final int typeId = 0;

  @override
  SuperPassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SuperPassModel(
      title: fields[0] as String,
      passModel: (fields[1] as List).cast<PassModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SuperPassModel obj) {
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
      other is SuperPassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PassModelAdapter extends TypeAdapter<PassModel> {
  @override
  final int typeId = 1;

  @override
  PassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PassModel(
      username: fields[0] as String,
      password: fields[1] as String,
      notes: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PassModel obj) {
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
      other is PassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
