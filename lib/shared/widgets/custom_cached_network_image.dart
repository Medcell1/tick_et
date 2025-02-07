import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color baseShimmerColor;
  final Color highlightShimmerColor;
  final Widget errorWidget;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.baseShimmerColor = Colors.white,
    this.highlightShimmerColor = Colors.grey,
    this.errorWidget = const Icon(Icons.error, color: Colors.red),
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: baseShimmerColor.withOpacity(0.3),
        highlightColor: highlightShimmerColor.withOpacity(0.6),
        child: Container(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      errorWidget: (context, url, error) => errorWidget,
    );
  }
}