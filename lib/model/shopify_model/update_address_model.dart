class UpdateAddressModel {
  Address? address;

  UpdateAddressModel({this.address});

  UpdateAddressModel.fromJson(Map<String, dynamic> json) {
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  dynamic id;
  dynamic firstName;
  dynamic lastName;
  dynamic address1;
  dynamic address2;
  dynamic city;
  dynamic country;
  dynamic zip;
  dynamic phone;
  dynamic defaultAddress;

  Address({this.id, this.firstName, this.lastName, this.address1, this.address2, this.city, this.country, this.zip, this.phone, this.defaultAddress});

Address.fromJson(Map<String, dynamic> json) {
id = json['id'];
firstName = json['first_name'];
lastName = json['last_name'];
address1 = json['address1'];
address2 = json['address2'];
city = json['city'];
country = json['country'];
zip = json['zip'];
phone = json['phone'];
defaultAddress = json['default'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['first_name'] = this.firstName;
data['last_name'] = this.lastName;
data['address1'] = this.address1;
data['address2'] = this.address2;
data['city'] = this.city;
data['country'] = this.country;
data['zip'] = this.zip;
data['phone'] = this.phone;
data['default'] = this.defaultAddress;
return data;
}
}
