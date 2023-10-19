// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_downloader/image_downloader.dart';
// import 'package:get/get.dart';
// import 'package:open_file/open_file.dart';


// class FullScreen extends StatelessWidget {
//   String imgUrl;
//   FullScreen({super.key, required this.imgUrl});

// final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   Future<void> setWallpaperFromFile(
//       String wallpaperUrl, BuildContext context) async {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text("Downloading Started...")));
//     try {
//       // Saved with this method.
//       var imageId = await ImageDownloader.downloadImage(wallpaperUrl);
//       if (imageId == null) {
//         return;
//       }
//       // Below is a method of obtaining saved image information.
//       var fileName = await ImageDownloader.findName(imageId);
//       var path = await ImageDownloader.findPath(imageId);
//       var size = await ImageDownloader.findByteSize(imageId);
//       var mimeType = await ImageDownloader.findMimeType(imageId);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Downloaded Sucessfully"),
//         action: SnackBarAction(
//             label: "Open",
//             onPressed: () {
//               OpenFile.open(path);
//             }),
//       ));
//       print("IMAGE DOWNLOADED");
//     } on PlatformException catch (error) {
//       print(error);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Error Occured - $error")));
//     }
//   }
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: Container(

//         height:  MediaQuery.of(context).size.height,
//         width:  MediaQuery.of(context).size.width,

//         decoration: BoxDecoration(image: DecorationImage(
//           image: NetworkImage(imgUrl),
//           fit: BoxFit.cover
//         )),

//       ),


//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:open_file/open_file.dart';
//
// class FullScreen extends StatelessWidget {
//   String imgUrl;
//   FullScreen({super.key, required this.imgUrl});
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   Future<void> downloadAndSetWallpaper(String wallpaperUrl, BuildContext context) async {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Downloading Started...")));
//     try {
//       final response = await http.get(Uri.parse(wallpaperUrl));
//       if (response.statusCode == 200) {
//         final directory = await getApplicationDocumentsDirectory();
//         final filePath = '${directory.path}/downloaded_image.jpg';
//         File file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Downloaded Successfully"),
//           action: SnackBarAction(
//             label: "Open",
//             onPressed: () {
//               // Open the downloaded image.
//               // You can use OpenFile or any other method to open it.
//               OpenFile.open(filePath);
//             },
//           ),
//         ));
//
//         print("IMAGE DOWNLOADED");
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error downloading image")));
//       }
//     } catch (error) {
//       print(error);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Occurred - $error")));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           // Trigger the download function when the user taps on the image.
//           downloadAndSetWallpaper(imgUrl, context);
//         },
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: NetworkImage(imgUrl),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
//import 'package:gallery_saver/gallery_saver.dart';


class FullScreen extends StatelessWidget {
  String imgUrl;
  FullScreen({super.key, required this.imgUrl});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Future<void> downloadAndSetWallpaper(BuildContext context) async {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Downloading Started...")));
  //   try {
  //     final response = await http.get(Uri.parse(imgUrl));
  //     if (response.statusCode == 200) {
  //       final directory = await getApplicationDocumentsDirectory();
  //       final filePath = '${directory.path}/downloaded_image.jpg';
  //       File file = File(filePath);
  //       await file.writeAsBytes(response.bodyBytes);
  //
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text("Downloaded Successfully"),
  //         action: SnackBarAction(
  //           label: "Open",
  //           onPressed: () {
  //             OpenFile.open(filePath); // Open the downloaded image.
  //           },
  //         ),
  //       ));
  //
  //       print("IMAGE DOWNLOADED");
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error downloading image")));
  //     }
  //   } catch (error) {
  //     print(error);
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Occurred - $error")));
  //   }
  // }

  Future<void> downloadAndSetWallpaper(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Downloading Started...")));
    try {
      final response = await http.get(Uri.parse(imgUrl));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/downloaded_image.jpg';
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Save the image to the gallery.
        //await GallerySaver.saveImage(filePath);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Downloaded Successfully"),
          ),
        );

        print("IMAGE DOWNLOADED");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error downloading image")));
      }
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Occurred - $error")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Trigger the download function when the user taps on the image.
          downloadAndSetWallpaper(context);
        },
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String url = imgUrl;
                    await GallerySaver.saveImage(url);
                    // Trigger the download function when the user taps the button.
                    downloadAndSetWallpaper(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Set the button's background color to blue.
                  ),
                  child: Text("Download Image"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
