import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DispalyImageScreen extends StatefulWidget {
  const DispalyImageScreen({
    super.key,
    required this.image,
    this.isAsset = false,
    this.isNetwork = false,
    this.isfile = false,
  });

  final String image;
  final bool isNetwork, isfile, isAsset;

  @override
  State<DispalyImageScreen> createState() => _DispalyImageScreenState();
}

class _DispalyImageScreenState extends State<DispalyImageScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [],
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          "Full Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: PhotoViewGallery.builder(
        itemCount: 1,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: widget.isNetwork
                ? NetworkImage(widget.image)
                : widget.isfile
                    ? FileImage(File(widget.image))
                    : AssetImage(widget.image) as ImageProvider,
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(),
      ),
    );
  }

  @override
  void dispose() {
    // Restore the system UI mode when the widget is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    super.dispose();
  }
}
