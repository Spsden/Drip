

import 'package:drip/datasources/audiofiles/playback.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';





class HotKeys {
  //final WidgetRef ref;
  /// [HotKeys] object instance. Must call [HotKeys.initialize].
  static HotKeys instance = HotKeys();

  static Future<void> initialize() async {
    await Future.wait(
      [
        HotKeyManager.instance.register(
          _spaceHotkey,
          keyDownHandler: (_) => {}
        ),

      ],
    );
  }

  Future<void> disableSpaceHotKey() async {
    await HotKeyManager.instance.unregister(_spaceHotkey);
  }

  Future<void> enableSpaceHotKey() async {
    await HotKeyManager.instance.register(
      _spaceHotkey,

      keyDownHandler: (_) => {}
          //AudioControlCentre.audioControlCentre.playOrPause(),
    );
  }
}

final _spaceHotkey = HotKey(
  KeyCode.space,
  scope: HotKeyScope.inapp,
);
