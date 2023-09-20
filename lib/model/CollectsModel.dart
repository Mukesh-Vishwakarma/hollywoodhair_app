class CollectsModel {
  List<Collects>? collects;

  CollectsModel({this.collects});

  CollectsModel.fromJson(Map<String, dynamic> json) {
    if (json['collects'] != null) {
      collects = <Collects>[];
      json['collects'].forEach((v) {
        collects!.add(new Collects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collects != null) {
      data['collects'] = this.collects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Collects {
  int? id;
  int? collectionId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  int? position;
  String? sortValue;

  Collects(
      {this.id,
        this.collectionId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.position,
        this.sortValue});

  Collects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collectionId = json['collection_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    position = json['position'];
    sortValue = json['sort_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['collection_id'] = this.collectionId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['position'] = this.position;
    data['sort_value'] = this.sortValue;
    return data;
  }
}
