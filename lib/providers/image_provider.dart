import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/image.dart' as app;

class ImageProvider with ChangeNotifier {
  List<app.Image> _items = [];
  final int pageSize = 10;
  final int maxPages = 5;
  int currentPage = 1;
  bool _isLoading = false;

  List<app.Image> get items => [..._items];
  bool get isLoading => _isLoading;

  app.Image _parsImage(Map<String, dynamic> imageData) {
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
  }

  List<app.Image> _updateItemWithNewImages(Map<String, dynamic> jsonData) {
    final length = jsonData['photos']['perpage'];
    final newItems = List.generate(length, (index) {
      return _parsImage(jsonData['photos']['photo'][index]);
    });
    return newItems;
  }

  Future<void> fetchImages() async {
    _isLoading = true;
    final Uri url = Uri.https('www.flickr.com', 'services/rest/', {
      'method': 'flickr.interestingness.getList',
      'api_key': 'a974e5257d5a0baef2fbf31fdb1c396e',
      'format': 'json',
    });
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('fetch error');
      }
      final jsonData =
          json.decode(response.body.substring(14, response.body.length - 1));
      _items = _updateItemWithNewImages(jsonData);
      print('fetch!');
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchNextImagesPage() async {
    _isLoading = true;
    final Uri url = Uri.https('www.flickr.com', 'services/rest/', {
      'method': 'flickr.interestingness.getList',
      'api_key': 'a974e5257d5a0baef2fbf31fdb1c396e',
      'format': 'json',
      'per_page': '$pageSize',
      'page': '$currentPage',
    });
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('fetchNextImagesPage error');
      }
      final jsonData = await json
          .decode(response.body.substring(14, response.body.length - 1));
      _items.addAll(_updateItemWithNewImages(jsonData));
      print('fetchNextImagesPage!');
      _isLoading = false;
      notifyListeners();
      currentPage++;
    } catch (error) {
      throw error;
    }
  }
}
