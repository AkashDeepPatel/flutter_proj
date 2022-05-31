import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_proj/model/ticker_list_view_model.dart';
import 'package:get/get.dart';

import '';

class MyRepository {
  // String initialTicker = "A";
  var _dio = Dio();

  static String _url =
      "https://ticker-service-w3zz3dng3q-uc.a.run.app/ticker_id/?stocks=";

  var tickers = List<dynamic>.empty(growable: true).obs;
  // final TickerListViewModel tickers =[];
  MyRepository(
      // String initialTicker
      ) {
    _url = _url;
    // + initialTicker;
    _dio = Dio(BaseOptions(baseUrl: _url));
  }
  Future<Either<String, TickerListViewModel>> getAllTickers(
      String value) async {
    try {
      final response = await _dio.get(_url + value);
      final TickerListViewModel tickers =
          TickerListViewModel.fromJson(response.data);
      return Right(tickers);
    } catch (dioError) {
      return Left(dioError.toString());
    }
  }
}
