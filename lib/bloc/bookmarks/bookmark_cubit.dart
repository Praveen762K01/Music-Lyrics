import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bookmark_state.dart';

class BookMarkCubit extends Cubit<BookMarkState> {
  BookMarkCubit() : super(InitBookMarkState());

  getData() async {
    emit(LoadingBookMarkState());
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var data = preferences.getStringList("ids");
      List<Map<String, dynamic>> ids = [];
      if (data != null) {
        for (var i in data) {
          ids.add({"id": jsonDecode(i)['id'], "name": jsonDecode(i)['name']});
        }
        emit(SuccessBookMarkState(ids: ids));
      } else {
        emit(NoDateBookMarkState());
      }
    } catch (e) {
      emit(ErrorBookMarkState());
    }
  }

  Future addData(int id, String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? data = preferences.getStringList("ids");
    if (data != null) {
      Map<String, dynamic> d = {"id": id, "name": name};
      String encode = jsonEncode(d);
      data.add(encode);
      preferences.setStringList("ids", data);
    } else {
      List<String> temp = [];
      Map<String, dynamic> d = {"id": id, "name": name};
      String encode = jsonEncode(d);
      temp.add(encode);
      preferences.setStringList("ids", temp);
    }
  }
}
