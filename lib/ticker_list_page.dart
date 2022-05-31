import 'package:flutter/material.dart';
import 'package:flutter_proj/controller/my_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TickerListPage extends StatelessWidget {
  const TickerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticker List"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) => Obx(() => Column(
        children: [
          _title(),
          Expanded(
              child: _controller.isLoadingGetAllTickers.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _listView())
        ],
      ));

  Widget _listView() {
    return RefreshIndicator(
      onRefresh: _controller.onRefresh,
      child: Stack(
        children: [
          ListView.builder(
              controller: _controller.scrollController,
              itemCount: _controller.tickers.length,
              itemBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 75,
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(6)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _controller.tickers[index].id!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _controller.tickers[index].name!,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )),
          if (_controller.hasError.isTrue)
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _controller.errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                OutlinedButton(
                    onPressed: _controller.onRefresh,
                    child: const Text("try again"))
              ],
            ))
        ],
      ),
    );
  }

  Widget _title() => const Text(
        "Ticker List",
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      );
  MyController get _controller => Get.find<MyController>();
}
