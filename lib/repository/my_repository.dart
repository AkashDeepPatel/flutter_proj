import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_proj/model/ticker_list_view_model.dart';

import '';

class MyRepository {
  // String initialTicker = "A";
  var _dio = Dio();

  static String _url =
      "https://ticker-service-w3zz3dng3q-uc.a.run.app/ticker_id/?stocks=";
  MyRepository(
      // String initialTicker
      ) {
    _url = _url;
    // + initialTicker;
    _dio = Dio(BaseOptions(baseUrl: _url));
  }
  Future<Either<String, TickerListViewModel>> getAllTickers() async {
    try {
      final response = await _dio.get(_url);
      final TickerListViewModel tickers =
          TickerListViewModel.fromJson(response.data);
      return Right(tickers);
    } catch (dioError) {
      return Left(dioError.toString());
    }
  }
}
