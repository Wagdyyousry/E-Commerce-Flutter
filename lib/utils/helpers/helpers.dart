import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MyHelpers {
  MyHelpers._();
  static double myRedmiHeight = 803.63,
      myRedmiWidth = 392.72,
      myEmulatorHeight = 640.0,
      myEmulatorWidth = 360.0;

  static Color? getColor(String value) {
    /// --- Define your product specific colors
    if (value == 'green') {
      return Colors.green;
    } else if (value == 'lightGreen') {
      return Colors.lightGreen;
    } else if (value == 'darkGreen') {
      return const Color.fromARGB(255, 13, 44, 15);
    } else if (value == 'red') {
      return Colors.red;
    } else if (value == 'lightRed') {
      return const Color.fromARGB(255, 236, 92, 81);
    } else if (value == 'darkRed') {
      return const Color.fromARGB(255, 73, 13, 8);
    } else if (value == 'blue') {
      return Colors.blue;
    } else if (value == 'lightBlue') {
      return const Color.fromARGB(255, 79, 166, 238);
    } else if (value == 'darkBlue') {
      return const Color.fromARGB(255, 7, 47, 79);
    } else if (value == 'pink') {
      return Colors.pink;
    } else if (value == 'darkPink') {
      return const Color.fromARGB(255, 73, 6, 28);
    } else if (value == 'lightPink') {
      return const Color.fromARGB(255, 232, 76, 128);
    } else if (value == 'grey') {
      return Colors.grey;
    } else if (value == 'darkGrey') {
      return const Color.fromARGB(255, 83, 83, 83);
    } else if (value == 'lightGrey') {
      return const Color.fromARGB(255, 176, 176, 176);
    } else if (value == 'purple') {
      return Colors.purple;
    } else if (value == 'lightPurple') {
      return const Color.fromARGB(255, 207, 77, 230);
    } else if (value == 'darkPurple') {
      return const Color.fromARGB(255, 77, 10, 89);
    } else if (value == 'black') {
      return Colors.black;
    } else if (value == 'white') {
      return Colors.white;
    } else if (value == 'yellow') {
      return const Color.fromARGB(255, 233, 214, 39);
    } else if (value == 'lightYellow') {
      return const Color.fromARGB(255, 246, 229, 80);
    } else if (value == 'darkYellow') {
      return const Color.fromARGB(255, 91, 82, 8);
    } else if (value == 'orange') {
      return Colors.deepOrange;
    } else if (value == 'lightOrange') {
      return const Color.fromARGB(255, 224, 105, 69);
    } else if (value == 'darkOrange') {
      return const Color.fromARGB(255, 141, 42, 12);
    } else if (value == 'brown') {
      return Colors.brown;
    } else if (value == 'lightBrown') {
      return const Color.fromARGB(255, 156, 84, 57);
    } else if (value == 'darkBrown') {
      return const Color.fromARGB(255, 65, 33, 21);
    } else if (value == 'teal') {
      return Colors.teal;
    } else if (value == 'lightTeal') {
      return const Color.fromARGB(255, 73, 238, 221);
    } else if (value == 'darkTeal') {
      return const Color.fromARGB(255, 8, 80, 73);
    } else if (value == 'indigo') {
      return Colors.indigo;
    } else if (value == 'lightIndigo') {
      return const Color.fromARGB(255, 100, 120, 232);
    } else if (value == 'darkIndigo') {
      return const Color.fromARGB(255, 22, 30, 70);
    } else {
      return null;
    }
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static void showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(title),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop,
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}.....';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static List<T> removeDublicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static double getResponsiveHeight(double height) {
    double percent = height / myEmulatorHeight;

    double resHeight = percent * getScreenHeight(Get.context!);
    //print("=== real ==> |$height| responsive ==> |$resHeight|");
    return resHeight;
  }

  static double getResponsiveWidth(double width) {
    double percent = width / myEmulatorWidth;

    double resWidth = percent * getScreenWidth(Get.context!);

    //print("=== real ==> |$width| responsive ==> |$resWidth|");

    return resWidth;
  }

  static Future cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop The Image',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: Get.context!,
        ),
      ],
    );
    if (croppedFile != null) {
      return croppedFile;
    }
  }

  static void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        content: Center(child: Text(' $text \n Copied to clipboard')),
        elevation: 5,
      ),
    );
  }

  static Future pickImageFromGallery(bool cropImage) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // -- Crop the image
      if (cropImage) {
        final croppedFile = await MyHelpers.cropImage(File(pickedFile.path));
        if (croppedFile != null) {
          return croppedFile.path;
        } else {
          return pickedFile.path;
        }
      }
      // -- Don't Crop the Image
      else {
        return pickedFile.path;
      }
    }
  }
}
