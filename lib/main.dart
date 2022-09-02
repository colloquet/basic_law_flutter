import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/question.dart';
import 'models/text_node.dart';
import 'screens/app_screen.dart';
import 'store/main_model.dart';
import 'store/settings_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  final List<String> assets = await Future.wait(<Future<String>>[
    rootBundle.loadString('assets/basic-law.json'),
    rootBundle.loadString('assets/questions.json'),
  ]);

  final List<TextNode> _basicLawText = json
      .decode(assets[0])
      .map<TextNode>((dynamic json) => TextNode.fromJson(json))
      .toList();

  final List<Question> _questions = json
      .decode(assets[1])
      .map<Question>((dynamic json) => Question.fromJson(json))
      .toList();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String themeMode = prefs.getString('themeMode') ?? 'system';
  final double fontScale = prefs.getDouble('fontScale') ?? 1;

  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        Provider<MainModel>(
          create: (_) => MainModel(
            basicLawText: _basicLawText,
            questions: _questions,
          ),
        ),
        ChangeNotifierProvider<SettingsModel>(
          create: (_) => SettingsModel(
            defaultThemeMode: themeMode,
            defaultFontScale: fontScale,
          ),
        ),
      ],
      child: BasicLawApp(),
    ),
  );
}

class BasicLawApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final String userThemeMode = context.watch<SettingsModel>().themeMode;
    final double fontScale = context.watch<SettingsModel>().fontScale;

    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: Colors.red,
      indicatorColor: Colors.red,
      toggleableActiveColor: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.white,
      sliderTheme: const SliderThemeData(
        valueIndicatorTextStyle: TextStyle(fontSize: 16),
      ),
      primaryTextTheme:
          Theme.of(context).textTheme.merge(Typography.material2021().black),
      textTheme: Theme.of(context)
          .textTheme
          .merge(Typography.material2021().black)
          .apply(
            fontSizeFactor: fontScale,
          ),
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: Colors.red,
      indicatorColor: Colors.red,
      toggleableActiveColor: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      sliderTheme: const SliderThemeData(
        valueIndicatorTextStyle: TextStyle(fontSize: 16),
      ),
      primaryTextTheme:
          Theme.of(context).textTheme.merge(Typography.material2021().white),
      textTheme: Theme.of(context)
          .textTheme
          .merge(Typography.material2021().white)
          .apply(
            fontSizeFactor: fontScale,
          ),
    );

    ThemeMode themeMode = ThemeMode.system;
    if (userThemeMode == 'system') {
      themeMode = ThemeMode.system;
    } else if (userThemeMode == 'dark') {
      themeMode = ThemeMode.dark;
    } else if (userThemeMode == 'light') {
      themeMode = ThemeMode.light;
    }

    return MaterialApp(
      title: '香港基本法',
      debugShowCheckedModeBanner: false,
      theme: lightTheme.copyWith(
        colorScheme: lightTheme.colorScheme.copyWith(
          secondary: Colors.red,
        ),
      ),
      darkTheme: darkTheme.copyWith(
        colorScheme: darkTheme.colorScheme.copyWith(
          secondary: Colors.red,
        ),
      ),
      themeMode: themeMode,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
        ),
        child: AppScreen(),
      ),
    );
  }
}
