// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invader_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvaderAdapter extends TypeAdapter<Invader> {
  @override
  final int typeId = 0;

  @override
  Invader read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Invader(
      name: fields[0] as String,
      height: fields[1] as String,
      mass: fields[2] as String,
      hairColor: fields[3] as String,
      skinColor: fields[4] as String,
      eyeColor: fields[5] as String,
      birthYear: fields[6] as String,
      gender: fields[7] as String,
      homeworld: fields[8] as String,
      films: (fields[10] as List)?.cast<String>(),
      species: (fields[11] as List)?.cast<String>(),
      vehicles: (fields[12] as List)?.cast<String>(),
      starships: (fields[14] as List)?.cast<String>(),
      created: fields[16] as DateTime,
      edited: fields[17] as DateTime,
      url: fields[18] as String,
    )
      ..homeWorldName = fields[9] as String
      ..vehiclesName = (fields[13] as List)?.cast<String>()
      ..starshipsName = (fields[15] as List)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, Invader obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.mass)
      ..writeByte(3)
      ..write(obj.hairColor)
      ..writeByte(4)
      ..write(obj.skinColor)
      ..writeByte(5)
      ..write(obj.eyeColor)
      ..writeByte(6)
      ..write(obj.birthYear)
      ..writeByte(7)
      ..write(obj.gender)
      ..writeByte(8)
      ..write(obj.homeworld)
      ..writeByte(9)
      ..write(obj.homeWorldName)
      ..writeByte(10)
      ..write(obj.films)
      ..writeByte(11)
      ..write(obj.species)
      ..writeByte(12)
      ..write(obj.vehicles)
      ..writeByte(13)
      ..write(obj.vehiclesName)
      ..writeByte(14)
      ..write(obj.starships)
      ..writeByte(15)
      ..write(obj.starshipsName)
      ..writeByte(16)
      ..write(obj.created)
      ..writeByte(17)
      ..write(obj.edited)
      ..writeByte(18)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
