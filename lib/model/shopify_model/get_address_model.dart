class GetAddressModel {
  List<AddressesList>? addresses;

  GetAddressModel({this.addresses});

  GetAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = <AddressesList>[];
      json['addresses'].forEach((v) { addresses!.add(new AddressesList.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressesList {
  int? id;
  dynamic customerId;
  dynamic firstName;
  dynamic lastName;
  dynamic company;
  dynamic address1;
  dynamic address2;
  dynamic city;
  dynamic province;
  dynamic country;
  dynamic zip;
  dynamic phone;
  dynamic name;
  dynamic provinceCode;
  dynamic countryCode;
  dynamic countryName;
  dynamic defaultAddress;

  AddressesList({this.id, this.customerId, this.firstName, this.lastName, this.company, this.address1, this.address2, this.city, this.province, this.country, this.zip, this.phone, this.name, this.provinceCode, this.countryCode, this.countryName, this.defaultAddress});

  AddressesList.fromJson(Map<String, dynamic> json) {
id = json['id'];
customerId = json['customer_id'];
firstName = json['first_name'];
lastName = json['last_name'];
company = json['company'];
address1 = json['address1'];
address2 = json['address2'];
city = json['city'];
province = json['province'];
country = json['country'];
zip = json['zip'];
phone = json['phone'];
name = json['name'];
provinceCode = json['province_code'];
countryCode = json['country_code'];
countryName = json['country_name'];
defaultAddress = json['default'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['customer_id'] = this.customerId;
data['first_name'] = this.firstName;
data['last_name'] = this.lastName;
data['company'] = this.company;
data['address1'] = this.address1;
data['address2'] = this.address2;
data['city'] = this.city;
data['province'] = this.province;
data['country'] = this.country;
data['zip'] = this.zip;
data['phone'] = this.phone;
data['name'] = this.name;
data['province_code'] = this.provinceCode;
data['country_code'] = this.countryCode;
data['country_name'] = this.countryName;
data['default'] = this.defaultAddress;
return data;
}
}