import 'dart:async';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class DioInternetRequestRetriever {
  final Dio dioClient;
  final InternetConnection internetConnection;

  DioInternetRequestRetriever({required this.dioClient,required this.internetConnection});

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription internetConnectionSubscription;
    final responseCompleter = Completer<Response>();
    internetConnectionSubscription = internetConnection.onStatusChange.listen((event) {
      if(event == InternetStatus.connected){
        internetConnectionSubscription.cancel();
       responseCompleter.complete(
           dioClient.request(requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          cancelToken: requestOptions.cancelToken,
          options: requestOptions as Options,
          onSendProgress: requestOptions.onSendProgress,
          onReceiveProgress: requestOptions.onReceiveProgress

        )
       );
      }
    });

    return responseCompleter.future;
  }
}