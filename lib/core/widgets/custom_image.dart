import 'package:coffee/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final BoxShape shape;

  const CustomImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildPlaceholder();
    }

    if (imageUrl!.startsWith("http")) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: shape == BoxShape.circle ? null : borderRadius,
          shape: shape,
        ),
        child: _clip(
          child: Image.network(
            imageUrl!,
            width: width,
            height: height,
            fit: fit,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
          ),
        ),
      );
    }

    // Local Asset
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: shape == BoxShape.circle ? null : borderRadius,
        shape: shape,
        image: DecorationImage(
          image: AssetImage(imageUrl!),
          fit: fit,
          onError: (exception, stackTrace) {}, 
        ),
      ),
    );
  }

  Widget _clip({required Widget child}) {
    if (shape == BoxShape.circle) {
      return ClipOval(child: child);
    }
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: child,
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: shape == BoxShape.circle ? null : borderRadius,
        shape: shape,
      ),
      child: Center(
        child: Icon(
          Icons.coffee,
          color: AppColors.border,
          size: (width != null) ? width! / 3 : 24,
        ),
      ),
    );
  }
}
