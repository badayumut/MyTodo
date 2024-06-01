import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytodo/screens/home_screen.dart';
import 'package:mytodo/service/object_box.dart';
import 'package:mytodo/service/todo_notifier.dart';
import 'package:provider/provider.dart';

import 'model/models.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent));
  objectbox = await ObjectBox.create();
  runApp(
      MultiProvider(
          providers: [
    ChangeNotifierProvider(
      create: (context) => TodoNotifier(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<List<Todo>> _todoSubscription;

  @override
  void initState() {
    super.initState();

    _todoSubscription = objectbox.getTodos().listen((todos) {
      Provider.of<TodoNotifier>(context, listen: false).todos = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.transparent,
        useDivider: false,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: const CupertinoScrollBehavior(),
        title: 'MyTodo',
        darkTheme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blueAccent, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        themeMode: ThemeMode.light,
      ),
    );
  }
}
