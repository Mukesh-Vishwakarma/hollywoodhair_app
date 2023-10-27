class FeaturedProductsModel {
  int? result;
  dynamic msg;
  List<FeaturedData>? featuredData;

  FeaturedProductsModel({this.result, this.msg, this.featuredData});

  FeaturedProductsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      featuredData = <FeaturedData>[];
      json['data'].forEach((v) {
        featuredData!.add(new FeaturedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.featuredData != null) {
      data['data'] = this.featuredData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedData {
  dynamic id;
  dynamic productId;
  dynamic title;
  dynamic bodyHtml;
  dynamic vendor;
  dynamic productType;
  dynamic handle;
  dynamic publishedAt;
  dynamic publishedScope;
  dynamic adminGraphqlApiId;
  dynamic price;
  dynamic compareAtPrice;
  dynamic productImage;
  dynamic isFeatured;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  FeaturedData(
      {this.id,
      this.productId,
      this.title,
      this.bodyHtml,
      this.vendor,
      this.productType,
      this.handle,
      this.publishedAt,
      this.publishedScope,
      this.adminGraphqlApiId,
      this.price,
      this.compareAtPrice,
      this.productImage,
      this.isFeatured,
      this.status,
      this.createdAt,
      this.updatedAt});

  FeaturedData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    title = json['title'];
    bodyHtml = json['body_html'];
    vendor = json['vendor'];
    productType = json['product_type'];
    handle = json['handle'];
    publishedAt = json['published_at'];
    publishedScope = json['published_scope'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
    price = json['price'];
    compareAtPrice = json['compare_at_price'];
    productImage = json['product_image'];
    isFeatured = json['is_featured'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['title'] = this.title;
    data['body_html'] = this.bodyHtml;
    data['vendor'] = this.vendor;
    data['product_type'] = this.productType;
    data['handle'] = this.handle;
    data['published_at'] = this.publishedAt;
    data['published_scope'] = this.publishedScope;
    data['admin_graphql_api_id'] = this.adminGraphqlApiId;
    data['price'] = this.price;
    data['compare_at_price'] = this.compareAtPrice;
    data['product_image'] = this.productImage;
    data['is_featured'] = this.isFeatured;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
