class RelatedProductModel {
  Data? data;

  RelatedProductModel({this.data});

  RelatedProductModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  ProductRelated? product;

  Data({this.product});

  Data.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new ProductRelated.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class ProductRelated {
  String? title;
  Variants? variants;
  Collections? collections;

  ProductRelated({this.title, this.variants, this.collections});

  ProductRelated.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    variants = json['variants'] != null
        ? new Variants.fromJson(json['variants'])
        : null;
    collections = json['collections'] != null
        ? new Collections.fromJson(json['collections'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.variants != null) {
      data['variants'] = this.variants!.toJson();
    }
    if (this.collections != null) {
      data['collections'] = this.collections!.toJson();
    }
    return data;
  }
}

class Variants {
  List<EdgesFirst>? edgesFirst;

  Variants({this.edgesFirst});

  Variants.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edgesFirst = <EdgesFirst>[];
      json['edges'].forEach((v) {
        edgesFirst!.add(new EdgesFirst.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edgesFirst != null) {
      data['edges'] = this.edgesFirst!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EdgesFirst {
  NodeFirst? nodeFirst;

  EdgesFirst({this.nodeFirst});

  EdgesFirst.fromJson(Map<String, dynamic> json) {
    nodeFirst = json['node'] != null
        ? new NodeFirst.fromJson(json['node'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nodeFirst != null) {
      data['node'] = this.nodeFirst!.toJson();
    }
    return data;
  }
}

class NodeFirst {
  PriceV2? priceV2;

  NodeFirst({this.priceV2});

  NodeFirst.fromJson(Map<String, dynamic> json) {
    priceV2 =
    json['priceV2'] != null ? new PriceV2.fromJson(json['priceV2']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.priceV2 != null) {
      data['priceV2'] = this.priceV2!.toJson();
    }
    return data;
  }
}

class PriceV2 {
  String? amount;
  String? currencyCode;

  PriceV2({this.amount, this.currencyCode});

  PriceV2.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currencyCode'] = this.currencyCode;
    return data;
  }
}

class Collections {
  List<EdgesSecond>? edgesSecond;

  Collections({this.edgesSecond});

  Collections.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edgesSecond = <EdgesSecond>[];
      json['edges'].forEach((v) {
        edgesSecond!.add(new EdgesSecond.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edgesSecond != null) {
      data['edges'] = this.edgesSecond!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EdgesSecond {
  NodeSecond? nodeSecond;

  EdgesSecond({this.nodeSecond});

  EdgesSecond.fromJson(Map<String, dynamic> json) {
    nodeSecond = json['node'] != null
        ? new NodeSecond.fromJson(json['node'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nodeSecond != null) {
      data['node'] = this.nodeSecond!.toJson();
    }
    return data;
  }
}

class NodeSecond {
  Products? products;

  NodeSecond({this.products});

  NodeSecond.fromJson(Map<String, dynamic> json) {
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }
}

class Products {
  List<EdgesThird>? edgesThird;

  Products({this.edgesThird});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edgesThird = <EdgesThird>[];
      json['edges'].forEach((v) {
        edgesThird!.add(new EdgesThird.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edgesThird != null) {
      data['edges'] = this.edgesThird!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EdgesThird {
  NodeThird? nodeThird;

  EdgesThird({this.nodeThird});

  EdgesThird.fromJson(Map<String, dynamic> json) {
    nodeThird = json['node'] != null
        ? new NodeThird.fromJson(json['node'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nodeThird != null) {
      data['node'] = this.nodeThird!.toJson();
    }
    return data;
  }
}

class NodeThird {
  String? id;
  String? title;
  String? handle;
  ImagesRelated? images;
  Variants? variants;

  NodeThird({this.id, this.title, this.handle, this.images, this.variants});

  NodeThird.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    handle = json['handle'];
    images =
    json['images'] != null ? new ImagesRelated.fromJson(json['images']) : null;
    variants = json['variants'] != null
        ? new Variants.fromJson(json['variants'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['handle'] = this.handle;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.toJson();
    }
    return data;
  }
}

class ImagesRelated {
  List<EdgesForth>? edgesForth;

  ImagesRelated({this.edgesForth});

  ImagesRelated.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edgesForth = <EdgesForth>[];
      json['edges'].forEach((v) {
        edgesForth!.add(new EdgesForth.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edgesForth != null) {
      data['edges'] = this.edgesForth!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EdgesForth {
  NodeForth? nodeForth;

  EdgesForth({this.nodeForth});

  EdgesForth.fromJson(Map<String, dynamic> json) {
    nodeForth = json['node'] != null
        ? new NodeForth.fromJson(json['node'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nodeForth != null) {
      data['node'] = this.nodeForth!.toJson();
    }
    return data;
  }
}

class NodeForth {
  String? originalSrc;

  NodeForth({this.originalSrc});

  NodeForth.fromJson(Map<String, dynamic> json) {
    originalSrc = json['originalSrc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originalSrc'] = this.originalSrc;
    return data;
  }
}
