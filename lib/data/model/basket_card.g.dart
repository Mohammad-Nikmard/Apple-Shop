// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasketCardAdapter extends TypeAdapter<BasketCard> {
  @override
  final int typeId = 0;

  @override
  BasketCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasketCard(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      fields[3] as num,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BasketCard obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.discountPrice)
      ..writeByte(3)
      ..write(obj.percentageAmount)
      ..writeByte(5)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasketCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
