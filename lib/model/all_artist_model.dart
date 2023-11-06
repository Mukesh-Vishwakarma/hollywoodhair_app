class AllArtistModel {
  int? result;
  String? msg;
  List<AllArtistData>? allArtistData;

  AllArtistModel({this.result, this.msg, this.allArtistData});

  AllArtistModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      allArtistData = <AllArtistData>[];
      json['data'].forEach((v) {
        allArtistData!.add(new AllArtistData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['msg'] = msg;
    if (allArtistData != null) {
      data['data'] =
          allArtistData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllArtistData {
  dynamic workerId;
  dynamic workerName;
  dynamic profileImage;
  dynamic phone;
  dynamic salonId;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  AllArtistData(
      {this.workerId,
        this.workerName,
        this.profileImage,
        this.phone,
        this.salonId,
        this.status,
        this.createdAt,
        this.updatedAt});

  AllArtistData.fromJson(Map<String, dynamic> json) {
    workerId = json['worker_id'];
    workerName = json['worker_name'];
    profileImage = json['profile_image'];
    phone = json['phone'];
    salonId = json['salon_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['worker_id'] = this.workerId;
    data['worker_name'] = this.workerName;
    data['profile_image'] = this.profileImage;
    data['phone'] = this.phone;
    data['salon_id'] = this.salonId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
