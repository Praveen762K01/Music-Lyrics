import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:relu/models/lyric_model.dart';

import '../utils.dart';

class LyricRepo {
  Future<LyricModel> getLyrics(int trackId) async {
    String getUrl = "track.lyrics.get?track_id=$trackId&apikey=";
    http.Response response =
        await http.get(Uri.parse(baseUrl + getUrl + apiKey));
    return LyricModel.fromJson(jsonDecode(response.body));
  }
}
