class HomeStatstic {
  var code;
  var status;
  var message;
  HomeStatsticData data;

  HomeStatstic({this.code, this.status, this.message, this.data});

  HomeStatstic.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new HomeStatsticData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class HomeStatsticData {
  var newOrders;
  var finishedOrders;
  var ordersRatio;
  var ordersIncom;
  var topArea;
  var topAreaOrders;
  var remainDays;
  var remainMonths;
  var remainYears;

  HomeStatsticData(
      {this.newOrders,
      this.finishedOrders,
      this.ordersRatio,
      this.ordersIncom,
      this.topArea,
      this.topAreaOrders,
      this.remainDays,
      this.remainMonths,
      this.remainYears});

  HomeStatsticData.fromJson(Map<String, dynamic> json) {
    newOrders = json['new_orders'];
    finishedOrders = json['finished_orders'];
    ordersRatio = json['orders_ratio'];
    ordersIncom = json['orders_incom'];
    topArea = json['top_area'];
    topAreaOrders = json['top_area_orders'];
    remainDays = json['remain_days'];
    remainMonths = json['remain_months'];
    remainYears = json['remain_years'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_orders'] = this.newOrders;
    data['finished_orders'] = this.finishedOrders;
    data['orders_ratio'] = this.ordersRatio;
    data['orders_incom'] = this.ordersIncom;
    data['top_area'] = this.topArea;
    data['top_area_orders'] = this.topAreaOrders;
    data['remain_days'] = this.remainDays;
    data['remain_months'] = this.remainMonths;
    data['remain_years'] = this.remainYears;
    return data;
  }
}
