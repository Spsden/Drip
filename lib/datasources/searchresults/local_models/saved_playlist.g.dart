// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_playlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedPlayListAdapter extends TypeAdapter<SavedPlayList> {
  @override
  final int typeId = 2;

  @override
  SavedPlayList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedPlayList(
      playListTitle: fields[0] as String,
      playListSource: fields[1] as String,
      id: fields[2] as String,
      thumbnail: fields[3] as String,
      description: fields[4] as String,
      author: fields[5] as String,
      trackCount: fields[6] as String,
      year: fields[7] as String,
      tracks: (fields[8] as List).cast<Track>(),
    );
  }

  @override
  void write(BinaryWriter writer, SavedPlayList obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.playListTitle)
      ..writeByte(1)
      ..write(obj.playListSource)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.thumbnail)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.author)
      ..writeByte(6)
      ..write(obj.trackCount)
      ..writeByte(7)
      ..write(obj.year)
      ..writeByte(8)
      ..write(obj.tracks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedPlayListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
