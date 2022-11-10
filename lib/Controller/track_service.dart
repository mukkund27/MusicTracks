import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';


import '../Model/lyrics_model.dart';
import '../Model/track_model.dart';

class GetProductService {
  static Future<TrackModel> GetData() async {
    Response response;
    var dio = Dio();
    response = await dio.get(
        "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");
    return trackModelFromJson(response.data);
  }

  static Future<LyricsModel> GetLyrics() async {
    Response response;
    var dio = Dio();
    final box = GetStorage();
    var id = box.read("track_id");
    // Enter Your Api key
    var api_key = "4191ff2cd4528434029cf33d633******";
    response = await dio.get(
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$id&apikey=$api_key");

    return lyricsModelFromJson(response.data);
  }
}
