// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarAdapter extends TypeAdapter<Car> {
  @override
  final int typeId = 2;

  @override
  Car read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Car(
      id: fields[0] as String,
      brand: fields[1] as String,
      model: fields[2] as String,
      color: fields[3] as String,
      yom: fields[4] as String,
      price: fields[5] as String,
      category: fields[6] as String,
      description: fields[7] as String,
      image: fields[8] as String,
      images: (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Car obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.brand)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.yom)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
