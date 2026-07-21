import 'package:flutter/material.dart';

/// Simple lazy loading wrapper that renders content when scrolled into view
class LazySection extends StatefulWidget {
  final Widget child;
  final double minHeight;

  const LazySection({
    Key? key,
    required this.child,
    this.minHeight = 300.0,
  }) : super(key: key);

  @override
  State<LazySection> createState() => _LazySectionState();
}

class _LazySectionState extends State<LazySection> {
  bool _hasRendered = false;

  @override
  Widget build(BuildContext context) {
    if (_hasRendered) {
      return widget.child;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if section is in viewport
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          
          final renderObject = context.findRenderObject();
          if (renderObject == null) return;

          final renderBox = renderObject as RenderBox;
          final position = renderBox.localToGlobal(Offset.zero);
          final screenHeight = MediaQuery.of(context).size.height;

          // Render if within 200px of viewport
          if (position.dy < screenHeight + 200) {
            if (!_hasRendered) {
              setState(() => _hasRendered = true);
            }
          }
        });

        return SizedBox(
          height: widget.minHeight,
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }
}

/// Optimized image loader with caching
class OptimizedImage extends StatelessWidget {
  final String assetPath;
  final BoxFit? fit;
  final Alignment? alignment;
  final double? width;
  final double? height;

  const OptimizedImage({
    Key? key,
    required this.assetPath,
    this.fit,
    this.alignment,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      fit: fit,
      alignment: alignment ?? Alignment.center,
      width: width,
      height: height,
      cacheWidth: width?.toInt(),
      cacheHeight: height?.toInt(),
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: const Icon(Icons.error_outline),
        );
      },
    );
  }
}
