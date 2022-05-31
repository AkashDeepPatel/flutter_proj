import 'package:dartz/dartz.dart';
import 'package:flutter_proj/model/ticker_data_view_model.dart';
import 'package:flutter_proj/model/ticker_list_view_model.dart';
import 'package:flutter_proj/repository/my_repository.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

class MyController extends GetxController {
  final MyRepository _repository = MyRepository();
  RxBool isLoadingGetAllTickers = false.obs, hasError = false.obs;
  final String errorMessage = "An error has occurred";
  RxList<TickerDataViewModel> tickers = <TickerDataViewModel>[].obs;

  // RxList<Map<String, dynamic>> foundTickers = RxList<Map<String, dynamic>>();

  Future<void> getAllTickers() async {
    isLoadingGetAllTickers(true);
    final Either<String, TickerListViewModel> resultOrException =
        await _repository.getAllTickers();
    resultOrException.fold((left) {
      isLoadingGetAllTickers(false);
      hasError(true);
    }, (data) {
      isLoadingGetAllTickers(false);
      tickers(data.tickersData);
    });
  }

  Future<void> onRefresh() async {
    hasError(false);
    tickers.clear();
    await getAllTickers();
  }

  @override
  void onInit() {
    getAllTickers();
    super.onInit();
    // foundTickers.value = tickers as List<Map<String, dynamic>>;
  }

  // void filterTicker(String tickerName) {
  //   List<Map<String, dynamic>> results = [];
  //   if (tickerName.isEmpty) {
  //     results = tickers as List<Map<String, dynamic>>;
  //   } else {
  //     results = tickers
  //         .where((element) => element['name']
  //             .toString()
  //             .toLowerCase()
  //             .contains(tickerName, toLowerCase()))
  //         .cast<Map<String, dynamic>>()
  //         .toList();
  //   }
  // }
  // MyController get _controller => Get.find<MyController>();
  //
  // Future<List<TickerDataViewModel>> search(String search) async{
  //   await Future.delayed(Duration(seconds: 2));
  //   return List.generate(search.length, (int index) {
  //     return TickerDataViewModel(id: _controller.tickers[index].id, name: _controller.tickers[index].name );
  //   });
  // }
}
