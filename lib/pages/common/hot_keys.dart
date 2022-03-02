

import 'package:hotkey_manager/hotkey_manager.dart';

import '../../datasources/audiofiles/audiocontrolcentre.dart';




class HotKeys {
  /// [HotKeys] object instance. Must call [HotKeys.initialize].
  static late HotKeys instance = HotKeys();

  static Future<void> initialize() async {
    await Future.wait(
      [
        HotKeyManager.instance.register(
          _spaceHotkey,
          keyDownHandler: (_) => AudioControlClass.playOrPause(),
        ),
        HotKeyManager.instance.register(
          HotKey(
            KeyCode.keyN,
            modifiers: [KeyModifier.alt],
            scope: HotKeyScope.inapp,
          ),
          keyDownHandler: (_) =>  AudioControlClass.playOrPause(),
        ),
        HotKeyManager.instance.register(
          HotKey(
            KeyCode.keyB,
            modifiers: [KeyModifier.alt],
            scope: HotKeyScope.inapp,
          ),
          keyDownHandler: (_) =>  AudioControlClass.playOrPause(),
        ),
        HotKeyManager.instance.register(
          HotKey(
            KeyCode.keyM,
            modifiers: [KeyModifier.alt],
            scope: HotKeyScope.inapp,
          ),
          keyDownHandler: (_) =>  AudioControlClass.playOrPause(),
        ),
        // HotKeyManager.instance.register(
        //   HotKey(
        //     KeyCode.keyC,
        //     modifiers: [KeyModifier.alt],
        //     scope: HotKeyScope.inapp,
        //   ),
        //   keyDownHandler: (_) {
        //     Playback.instance.setVolume(
        //       (Playback.instance.volume - 5.0).clamp(0.0, 100.0),
        //     );
        //   },
        // ),
        // HotKeyManager.instance.register(
        //   HotKey(
        //     KeyCode.keyV,
        //     modifiers: [KeyModifier.alt],
        //     scope: HotKeyScope.inapp,
        //   ),
        //   keyDownHandler: (_) {
        //     Playback.instance.setVolume(
        //       (Playback.instance.volume + 5.0).clamp(0.0, 100.0),
        //     );
        //   },
        // ),
        // HotKeyManager.instance.register(
        //   HotKey(
        //     KeyCode.keyZ,
        //     modifiers: [KeyModifier.alt],
        //     scope: HotKeyScope.inapp,
        //   ),
        //   keyDownHandler: (_) {
        //     if (Playback.instance.position >= Playback.instance.duration)
        //       return;
        //     Playback.instance.seek(
        //       Playback.instance.position + Duration(seconds: 10),
        //     );
        //   },
        // // ),
        // HotKeyManager.instance.register(
        //   HotKey(
        //     KeyCode.keyX,
        //     modifiers: [KeyModifier.alt],
        //     scope: HotKeyScope.inapp,
        //   ),
        //   keyDownHandler: (_) {
        //     if (Playback.instance.position <= Duration.zero) return;
        //     Playback.instance.seek(
        //       Playback.instance.position - Duration(seconds: 10),
        //     );
        //   },
        // ),
      ],
    );
  }

  Future<void> disableSpaceHotKey() async {
    await HotKeyManager.instance.unregister(_spaceHotkey);
  }

  Future<void> enableSpaceHotKey() async {
    await HotKeyManager.instance.register(
      _spaceHotkey,

      keyDownHandler: (_) =>  AudioControlClass.playOrPause(),
    );
  }
}

final _spaceHotkey = HotKey(
  KeyCode.space,
  scope: HotKeyScope.inapp,
);
