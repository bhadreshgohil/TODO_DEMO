





import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImageView extends StatelessWidget {
  const CustomImageView({Key? key, required this.uri, this.fit, this.placeholder, this.color}) : super(key: key);

  final String? uri;
  final BoxFit? fit;
  final Widget? placeholder;
  final Color? color;

  @override
  Widget build(BuildContext context) {

    final url = Uri.tryParse(uri ?? "");

    if(url?.isAbsolute == false) {
      return placeholder ?? Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(15)
          ),
          child: Icon(Icons.image_search,color: Colors.black,));
    }

    return CachedNetworkImage(
      fit: fit ?? BoxFit.cover,
      imageUrl: uri ?? "",

      placeholder: (context, url) => Center(child: Platform.isIOS ? const CupertinoActivityIndicator() :  CircularProgressIndicator(color: Colors.pinkAccent,strokeWidth: 1,)),
      errorWidget: (context, url, error) => placeholder ?? const Icon(Icons.error_outline_rounded),
      color: color,
    );


  }
}
