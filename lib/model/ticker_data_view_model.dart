class TickerDataViewModel {
  String? id;
  String? name;
  String? logo_url;

  TickerDataViewModel({this.id, this.name, this.logo_url});

  TickerDataViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo_url = json['logo_url'];
  }
}
