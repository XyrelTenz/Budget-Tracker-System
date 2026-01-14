import 'package:flutter/material.dart';

// Libraries
import 'package:flutter_native_splash/flutter_native_splash.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

// Theme
import "core/theme/theme.dart";
import "core/routes/app_router.dart";
import "core/theme/theme_provider.dart";

void main() {
  //Initialize Widget Before Render
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final currentMode = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentMode,

      routerConfig: router,
    );
  }
}
