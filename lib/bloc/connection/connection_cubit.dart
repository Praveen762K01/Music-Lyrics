import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu/bloc/connection/connection_state.dart';

class ConnectionCubit extends Cubit<ConnectionState> {
  ConnectionCubit() : super(OnlineConnectionState());
  check() async {
    Timer.periodic(const Duration(seconds: 1), (_) async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        emit(OfflineConnectionState());
      } else {
        emit(OnlineConnectionState());
      }
    });
  }
}
