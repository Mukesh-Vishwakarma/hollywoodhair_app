class MetaFieldsDetails {
  List<Metafields>? metafields;

  MetaFieldsDetails({this.metafields});

  MetaFieldsDetails.fromJson(Map<String, dynamic> json) {
    if (json['metafields'] != null) {
      metafields = <Metafields>[];
      json['metafields'].forEach((v) {
        metafields!.add(new Metafields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metafields {
  dynamic id;
  dynamic namespace;
  dynamic key;
  dynamic value;
  dynamic description;
  dynamic ownerId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic ownerResource;
  dynamic type;
  dynamic adminGraphqlApiId;

  Metafields(
      {this.id,
        this.namespace,
        this.key,
        this.value,
        this.description,
        this.ownerId,
        this.createdAt,
        this.updatedAt,
        this.ownerResource,
        this.type,
        this.adminGraphqlApiId});

  Metafields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namespace = json['namespace'];
    key = json['key'];
    value = json['value'];
    description = json['description'];
    ownerId = json['owner_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ownerResource = json['owner_resource'];
    type = json['type'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['namespace'] = this.namespace;
    data['key'] = this.key;
    data['value'] = this.value;
    data['description'] = this.description;
    data['owner_id'] = this.ownerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['owner_resource'] = this.ownerResource;
    data['type'] = this.type;
    data['admin_graphql_api_id'] = this.adminGraphqlApiId;
    return data;
  }
}
