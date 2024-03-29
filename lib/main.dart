import 'dart:io';
import 'package:drip/datasources/audiofiles/playback.dart';
import 'package:drip/datasources/searchresults/local_models/recently_played.dart';
import 'package:drip/datasources/searchresults/local_models/saved_playlist.dart';
import 'package:drip/home.dart';
import 'package:drip/home_screen.dart';
import 'package:drip/pages/common/hot_keys.dart';
import 'package:drip/pages/splash_screen.dart';
import 'package:drip/providers/audio_player_provider.dart';
import 'package:drip/test/playbacktest.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as acrylic;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:media_kit/media_kit.dart';

import 'package:path_provider/path_provider.dart';

import 'package:system_theme/system_theme.dart';

import 'package:url_strategy/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:window_manager/window_manager.dart';

import 'datasources/searchresults/local_models/tracks_local.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;


const String appTitle = 'Drip';

bool darkMode = true;

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.linux,
    TargetPlatform.macOS,
    TargetPlatform.windows,
  ].contains(defaultTargetPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // if (kIsWeb ||
  //     [TargetPlatform.windows, TargetPlatform.android]
  //         .contains(defaultTargetPlatform)) {
  //   SystemTheme.accentColor.load();
  // }

  setPathUrlStrategy();

  try {
    if (Platform.isWindows) {
      await WindowManager.instance.ensureInitialized();
      await acrylic.Window.initialize();

      MediaKit.ensureInitialized();


      WindowOptions windowOptions = const WindowOptions(
          size: Size(900, 650),
          minimumSize: Size(940, 600),
          center: true,
          //   backgroundColor: Colors.transparent,
          skipTaskbar: false,
          titleBarStyle: TitleBarStyle.hidden,
          windowButtonVisibility: false,
          title: appTitle
      );

      windowManager.waitUntilReadyToShow(
          windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      }
      );
    }

    await hotKeyManager.unregisterAll();
    await HotKeys.initialize();
    await Hive.initFlutter('Drip');
    await initHive();
    await openHiveBox('cache', limit: true);

    await openHiveBox('settings');
    Hive.registerAdapter(RecentlyPlayedAdapter());
    Hive.registerAdapter(SavedPlayListAdapter());
    Hive.registerAdapter(TrackAdapter());
    await openHiveBox('recentlyPlayed');
   await openHiveBox('savedPlaylists');
    await AudioControlCentre.initialize();


    runApp(const ProviderScope(
      // overrides: [audioControlCentreProvider.overrideWith((ref) {
      //   final player = ref.watch(audioPlayerProvider);
      //   final audioControlCentre = AudioControlCentre(player: player, ref: ref);
      //   return audioControlCentre;
      // })
      // ],
        child: StartPage()));
  } catch (exception, stacktrace) {
    debugPrint(exception.toString());
    debugPrint(stacktrace.toString());
  }

  // if (isDesktop) {
  //   await acrylic.Window.initialize();
  //
  //   //await acrylic.Window.setEffect(effect: WindowEffect.tabbed,);
  //
  //   await WindowManager.instance.ensureInitialized();
  //
  //   WindowOptions windowOptions = const WindowOptions(
  //       size: Size(900, 650),
  //       minimumSize: Size(740, 600),
  //       center: true,
  //       //   backgroundColor: Colors.transparent,
  //       skipTaskbar: false,
  //       titleBarStyle: TitleBarStyle.hidden,
  //       windowButtonVisibility: false,
  //       title: appTitle
  //   );
  //
  //   windowManager.waitUntilReadyToShow(
  //       windowOptions, () async {
  //     await windowManager.show();
  //     await windowManager.focus();
  //   }
  //   );
  //   // windowManager.waitUntilReadyToShow().then((_) async {
  //   //   // await windowManager.setTitleBarStyle(TitleBarStyle.hidden,
  //   //   //     windowButtonVisibility: false);
  //   //
  //   //   // await windowManager.setSize(const Size(900, 650));
  //   //   // await windowManager.setMinimumSize(const Size(740, 600));
  //   //
  //   //   await windowManager.show();
  //   //   // await windowManager.setPreventClose(false);
  //   //   // await windowManager.setSkipTaskbar(false);
  //   // });
  // }

  // if (Platform.isWindows) {
  //   await hotKeyManager.unregisterAll();
  //   await HotKeys.initialize();
  //   await Hive.initFlutter('Drip');
  // } else {
  //   await Hive.initFlutter();
  // }


  // await AudioControlCentre.initializePlayback();


  // if (Platform.isWindows) {
  //   await acrylic.Window.initialize();
  //   hotKeyManager.unregisterAll();
  //   await HotKeys.initialize();
  // }
  //await Window.initialize();
  //WidgetsFlutterBinding.ensureInitialized();


  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) {
      return stack
          .toTrace()
          .vmTrace;
    }
    return stack;
  };
}
Future<void> initHive() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('cacheBox');
}
Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirPath = dir.path;
    File dbFile = File('$dirPath/$boxName.hive');
    File lockFile = File('$dirPath/$boxName.lock');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      dbFile = File('$dirPath/drip/$boxName.hive');
      lockFile = File('$dirPath/drip/$boxName.lock');
    }
    await dbFile.delete();
    await lockFile.delete();
    await Hive.openBox(boxName);
    throw 'Failed to open $boxName Box\nError: $error';
  });

  if (limit && box.length > 500) {
    box.clear();
  }
}





