import 'package:eksafar/models/app_state.dart';
import 'package:eksafar/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  final Store<AppState> store;
  const App({super.key, required this.store});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child:MaterialApp(
          title: 'Eksafar',
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.teal,
            useMaterial3: true
          ),
          themeMode: ThemeMode.dark,
          home: const MainScreen(),
        )
    );
  }
}
