import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
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

  //for pagination
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;
  var page = " ";

  Future<void> getAllTickersA(String value) async {
    isLoadingGetAllTickers(true);
    final Either<String, TickerListViewModel> resultOrException =
        await _repository.getAllTickers(value);
    resultOrException.fold((left) {
      isLoadingGetAllTickers(false);
      hasError(true);
    }, (data) {
      isLoadingGetAllTickers(false);
      // tickers(data.tickersData);
      tickers.addAll(data.tickersData!);
      // debugPrint(tickers.va);
    });
  }

  Future<void> onRefresh() async {
    hasError(false);
    tickers.clear();
    await getAllTickersA("");
  }

  @override
  void onInit() {
    super.onInit();
    getAllTickersA(page);
    paginationTask();

    // foundTickers.value = tickers as List<Map<String, dynamic>>;
  }

  void paginationTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("reached end");
        page = _controller.tickers[tickers.length - 1].id!;
        print(_controller.tickers[tickers.length - 1].id!);
        getAllTickersA(page);
      }
    });
  }

  // void getMoreTickers(String value) {
  //   try {
  //     MyRepository().getAllTickers(value).then((resp) {
  //       if (resp.length() > 0) {
  //         isMoreDataAvailable(true);
  //         print("true");
  //       } else {
  //         isMoreDataAvailable(false);
  //         print('no more items');
  //       }
  //     });
  //   } catch (exception) {
  //     isMoreDataAvailable(false);
  //     print('exception ${exception.toString()}');
  //   }
  // }

  MyController get _controller => Get.find<MyController>();
}
