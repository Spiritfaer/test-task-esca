import 'package:flutter/material.dart';

import '../model/image.dart' as app;

class ItemScreen extends StatelessWidget {
  static const String routeName = '/item-screen';
  static const String screenName = 'Image screen';

  Widget _bodyBuilder(BuildContext context, route) {
    final app.Image image = route.settings.arguments as app.Image;
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Image.network(
            image.path,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 16,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.share),
            label: Text('Share'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null) {
      return SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        shadowColor: Color.fromARGB(0, 0, 0, 0),
      ),
      extendBodyBehindAppBar: true,
      body: _bodyBuilder(context, route),
    );
  }
}
