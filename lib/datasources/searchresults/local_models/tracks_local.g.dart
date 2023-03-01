// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackAdapter extends TypeAdapter<Track> {
  @override
  final int typeId = 3;

  @override
  Track read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Track(
      album: (fields[0] as List?)?.cast<String>(),
      artists: (fields[1] as List).cast<String>(),
      duration: fields[2] as String?,
      durationSeconds: fields[3] as int,
      isAvailable: fields[4] as bool,
      isExplicit: fields[5] as bool,
      thumbnails: (fields[6] as List).cast<String>(),
      title: fields[7] as String?,
      videoId: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Track obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.album)
      ..writeByte(1)
      ..write(obj.artists)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.durationSeconds)
      ..writeByte(4)
      ..write(obj.isAvailable)
      ..writeByte(5)
      ..write(obj.isExplicit)
      ..writeByte(6)
      ..write(obj.thumbnails)
      ..writeByte(7)
      ..write(obj.title)
      ..writeByte(8)
      ..write(obj.videoId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
