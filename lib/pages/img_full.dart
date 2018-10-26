import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageFullScreen extends StatelessWidget {
  final String imagemUrl;

  ImageFullScreen({this.imagemUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // appBar: new AppBar(),
      body: Stack(
        children: <Widget>[
          _getDecoratedImage(),
          _closeButton(context),
        ],
      ),
    );
  }

  Container _getDecoratedImage() {
    return Container(
          constraints: BoxConstraints.expand(),
          alignment: Alignment(0.0, 0.0),
          decoration: BoxDecoration(
            color: Colors.black87,
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 8.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: _getImage(),
          ),
        );
  }

  CachedNetworkImage _getImage() {
    return CachedNetworkImage(
              imageUrl: this.imagemUrl,
              placeholder: Image.asset('assets/images/placeholder-image.png'),
              fit: BoxFit.contain,
              errorWidget: new Icon(Icons.error),
            );
  }

  Positioned _closeButton(BuildContext context) {
    return Positioned(
          left: 25.0,
          top: 25.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).maybePop();
            },
            child: Icon(
              Icons.close,
              color: Color(0xFFFFFFFF),
              size: 24.0,
            ),
          ),
        );
  }
}

class Zoom extends CachedNetworkImage {}
