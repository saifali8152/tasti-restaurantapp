import 'package:dio/dio.dart';
import '/features/restaurant-admin/gallery/data/models/gallery.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IGalleryRemoteApi {
  Future<String> deleteGallery(String id);
  Future<String> addGallery(AddGalleryParms parms);
  Future<List<GalleryModel>> fetchGallery(String id);
}

class GalleryRemoteApiImpl extends IGalleryRemoteApi {
  final IApiService networkApiService;
  GalleryRemoteApiImpl(this.networkApiService);

  @override
  Future<String> addGallery(AddGalleryParms parms) async {
    Map<String, MultipartFile> files = {};
    
    files = {
      "image": await MultipartFile.fromFile(parms.image,
          filename: parms.image.split('/').last),
    };

    Map<String, String> data = {
      "id": parms.id.toString(),
      "name": parms.name,
      "notes": parms.notes,
    };

    var response = await networkApiService.postMultipart(AppUrls.addGallery, data, files);
    return response['message'];
  }

  @override
  Future<List<GalleryModel>> fetchGallery(String id) async {
    Map<String, String> data = {"id": id};

    var response = await networkApiService.get(
      AppUrls.fetchGalleries,
      queryParams: data,
    );
    final List<dynamic> rawList = response['data'];

    final List<GalleryModel> galleries =
        rawList.map((gallery) => GalleryModel.fromJson(gallery)).toList();
    return galleries;
  }

  @override
  Future<String> deleteGallery(String id) async {
    Map<String, String> data = {"id": id};

    var response = await networkApiService.post(AppUrls.deleteGallery, data);
    return response['message'];
  }
}
