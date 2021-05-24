import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/item_screen.dart' as app;
import '../model/image.dart' as app;

class ImageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app.Image _image = Provider.of<app.Image>(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, app.ItemScreen.routeName,
            arguments: _image);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            width: 1,
            color: Theme.of(context).primaryColor,
          ),
        ),
        height: 150,
        width: 150,
        child: Image.network(
          _image.path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
