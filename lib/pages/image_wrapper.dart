import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './img_full.dart';

class ImageWrapper extends StatelessWidget {
  final String imagemUrl;
  final String placeholderImgUrl;
  final BoxFit boxFit;
  final bool fullscreenDialog;
  final Widget child;

  ImageWrapper(
      {Key key,
      @required this.imagemUrl,
      this.placeholderImgUrl = 'assets/images/placeholder-image.png',
      this.boxFit = BoxFit.cover,
      this.fullscreenDialog = true,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return ImageFullScreen(imagemUrl: imagemUrl);
          },
          fullscreenDialog: fullscreenDialog,
        ));
      },
      child: SafeArea(
        child: CachedNetworkImage(
          imageUrl: imagemUrl,
          placeholder: Image.asset(placeholderImgUrl),
          fit: boxFit,
          errorWidget: new Icon(Icons.error),
        ),
      ),
    );
  }
}
