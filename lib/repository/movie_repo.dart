import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:relu/models/movie_model.dart';
import 'package:relu/utils.dart';

class MovieRepo {
  String getUrl = "chart.tracks.get?apikey=";
  Future<MovieModel> getMovies() async {
    http.Response response =
        await http.get(Uri.parse(baseUrl + getUrl + apiKey));
    return MovieModel.fromJson(jsonDecode(response.body));
  }
}
