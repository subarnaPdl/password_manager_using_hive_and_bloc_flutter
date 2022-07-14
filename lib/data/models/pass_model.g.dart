// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PassModelAdapter extends TypeAdapter<PassModel> {
  @override
  final int typeId = 0;

  @override
  PassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PassModel(
      id: fields[0] as String,
      title: fields[1] as String,
      username: fields[2] as String,
      password: fields[3] as String,
      notes: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PassModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
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
