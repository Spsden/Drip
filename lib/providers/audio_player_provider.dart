import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

final audioPlayerProvider = Provider<Player>((ref) => Player(configuration: const PlayerConfiguration(vo: null)));