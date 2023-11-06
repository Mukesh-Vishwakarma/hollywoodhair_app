class AllServicesModel {
  int? result;
  String? msg;
  List<DataServices>? dataServices;

  AllServicesModel({this.result, this.msg, this.dataServices});

  AllServicesModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      dataServices = <DataServices>[];
      json['data'].forEach((v) {
        dataServices!.add(new DataServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.dataServices != null) {
      data['data'] = this.dataServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataServices {
  String? serviceName;
  int? serviceId;

  DataServices({this.serviceName, this.serviceId});

  DataServices.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_name'] = this.serviceName;
    data['service_id'] = this.serviceId;
    return data;
  }
}
