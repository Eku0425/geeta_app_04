import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

import 'dart:ui' as ui;

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';

import '../provider/detail.dart';
import '../provider/geeta_provider.dart';
import '../utils/gobal.dart';

Random random = Random();
int x = random.nextInt(ImageList.length);

GlobalKey editimgKey = GlobalKey();

class SingleScreen extends StatelessWidget {
  const SingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Geetaprovider gitaprovider = Provider.of(context, listen: false);
    DetailProvider detailProviderture = Provider.of(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop('/de');
            },
            child: Icon(Icons.arrow_back)),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: editimgKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      alignment: Alignment.center,
                      height: 700,
                      width: 380,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(ImageList[x]),
                      )),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250,
                          ),
                          Text(
                            (detailProviderture.selectedLanguage == 'Sanskrit')
                                ? gitaprovider.Geetalist[selectedIndex]
                                    .chapterName.sanskrit
                                : (detailProviderture.selectedLanguage ==
                                        'Hindi')
                                    ? gitaprovider.Geetalist[selectedIndex]
                                        .chapterName.hindi
                                    : (detailProviderture.selectedLanguage ==
                                            'English')
                                        ? Geetaprovider()
                                            .Geetalist[selectedIndex]
                                            .chapterName
                                            .english
                                        : gitaprovider.Geetalist[selectedIndex]
                                            .chapterName.gujarati,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 36,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            (detailProviderture.selectedLanguage == 'Sanskrit')
                                ? gitaprovider.Geetalist[selectedIndex]
                                    .verses[singleShlokIndex].language.sanskrit
                                : (detailProviderture.selectedLanguage ==
                                        'Hindi')
                                    ? gitaprovider.Geetalist[selectedIndex]
                                        .verses[singleShlokIndex].language.hindi
                                    : (detailProviderture.selectedLanguage ==
                                            'English')
                                        ? gitaprovider
                                            .Geetalist[selectedIndex]
                                            .verses[singleShlokIndex]
                                            .language
                                            .english
                                        : gitaprovider
                                            .Geetalist[selectedIndex]
                                            .verses[singleShlokIndex]
                                            .language
                                            .gujarati,
                            style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  boxcat(
                    InkWell(
                      onTap: () async {
                        RenderRepaintBoundary boundary =
                            editimgKey.currentContext!.findRenderObject()
                                as RenderRepaintBoundary;

                        ui.Image image = await boundary.toImage();
                        ByteData? bytedata = await image.toByteData(
                            format: ui.ImageByteFormat.png);
                        Uint8List img = bytedata!.buffer.asUint8List();

                        final path = await getApplicationDocumentsDirectory();
                        File file = File("${path.path}/img.jpg");
                        file.writeAsBytes(img);
                        ShareExtend.share(file.path, "image");
                      },
                      child: Icon(
                        Icons.share,
                        size: 24,
                      ),
                    ),
                    'Share',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  boxcat(
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.teal.shade50,
                              title: Text(
                                ' Set Wallpaper ?',
                                style: TextStyle(),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'No',
                                      style: TextStyle(color: Colors.black),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      RenderRepaintBoundary boundary =
                                          editimgKey.currentContext!
                                                  .findRenderObject()
                                              as RenderRepaintBoundary;

                                      ui.Image image = await boundary.toImage();
                                      ByteData? bytedata =
                                          await image.toByteData(
                                              format: ui.ImageByteFormat.png);
                                      Uint8List img =
                                          bytedata!.buffer.asUint8List();

                                      final path =
                                          await getApplicationDocumentsDirectory();
                                      File file = File("${path.path}/img.jpg");
                                      file.writeAsBytes(img);
                                      ShareExtend.share(file.path, "image");
                                      int location = WallpaperManager
                                          .BOTH_SCREEN; //can be Home/Lock Screen
                                      bool result = await WallpaperManager
                                          .setWallpaperFromFile(
                                              file.path, location);
                                      Navigator.pop(context);
                                      //
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.black),
                                    ))
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.wallpaper,
                        size: 24,
                      ),
                    ),
                    'Wallpaper',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  boxcat(
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.teal.shade50,
                              title: Text(
                                ' Save ?',
                                style: TextStyle(color: Colors.black),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Back',
                                      style: TextStyle(color: Colors.black),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      RenderRepaintBoundary boundary =
                                          editimgKey.currentContext!
                                                  .findRenderObject()
                                              as RenderRepaintBoundary;

                                      ui.Image image = await boundary.toImage();
                                      ByteData? bytedata =
                                          await image.toByteData(
                                              format: ui.ImageByteFormat.png);
                                      Uint8List img =
                                          bytedata!.buffer.asUint8List();
                                      ImageGallerySaver.saveImage(img);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Save',
                                      style: TextStyle(color: Colors.black),
                                    ))
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.file_download_outlined,
                        size: 24,
                      ),
                    ),
                    'Save',
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Column boxcat(
  i1,
  String name,
) {
  return Column(
    children: [
      Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: i1,
      ),
      Text(name)
    ],
  );
}

int singleShlokIndex = 0;
