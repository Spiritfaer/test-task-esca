import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/item_screen.dart' as app;
import '../model/image.dart' as app;

class ImageItem extends StatelessWidget {
  final app.Image image;
  ImageItem(this.image);

  @override
  Widget build(BuildContext context) {
    // final app.Image _image = Provider.of<app.Image>(context);
    return GestureDetector(
      onTap: () {
        //TODO add behavior without image
        Navigator.pushNamed(context, app.ItemScreen.routeName,
            arguments: image);
      },
      child: Container(
        height: 150,
        width: 150,
        child: CachedNetworkImage(
          imageUrl: image.pathPreview,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Container(
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
