

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CircularCachedNetwork extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const CircularCachedNetwork({
    super.key,
    required this.imageUrl,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: CachedNetworkImageProvider(imageUrl),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            radius: radius,
            backgroundImage: imageProvider,
          );
        },
        placeholder: (context, url) => CircularProgressIndicator(), // Placeholder
        errorWidget: (context, url, error) => Icon(Icons.error),    // Error Widget
      ),
    );
  }
}