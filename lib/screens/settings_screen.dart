import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:basic_law_flutter/store/settings_model.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String themeMode = context.watch<SettingsModel>().themeMode;
    final double fontScale = context.watch<SettingsModel>().fontScale;
    final List<String> themeModeList = <String>['system', 'dark', 'light'];
    final List<double> fontScaleList = <double>[0.6, 0.8, 1, 1.2, 1.4];
    final Map<String, String> themeModeNameMap = <String, String>{
      'system': '系統默認',
      'dark': '深色模式',
      'light': '淺色模式',
    };

    String _getFontScaleLabel(double _fontScale) {
      if (_fontScale == 0.6) {
        return '最小';
      } else if (_fontScale == 0.8) {
        return '較小';
      } else if (_fontScale == 1) {
        return '中等';
      } else if (_fontScale == 1.2) {
        return '較大';
      } else {
        return '最大';
      }
    }

    // ignore: avoid_void_async
    void _launchAbout() async {
      const String url = 'https://basiclaw.hk/about';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
              child: Row(
                children: <Widget>[
                  Text(
                    '顯示',
                    style: textTheme.subtitle2
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () async {
                final String _themeMode = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text('外觀設定'),
                        children: <Widget>[
                          ...themeModeList.map((String mode) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, mode);
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: <Widget>[
                                      Radio(
                                        value: mode,
                                        groupValue: themeMode,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (String value) {
                                          Navigator.pop(context, value);
                                        },
                                      ),
                                      Text(themeModeNameMap[mode]),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    });

                if (_themeMode != null) {
                  context.read<SettingsModel>().updateThemeMode(_themeMode);
                }
              },
              title: const Text('外觀設定'),
              subtitle: Text(themeModeNameMap[themeMode]),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.3),
                foregroundColor: Theme.of(context).accentColor.withOpacity(0.7),
                child: Icon(Icons.brightness_4),
              ),
            ),
            ListTile(
              onTap: () async {
                final double _fontScale = await showDialog<double>(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text('字型大小'),
                        children: <Widget>[
                          ...fontScaleList.map((double scale) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, scale);
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: <Widget>[
                                      Radio(
                                        value: scale,
                                        groupValue: fontScale,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (double value) {
                                          Navigator.pop(context, value);
                                        },
                                      ),
                                      Text(_getFontScaleLabel(scale)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    });

                if (_fontScale != null) {
                  context.read<SettingsModel>().updateFontScale(_fontScale);
                }
              },
              title: const Text('字型大小'),
              subtitle: Text(_getFontScaleLabel(fontScale)),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.3),
                foregroundColor: Theme.of(context).accentColor.withOpacity(0.7),
                child: Icon(Icons.format_size),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
              child: Row(
                children: <Widget>[
                  Text(
                    '其他',
                    style: textTheme.subtitle2
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: _launchAbout,
              title: const Text('關於此程式'),
              subtitle: const Text('香港基本法'),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.3),
                foregroundColor: Theme.of(context).accentColor.withOpacity(0.7),
                child: Icon(Icons.info_outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
