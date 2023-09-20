// class CollectionsModel {
//   Collection? collection;
//
//   CollectionsModel({this.collection});
//
//   CollectionsModel.fromJson(Map<String, dynamic> json) {
//     collection = json['collection'] != null
//         ? new Collection.fromJson(json['collection'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.collection != null) {
//       data['collection'] = this.collection!.toJson();
//     }
//     return data;
//   }
// }
//
// class Collection {
//   int? id;
//   String? handle;
//   String? title;
//   String? updatedAt;
//   String? bodyHtml;
//   String? publishedAt;
//   String? sortOrder;
//   String? templateSuffix;
//   int? productsCount;
//   String? collectionType;
//   String? publishedScope;
//   String? adminGraphqlApiId;
//
//   Collection(
//       {this.id,
//         this.handle,
//         this.title,
//         this.updatedAt,
//         this.bodyHtml,
//         this.publishedAt,
//         this.sortOrder,
//         this.templateSuffix,
//         this.productsCount,
//         this.collectionType,
//         this.publishedScope,
//         this.adminGraphqlApiId});
//
//   Collection.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     handle = json['handle'];
//     title = json['title'];
//     updatedAt = json['updated_at'];
//     bodyHtml = json['body_html'];
//     publishedAt = json['published_at'];
//     sortOrder = json['sort_order'];
//     templateSuffix = json['template_suffix'];
//     productsCount = json['products_count'];
//     collectionType = json['collection_type'];
//     publishedScope = json['published_scope'];
//     adminGraphqlApiId = json['admin_graphql_api_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['handle'] = this.handle;
//     data['title'] = this.title;
//     data['updated_at'] = this.updatedAt;
//     data['body_html'] = this.bodyHtml;
//     data['published_at'] = this.publishedAt;
//     data['sort_order'] = this.sortOrder;
//     data['template_suffix'] = this.templateSuffix;
//     data['products_count'] = this.productsCount;
//     data['collection_type'] = this.collectionType;
//     data['published_scope'] = this.publishedScope;
//     data['admin_graphql_api_id'] = this.adminGraphqlApiId;
//     return data;
//   }
// }
