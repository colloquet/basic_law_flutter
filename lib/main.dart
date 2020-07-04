import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:basic_law_flutter/store/main_model.dart';
import 'package:basic_law_flutter/store/settings_model.dart';
import 'package:basic_law_flutter/models/text_node.dart';
import 'package:basic_law_flutter/models/question.dart';
import 'package:basic_law_flutter/screens/app_screen.dart';

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
    final String userThemeMode = context.watch<SettingsModel>().themeMode;
    final double fontScale = context.watch<SettingsModel>().fontScale;
    ThemeMode themeMode;

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
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        sliderTheme: const SliderThemeData(
          valueIndicatorTextStyle: TextStyle(fontSize: 16),
          // thumbColor: Theme.of(context).accentColor,
        ),
        textTheme: Theme.of(context)
            .textTheme
            .merge(Typography.material2018().black)
            .apply(
              fontSizeFactor: fontScale,
            ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        sliderTheme: const SliderThemeData(
          valueIndicatorTextStyle: TextStyle(fontSize: 16),
        ),
        textTheme: Theme.of(context)
            .textTheme
            .merge(Typography.material2018().white)
            .apply(
              fontSizeFactor: fontScale,
            ),
      ),
      themeMode: themeMode,
      home: AppScreen(),
    );
  }
}
