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

  Widget _helpBuilder(app.ImageProvider imageProvider) {
    if (imageProvider.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (imageProvider.isEnded) {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(child: Text('You saw all images')),
      );
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    imageProvider = Provider.of<app.ImageProvider>(context);
    final imagesList = imageProvider.items;
    return CustomScrollView(controller: _scrollController,
        // shrinkWrap: true,
        slivers: [
          SliverGrid.count(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            children: [
              ...imagesList.map((e) => app.ImageItem(e)).toList(),
            ],
          ),
          SliverToBoxAdapter(
            child: _helpBuilder(imageProvider),
          ),
        ]);
  }
}
