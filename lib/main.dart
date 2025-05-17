import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/utils/Resouces/ColorManager.dart';
import 'package:semester_system/utils/Resouces/ThemeManager.dart';
import 'package:semester_system/utils/mappableInitializer.init.dart';
import 'package:semester_system/utils/state_logger.dart';

import 'Router/MyRoutes.dart';
import 'firebase_options.dart';

void initializeFICMappers() {
  // This makes all mappers work with immutable collections
  MapperContainer.globals.useAll([
    // mapper for immutable lists
    SerializableMapper<IList, Object>.arg1(
      decode: IList.fromJson,
      encode: (list) => list.toJson,
      type: <E>(f) => f<IList<E>>(),
    ),
    // mapper for immutable maps
    SerializableMapper<IMap, Map<String, dynamic>>.arg2(
      decode: IMap.fromJson,
      encode: (map) => map.toJson,
      type: <Key, Val>(f) => f<IMap<Key, Val>>(),
    ),
    // mapper for immutable sets
    SerializableMapper<ISet, Object>.arg1(
      decode: ISet.fromJson,
      encode: (set) => set.toJson,
      type: <E>(f) => f<ISet<E>>(),
    ),
  ]);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeMappers();
  initializeFICMappers();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const bool USE_EMULATOR = false;

  if (USE_EMULATOR) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }

  runApp(const ProviderScope(
    observers: [StateLogger()],
    child: WarmUp(),
  ));
}

class WarmUp extends ConsumerStatefulWidget {
  const WarmUp({super.key});

  @override
  ConsumerState createState() => _WarmUpState();
}

class _WarmUpState extends ConsumerState<WarmUp> {
  bool warmedUp = false;

  @override
  Widget build(BuildContext context) {
    if (warmedUp) {
      runApp(const ProviderScope(
        observers: [StateLogger()],
        child: MyApp(),
      ));
    }
    var listenables = <ProviderListenable<AsyncValue<Object?>>>[];

    var states = listenables.map(ref.watch).toList();

    if (states.every((element) => element is AsyncData)) {
      Future(() => setState(() => warmedUp = true));
    }
    return FittedBox(
      child: Container(color: ColorManager.surface),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future(() async {});
    return MaterialApp.router(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Semester System',
        theme: ThemeManager.lightThemeData,
        routerConfig: ref.watch(myRoutesProvider));
  }
}
