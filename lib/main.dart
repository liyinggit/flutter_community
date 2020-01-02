import 'package:flutter/material.dart';
import 'package:flutter_community/stores/ThemeState.dart';
import 'package:flutter_community/ui/App.dart';
import 'package:provider/provider.dart';

import 'common/Global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final initThemeData = ThemeData(
      //初始主题
      primaryColor: Colors.blue,
    );

    //这个包裹了状态
    return MultiProvider(
      providers: [//在这提供provider
        ChangeNotifierProvider(
          builder: (_) => ThemeState(initThemeData),
        )
      ],
      child: App(),
    );
  }
}
