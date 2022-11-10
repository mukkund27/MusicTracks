import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../Model/lyrics_model.dart';
import '../Model/track_model.dart';

class GetProductService {
  static Future<TrackModel> GetData() async {
    http.Response response = await http.get(
      Uri.parse(
          "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7"),
    );
    return trackModelFromJson(response.body);
  }

  static Future<LyricsModel> GetLyrics() async {
    final box = GetStorage();
    var id = box.read("track_id");
    // Enter Your Api key
    var api_key = "4191ff2cd4528434029cf33d63363d5c";
    http.Response response = await http.get(
      Uri.parse(
          "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$id&apikey=$api_key"),
    );

    return lyricsModelFromJson(response.body);
  }
}
