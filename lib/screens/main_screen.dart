import 'package:flutter/material.dart';

import '../widgets/image_grid.dart' as app;

class MainScreen extends StatelessWidget {
  static const String routeName = '/main-screen';
  static const String screenName = 'Test task for ESCA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(screenName)),
      body: app.ImageGrid(),
    );
  }
}
