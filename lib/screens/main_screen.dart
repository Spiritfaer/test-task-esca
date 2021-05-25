import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_grid.dart' as app;
import '../providers/image_provider.dart' as app;

class MainScreen extends StatefulWidget {
  static const String routeName = '/main-screen';
  static const String screenName = 'Test task for ESCA';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
      Provider.of<app.ImageProvider>(context, listen: false)
          .fetchImages()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(MainScreen.screenName)),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : app.ImageGrid(),
    );
  }
}
