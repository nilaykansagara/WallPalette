import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/photosModel.dart';
import 'package:wallpaper_app/model/categoryModel.dart';
import 'dart:math';


class ApiOperations{
  static List <PhotosModel> tredingWallpapers = [];
  static List <PhotosModel> searchWallpapersList = [];
  static List<CategoryModel> cateogryModelList = [];

static String _apiKey =
      "TMxveC9nSC79bCKH5NzqPJhaj1VsGNvpqOcmURCJkZMh3TwkQsEwCbkN";
  static Future<List <PhotosModel>> getTrendingWallpapers() async{

    await http.get(
        Uri.parse("https://api.pexels.com/v1/curated"),
        headers: {"Authorization":"$_apiKey"}

        ).then((value){
          print("RESPONSE REPORT");
          print(value.body);
          Map<String,dynamic> jsonData = jsonDecode(value.body);
          List photos = jsonData['photos'];
          photos.forEach((element) {
            tredingWallpapers.add(PhotosModel.fromAPI2App(element));
          });
    });
    return tredingWallpapers;
  }
  static Future<List <PhotosModel>>searchWallpapers(String query) async{
    await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {"Authorization":"$_apiKey"}

    ).then((value){
      Map<String,dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();
      photos.forEach((element) {
        searchWallpapersList.add(PhotosModel.fromAPI2App(element));

      });
    });
    return searchWallpapersList;
  }


static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      PhotosModel photoModel =
          (await searchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }
}
