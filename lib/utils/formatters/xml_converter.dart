import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:ecommerce/presentation/widgets/common/custom_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/rendering.dart';

class XMLConverter extends StatefulWidget {
  const XMLConverter({super.key});

  @override
  State<XMLConverter> createState() => _XMLConverterState();
}

class _XMLConverterState extends State<XMLConverter> {
  String xmlContent = '';
  Uint8List? imageBytes;
  @override
  void initState() {
    super.initState();
    loadXML();
  }

  Future<void> loadXML() async {
    // Load XML content
    String content = await rootBundle.loadString('assets/images/ic_woman.xml');
    setState(() {
      xmlContent = content;
    });
  }

  Future<Uint8List?> captureWidgetToImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XML to Image'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            CustomRoundedContainer(
              height: 150,
              width: 150,
              enableBorder: true,
              child: imageBytes != null ? Image.memory(imageBytes!) : null,
            ),
            xmlContent.isNotEmpty
                ? RepaintBoundary(
                    key: GlobalKey(),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          xmlContent,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  )
                : const CircularProgressIndicator(),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          imageBytes = await captureWidgetToImage(GlobalKey());

          if (imageBytes != null) {
            // Use imageBytes to display or save the image
            setState(() {
              imageBytes = generateImageBytes();
            });
            //print('Image captured!');
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Uint8List generateImageBytes() {
    // Example: Create a 100x100 pixel PNG image with a red square
    const width = 100;
    const height = 100;
    const color = Colors.red;
    final pngBytes =
        Uint8List.fromList(List<int>.filled(4 * width * height, 0));

    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        final pixelPos = 4 * (y * width + x);
        pngBytes[pixelPos] = color.red;
        pngBytes[pixelPos + 1] = color.green;
        pngBytes[pixelPos + 2] = color.blue;
        pngBytes[pixelPos + 3] = color.alpha;
      }
    }

    return pngBytes;
  }
}
