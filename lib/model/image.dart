import 'package:flutter/foundation.dart';

class Image with ChangeNotifier {
  final String _url;
  final String _title;

  Image({
    required url,
    required title,
  })  : _url = url,
        _title = title;

  String get path => _url;
  String get title => _title;
}
