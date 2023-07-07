import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {

  final String? imageURL;
  final double? width;
  final double height;
  final BoxFit fitImageNetWork;
  final BoxFit fitImageError;

  const ImageWidget({
    super.key,
    this.width,
    required this.imageURL,
    this.height = double.infinity,
    this.fitImageError = BoxFit.fill,
    this.fitImageNetWork = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
   return imageURL != null
   ? FadeInImage.assetNetwork(
    placeholder: 'assets/gifs/loader.gif',
    image: imageURL!,
    fit: fitImageNetWork,
    width: width,
    height: height,
    imageErrorBuilder: (context, error, stackTrace) {
     return Image.asset(
      'assets/images/no-image.jpg',
      width: width,
      height: height,
      fit: fitImageError,
     );
    },
   )
   : Image.asset(
     'assets/images/no-image.jpg',
     width: width,
     height: height,
     fit: fitImageError,
    );
  }
}