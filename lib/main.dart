import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/image_provider.dart' as app;
import './screens/main_screen.dart' as app;
import './screens/item_screen.dart' as app;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<app.ImageProvider>(
      create: (context) => app.ImageProvider(),
      child: MaterialApp(
        title: 'Test task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.orange,
        ),
        routes: {
          Navigator.defaultRouteName: (ctx) => app.MainScreen(),
          app.ItemScreen.routeName: (ctx) => app.ItemScreen(),
        },
      ),
    );
  }
}
