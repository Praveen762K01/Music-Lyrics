import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:relu/models/song_model.dart';

import '../utils.dart';

class SongRepo {
  Future<SongModel> getSongs(int trackId) async {
    String getUrl = "track.get?track_id=$trackId&apikey=";
    http.Response response =
        await http.get(Uri.parse(baseUrl + getUrl + apiKey));
    return SongModel.fromJson(jsonDecode(response.body));
  }
}
