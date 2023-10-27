class DeleteAddressModel {
  Errors? errors;

  DeleteAddressModel({this.errors});

  DeleteAddressModel.fromJson(Map<String, dynamic> json) {
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? base;

  Errors({this.base});

  Errors.fromJson(Map<String, dynamic> json) {
    base = json['base'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base'] = this.base;
    return data;
  }
}
