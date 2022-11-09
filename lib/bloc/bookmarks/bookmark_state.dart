abstract class BookMarkState {}

class InitBookMarkState extends BookMarkState {}

class LoadingBookMarkState extends BookMarkState {}

class SuccessBookMarkState extends BookMarkState {
  List<Map<String, dynamic>> ids;
  SuccessBookMarkState({required this.ids});
}

class NoDateBookMarkState extends BookMarkState {}

class ErrorBookMarkState extends BookMarkState {}
