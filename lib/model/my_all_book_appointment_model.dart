class MyAllBookAppointmentModel {
  int? result;
  String? msg;
  List<DataMyAllBooking>? dataMyAllBooking;

  MyAllBookAppointmentModel({this.result, this.msg, this.dataMyAllBooking});

  MyAllBookAppointmentModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      dataMyAllBooking = <DataMyAllBooking>[];
      json['data'].forEach((v) {
        dataMyAllBooking!.add(new DataMyAllBooking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.dataMyAllBooking != null) {
      data['data'] = this.dataMyAllBooking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataMyAllBooking {
  int? bookingId;
  int? customerId;
  int? workerId;
  int? salonId;
  String? bookingDate;
  String? isConfirmed;
  String? slots;
  String? services;
  String? isArchived;
  dynamic note;
  int? agreementId;
  String? bookingStatus;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Servicedetails>? servicedetails;
  List<Slotsdetails>? slotsdetails;
  dynamic signature;
  Agreementdocument? agreementdocument;
  Customer? customer;
  SalonDetails? salonDetails;

  DataMyAllBooking(
      {this.bookingId,
        this.customerId,
        this.workerId,
        this.salonId,
        this.bookingDate,
        this.isConfirmed,
        this.slots,
        this.services,
        this.isArchived,
        this.note,
        this.agreementId,
        this.bookingStatus,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.servicedetails,
        this.slotsdetails,
        this.signature,
        this.agreementdocument,
        this.customer,
        this.salonDetails});

  DataMyAllBooking.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    customerId = json['customer_id'];
    workerId = json['worker_id'];
    salonId = json['salon_id'];
    bookingDate = json['booking_date'];
    isConfirmed = json['is_confirmed'];
    slots = json['slots'];
    services = json['services'];
    isArchived = json['isArchived'];
    note = json['note'];
    agreementId = json['agreement_id'];
    bookingStatus = json['booking_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['servicedetails'] != null) {
      servicedetails = <Servicedetails>[];
      json['servicedetails'].forEach((v) {
        servicedetails!.add(new Servicedetails.fromJson(v));
      });
    }
    if (json['slotsdetails'] != null) {
      slotsdetails = <Slotsdetails>[];
      json['slotsdetails'].forEach((v) {
        slotsdetails!.add(new Slotsdetails.fromJson(v));
      });
    }
    signature = json['signature'];
    agreementdocument = json['agreementdocument'] != null
        ? new Agreementdocument.fromJson(json['agreementdocument'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    salonDetails = json['salon_details'] != null
        ? new SalonDetails.fromJson(json['salon_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['customer_id'] = this.customerId;
    data['worker_id'] = this.workerId;
    data['salon_id'] = this.salonId;
    data['booking_date'] = this.bookingDate;
    data['is_confirmed'] = this.isConfirmed;
    data['slots'] = this.slots;
    data['services'] = this.services;
    data['isArchived'] = this.isArchived;
    data['note'] = this.note;
    data['agreement_id'] = this.agreementId;
    data['booking_status'] = this.bookingStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.servicedetails != null) {
      data['servicedetails'] =
          this.servicedetails!.map((v) => v.toJson()).toList();
    }
    if (this.slotsdetails != null) {
      data['slotsdetails'] = this.slotsdetails!.map((v) => v.toJson()).toList();
    }
    data['signature'] = this.signature;
    if (this.agreementdocument != null) {
      data['agreementdocument'] = this.agreementdocument!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.salonDetails != null) {
      data['salon_details'] = this.salonDetails!.toJson();
    }
    return data;
  }
}

class Servicedetails {
  int? serviceId;
  String? serviceName;

  Servicedetails({this.serviceId, this.serviceName});

  Servicedetails.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    return data;
  }
}

class Slotsdetails {
  int? slotId;
  String? slotName;

  Slotsdetails({this.slotId, this.slotName});

  Slotsdetails.fromJson(Map<String, dynamic> json) {
    slotId = json['slot_id'];
    slotName = json['slot_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot_id'] = this.slotId;
    data['slot_name'] = this.slotName;
    return data;
  }
}

class Agreementdocument {
  int? documentId;
  int? agreementId;
  int? bookingId;
  dynamic documentFile;
  String? documentType;
  String? status;

  Agreementdocument(
      {this.documentId,
        this.agreementId,
        this.bookingId,
        this.documentFile,
        this.documentType,
        this.status});

  Agreementdocument.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'];
    agreementId = json['agreement_id'];
    bookingId = json['booking_id'];
    documentFile = json['document_file'];
    documentType = json['document_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_id'] = this.documentId;
    data['agreement_id'] = this.agreementId;
    data['booking_id'] = this.bookingId;
    data['document_file'] = this.documentFile;
    data['document_type'] = this.documentType;
    data['status'] = this.status;
    return data;
  }
}

class Customer {
  int? customerId;
  String? customerName;
  String? gender;
  dynamic surname;
  String? email;
  int? age;
  String? phone;
  dynamic note;
  dynamic pesel;
  String? status;
  String? isArchived;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.customerId,
        this.customerName,
        this.gender,
        this.surname,
        this.email,
        this.age,
        this.phone,
        this.note,
        this.pesel,
        this.status,
        this.isArchived,
        this.createdAt,
        this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    gender = json['gender'];
    surname = json['surname'];
    email = json['email'];
    age = json['age'];
    phone = json['phone'];
    note = json['note'];
    pesel = json['pesel'];
    status = json['status'];
    isArchived = json['isArchived'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['gender'] = this.gender;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['age'] = this.age;
    data['phone'] = this.phone;
    data['note'] = this.note;
    data['pesel'] = this.pesel;
    data['status'] = this.status;
    data['isArchived'] = this.isArchived;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SalonDetails {
  int? salonId;
  String? salonNameEn;
  String? salonAddressEn;
  String? salonNameEs;
  String? salonNamePl;
  String? addressEs;
  String? addressPl;
  dynamic cityEn;
  dynamic cityEs;
  dynamic cityPl;
  String? salonThumbnail;
  String? latitude;
  String? longitude;
  String? userName;
  String? email;
  dynamic phoneNo;
  String? password;
  String? openingTime;
  String? closingTime;
  String? otp;
  String? status;
  String? createdAt;
  String? updatedAt;

  SalonDetails(
      {this.salonId,
        this.salonNameEn,
        this.salonAddressEn,
        this.salonNameEs,
        this.salonNamePl,
        this.addressEs,
        this.addressPl,
        this.cityEn,
        this.cityEs,
        this.cityPl,
        this.salonThumbnail,
        this.latitude,
        this.longitude,
        this.userName,
        this.email,
        this.phoneNo,
        this.password,
        this.openingTime,
        this.closingTime,
        this.otp,
        this.status,
        this.createdAt,
        this.updatedAt});

  SalonDetails.fromJson(Map<String, dynamic> json) {
    salonId = json['salon_id'];
    salonNameEn = json['salon_name_en'];
    salonAddressEn = json['salon_address_en'];
    salonNameEs = json['salon_name_es'];
    salonNamePl = json['salon_name_pl'];
    addressEs = json['address_es'];
    addressPl = json['address_pl'];
    cityEn = json['city_en'];
    cityEs = json['city_es'];
    cityPl = json['city_pl'];
    salonThumbnail = json['salon_thumbnail'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    userName = json['user_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    password = json['password'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    otp = json['otp'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salon_id'] = this.salonId;
    data['salon_name_en'] = this.salonNameEn;
    data['salon_address_en'] = this.salonAddressEn;
    data['salon_name_es'] = this.salonNameEs;
    data['salon_name_pl'] = this.salonNamePl;
    data['address_es'] = this.addressEs;
    data['address_pl'] = this.addressPl;
    data['city_en'] = this.cityEn;
    data['city_es'] = this.cityEs;
    data['city_pl'] = this.cityPl;
    data['salon_thumbnail'] = this.salonThumbnail;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['password'] = this.password;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['otp'] = this.otp;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
