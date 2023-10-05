class FeaturedProductsModel {
  int? result;
  String? msg;
  List<FeaturedData>? featuredData;

  FeaturedProductsModel({this.result, this.msg, this.featuredData});

  FeaturedProductsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      featuredData = <FeaturedData>[];
      json['data'].forEach((v) {
        featuredData!.add(FeaturedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['msg'] = msg;
    if (featuredData != null) {
      data['data'] = featuredData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedData {
  int? productId;
  String? productName;
  String? productImage;
  String? productPrice;
  String? productQuantity;
  String? productDescription;
  String? isFeatured;
  String? status;
  String? created;
  String? createdAt;
  String? updatedAt;

  FeaturedData(
      {this.productId,
        this.productName,
        this.productImage,
        this.productPrice,
        this.productQuantity,
        this.productDescription,
        this.isFeatured,
        this.status,
        this.created,
        this.createdAt,
        this.updatedAt});

  FeaturedData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    productQuantity = json['product_quantity'];
    productDescription = json['product_description'];
    isFeatured = json['is_featured'];
    status = json['status'];
    created = json['created'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['product_price'] = productPrice;
    data['product_quantity'] = productQuantity;
    data['product_description'] = productDescription;
    data['is_featured'] = isFeatured;
    data['status'] = status;
    data['created'] = created;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
