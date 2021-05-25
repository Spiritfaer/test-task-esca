import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/image.dart' as app;

class ImageProvider with ChangeNotifier {
  late List<app.Image> _items;

  ImageProvider() {}

  // ImageProvider.rawData() {}

  List<app.Image> get items => [..._items];

  List<app.Image> _updateItemWithNewImages(Map<String, dynamic> jsonData) {
    final length = jsonData['photos']['perpage'];
    final newItems = List.generate(length, (index) {
      if (index % 5 == 0) {
        return app.Image(
          title: 'Empty',
          urlPreview: 'assets/images/no-image.png',
          url: 'assets/images/no-image.png',
        );
      }
      final imageData = jsonData['photos']['photo'][index];
      final imageTitle = imageData['title'];
      final imageServerId = imageData['server'];
      final imageId = imageData['id'];
      final imageSecret = imageData['secret'];
      final imageUrlPreview =
          'https://live.staticflickr.com/$imageServerId/$imageId\_$imageSecret.jpg';
      final imageUrl = '';
      return app.Image(
        title: imageTitle,
        url: imageUrl,
        urlPreview: imageUrlPreview,
      );
    });
    return newItems;
  }

  Future<void> fetchImages() async {
    final Uri url = Uri.https('www.flickr.com', 'services/rest/', {
      'method': 'flickr.interestingness.getList',
      'api_key': 'a974e5257d5a0baef2fbf31fdb1c396e',
      'format': 'json',
    });
    // print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('fetch error');
      }
      final jsonData =
          json.decode(response.body.substring(14, response.body.length - 1));
      _items = _updateItemWithNewImages(jsonData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
