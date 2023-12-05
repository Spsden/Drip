import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../datasources/searchresults/local_models/saved_playlist.dart';

class SavedPlayListRepo {
  late Box _hive;
  late List _box;
  SavedPlayListRepo();

  Future<List> getSavedPlaylists() async{
    _hive = Hive.box('savedPlaylists');
    _box = _hive.values.toList()  ;
    return _box ;
  }
  Future<List> removeSavedPlaylist(String id)async {
    _hive.deleteAt(
        _hive.values.toList().indexWhere((element) => element.id == id));
    return _hive.values.toList();
  }

  Future<List> addSavedPlaylist(SavedPlayList savedPlayList) async {
    _hive.add(savedPlayList);
    return _hive.values.toList();
  }



}

final savedPlaylistRepositoryProvider= Provider<SavedPlayListRepo>((ref) => SavedPlayListRepo());