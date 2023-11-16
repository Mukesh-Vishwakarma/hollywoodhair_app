class CategoryListModel {
  int? result;
  String? msg;
  List<DataCategory>? dataCategory;

  CategoryListModel({this.result, this.msg, this.dataCategory});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      dataCategory = <DataCategory>[];
      json['data'].forEach((v) {
        dataCategory!.add(new DataCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.dataCategory != null) {
      data['data'] = this.dataCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataCategory {
  int? categoryId;
  String? title;
  String? handle;
  String? image;
  String? isFeatured;
  String? status;
  String? createdAt;
  String? updatedAt;

  DataCategory(
      {this.categoryId,
        this.title,
        this.handle,
        this.image,
        this.isFeatured,
        this.status,
        this.createdAt,
        this.updatedAt});

  DataCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    title = json['title'];
    handle = json['handle'];
    image = json['image'];
    isFeatured = json['is_featured'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['handle'] = this.handle;
    data['image'] = this.image;
    data['is_featured'] = this.isFeatured;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
