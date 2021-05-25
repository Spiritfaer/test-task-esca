import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/item_screen.dart' as app;
import '../model/image.dart' as app;
import '../model/constants.dart' as app;

class ImageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app.Image _image = Provider.of<app.Image>(context);
    return GestureDetector(
      onTap: () {
        if (_image.pathPreview != app.plaseHolder) {
          Navigator.pushNamed(context, app.ItemScreen.routeName,
              arguments: _image);
        }
      },
      child: Container(
        height: 150,
        width: 150,
        child: CachedNetworkImage(
          imageUrl: _image.pathPreview,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Container(
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
