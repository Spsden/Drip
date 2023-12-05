import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drip/datasources/searchresults/local_models/saved_playlist.dart';
import 'package:drip/providers/local/saved_playlist_repo.dart';

class SavedPlayListsNotifier extends StateNotifier<List?> {
  SavedPlayListsNotifier(this.ref) : super(null) {
    repo = ref.read(savedPlaylistRepositoryProvider);
    fetchSavedPlaylists();
  }

  late final SavedPlayListRepo repo;
  final StateNotifierProviderRef ref;

  Future<void> fetchSavedPlaylists() async {
    state = await repo.getSavedPlaylists();
  }

  void removeSavedPlaylist(String id) async {
    state = await repo.removeSavedPlaylist(id);
  }

  // Future<void> deletePlaylist(String playlistId) async {
  //   await repo.deletePlaylist(playlistId);
  //   // After deletion, fetch the updated list of playlists
  //   await fetchSavedPlaylists();
  // }
}

final savedPlayListHiveData = StateNotifierProvider<SavedPlayListsNotifier, List?>(
      (ref) => SavedPlayListsNotifier(ref),
);

final getAllSavedPlaylistsProvider = FutureProvider<List>((ref) {
  final hiveData = ref.watch(savedPlayListHiveData);

  return hiveData??[];
});
