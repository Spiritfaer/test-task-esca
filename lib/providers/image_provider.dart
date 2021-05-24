import 'package:flutter/material.dart';

import '../model/image.dart' as app;

class ImageProvider with ChangeNotifier {
  late List<app.Image> _items;

  ImageProvider() {
    int count = 0;
    _items = List.generate(
      100,
      (index) {
        count++;
        return count % 2 == 0
            ? app.Image(
                url:
                    'https://www.hdnicewallpapers.com/Walls/Big/Elephant/Big_Animal_Elephant_Pic_Download.jpg',
                title: 'Elephant',
              )
            : app.Image(
                url:
                    'https://fr.cdn.v5.futura-sciences.com/buildsv6/images/wide1920/1/f/b/1fbd02197c_88149_zebre.jpg',
                title: 'Zebre',
              );
      },
    );
  }

  ImageProvider.rawData() {}

  List<app.Image> get items => [..._items];
}
