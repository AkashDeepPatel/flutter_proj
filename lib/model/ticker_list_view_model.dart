import 'package:flutter_proj/model/ticker_data_view_model.dart';

class TickerListViewModel {
  List<TickerDataViewModel>? tickersData;

  TickerListViewModel({required this.tickersData});

  TickerListViewModel.fromJson(Map<String, dynamic> json) {
    tickersData = (json['ticker_info'] as List)
        .map((final element) => TickerDataViewModel.fromJson(element))
        .toList();
  }
}
