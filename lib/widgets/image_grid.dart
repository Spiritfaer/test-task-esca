import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_item.dart' as app;
import '../providers/image_provider.dart' as app;

class ImageGrid extends StatefulWidget {
  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  late app.ImageProvider imageProvider;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    imageProvider = Provider.of<app.ImageProvider>(context, listen: false);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        print('end');
        setState(() {
          imageProvider.fetchNextImagesPage();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    imageProvider = Provider.of<app.ImageProvider>(context);
    final imagesList = imageProvider.items;
    print(imagesList.length);
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      itemCount: imagesList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: imagesList[index],
        child: app.ImageItem(),
      ),
    );
  }
}
