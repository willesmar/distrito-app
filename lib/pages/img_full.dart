import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageFullScreen extends StatelessWidget {
  final imagemUrl;

  ImageFullScreen({this.imagemUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  // color: Colors.black54,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 8.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: CachedNetworkImage(
                  imageUrl: imagemUrl,
                  placeholder:
                      Image.asset('assets/images/placeholder-image.png'),
                  fit: BoxFit.contain,
                  errorWidget: new Icon(Icons.error),
                ),
              ),
            ]),
      ),
      // ),
    );
  }
}

class Zoom extends CachedNetworkImage {

}
