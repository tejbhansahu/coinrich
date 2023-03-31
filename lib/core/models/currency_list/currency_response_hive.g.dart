// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_response_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyListHiveAdapter extends TypeAdapter<CurrencyListHive> {
  @override
  final int typeId = 1;

  @override
  CurrencyListHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyListHive(
      id: fields[0] as String?,
      name: fields[1] as String?,
      symbol: fields[2] as String?,
      cmcRank: fields[3] as int?,
      price: fields[4] as num?,
      volume24H: fields[5] as double?,
      volumeChange24H: fields[6] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyListHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.cmcRank)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.volume24H)
      ..writeByte(6)
      ..write(obj.volumeChange24H);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyListHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
