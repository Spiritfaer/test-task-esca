import 'package:flutter/foundation.dart';

class Image with ChangeNotifier {
  final String _urlPreview;
  final String _url;
  final String _title;

  Image({
    required urlPreview,
    required url,
    required title,
  })  : _urlPreview = urlPreview,
        _url = url,
        _title = title;

  String get pathPreview => _urlPreview;
  String get path => _url;
  String get title => _title;
}
