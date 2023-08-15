import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pokemon/core/network/interceptor/dio_internetconnection_request_retriever.dart';

class RetryOnInternetChangeInterceptor extends Interceptor{
  final DioInternetRequestRetriever internetRequestRetriever;

  RetryOnInternetChangeInterceptor({ required this.internetRequestRetriever});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
      if(_shouldRetry(err)){
          try{
            internetRequestRetriever.scheduleRequestRetry(err.requestOptions);
          } catch (e) {
            rethrow;
          }
      }
      // super.onError(err, handler);
  }

  bool _shouldRetry(DioException error){
     return error.type == DioExceptionType.connectionError &&
           error.error!=null &&
           error.error is SocketException;
  }
}