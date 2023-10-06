class AllTransformationsModel {
  int? result;
  String? msg;
  List<TransformationsData>? data;

  AllTransformationsModel({this.result, this.msg, this.data});

  AllTransformationsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <TransformationsData>[];
      json['data'].forEach((v) {
        data!.add(new TransformationsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransformationsData {
  int? id;
  String? imageUrl;
  String? status;
  String? createdAt;
  String? updatedAt;

  TransformationsData({this.id, this.imageUrl, this.status, this.createdAt, this.updatedAt});

  TransformationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
