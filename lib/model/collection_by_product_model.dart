class CollectionByProductModel {
  DataCollection? dataCollection;

  CollectionByProductModel({this.dataCollection});

  CollectionByProductModel.fromJson(Map<String, dynamic> json) {
    dataCollection = json['data'] != null ? new DataCollection.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataCollection != null) {
      data['data'] = this.dataCollection!.toJson();
    }
    return data;
  }
}

class DataCollection {
  ProductCollection? productCollection;

  DataCollection({this.productCollection});

  DataCollection.fromJson(Map<String, dynamic> json) {
    productCollection =
    json['product'] != null ? new ProductCollection.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productCollection != null) {
      data['product'] = this.productCollection!.toJson();
    }
    return data;
  }
}

class ProductCollection {
  String? id;
  String? title;
  Collections? collections;

  ProductCollection({this.id, this.title, this.collections});

  ProductCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    collections = json['collections'] != null
        ? new Collections.fromJson(json['collections'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.collections != null) {
      data['collections'] = this.collections!.toJson();
    }
    return data;
  }
}

class Collections {
  List<Edges>? edges;

  Collections({this.edges});

  Collections.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = <Edges>[];
      json['edges'].forEach((v) {
        edges!.add(new Edges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edges != null) {
      data['edges'] = this.edges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Edges {
  Node? node;

  Edges({this.node});

  Edges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new Node.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node!.toJson();
    }
    return data;
  }
}

class Node {
  String? id;
  String? title;

  Node({this.id, this.title});

  Node.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
