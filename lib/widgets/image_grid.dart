import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_item.dart' as app;
import '../providers/image_provider.dart' as app;

class ImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imagesList =
        Provider.of<app.ImageProvider>(context, listen: false).items;

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: imagesList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
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
