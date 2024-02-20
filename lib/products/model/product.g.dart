// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as String,
      name: fields[1] as String,
      obs: fields[2] as String,
      category: fields[3] as String,
      isKilograms: fields[4] as bool,
      isPurchased: fields[7] as bool,
      price: fields[5] as double?,
      amount: fields[6] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.obs)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.isKilograms)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.amount)
      ..writeByte(7)
      ..write(obj.isPurchased);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
