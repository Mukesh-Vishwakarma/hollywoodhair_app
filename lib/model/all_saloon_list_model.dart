class AllSaloonListModel {
  int? result;
  String? msg;
  List<SaloonData>? saloonData;

  AllSaloonListModel({this.result, this.msg, this.saloonData});

  AllSaloonListModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      saloonData = <SaloonData>[];
      json['data'].forEach((v) {
        saloonData!.add(SaloonData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['msg'] = msg;
    if (saloonData != null) {
      data['data'] = saloonData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaloonData {
  int? salonId;
  dynamic salonName;
  String? salonPicture;
  String? salonAddress;
  dynamic latitude;
  dynamic longitude;
  String? status;
  String? createdAt;
  String? updatedAt;

  SaloonData(
      {this.salonId,
        this.salonName,
        this.salonPicture,
        this.salonAddress,
        this.latitude,
        this.longitude,
        this.status,
        this.createdAt,
        this.updatedAt});

  SaloonData.fromJson(Map<String, dynamic> json) {
    salonId = json['salon_id'];
    salonName = json['salon_name'];
    salonPicture = json['salon_picture'];
    salonAddress = json['salon_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['salon_id'] = salonId;
    data['salon_name'] = salonName;
    data['salon_picture'] = salonPicture;
    data['salon_address'] = salonAddress;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
