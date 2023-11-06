class ChangePasswordModel {
  Customer? customer;

  ChangePasswordModel({this.customer});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  dynamic email;
  dynamic firstName;
  dynamic lastName;
  dynamic id;
  dynamic acceptsMarketing;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic ordersCount;
  dynamic state;
  dynamic totalSpent;
  dynamic lastOrderId;
  dynamic note;
  dynamic verifiedEmail;
  dynamic multipassIdentifier;
  dynamic taxExempt;
  dynamic tags;
  dynamic lastOrderName;
  dynamic currency;
  dynamic phone;
  dynamic acceptsMarketingUpdatedAt;
  dynamic marketingOptInLevel;
  dynamic smsMarketingConsent;
  dynamic adminGraphqlApiId;

  Customer({
    this.email,
    this.firstName,
    this.lastName,
    this.id,
    this.acceptsMarketing,
    this.createdAt,
    this.updatedAt,
    this.ordersCount,
    this.state,
    this.totalSpent,
    this.lastOrderId,
    this.note,
    this.verifiedEmail,
    this.multipassIdentifier,
    this.taxExempt,
    this.tags,
    this.lastOrderName,
    this.currency,
    this.phone,
    this.acceptsMarketingUpdatedAt,
    this.marketingOptInLevel,
    this.smsMarketingConsent,
    this.adminGraphqlApiId,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    id = json['id'];
    acceptsMarketing = json['accepts_marketing'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ordersCount = json['orders_count'];
    state = json['state'];
    totalSpent = json['total_spent'];
    lastOrderId = json['last_order_id'];
    note = json['note'];
    verifiedEmail = json['verified_email'];
    multipassIdentifier = json['multipass_identifier'];
    taxExempt = json['tax_exempt'];
    tags = json['tags'];
    lastOrderName = json['last_order_name'];
    currency = json['currency'];
    phone = json['phone'];
    acceptsMarketingUpdatedAt = json['accepts_marketing_updated_at'];
    marketingOptInLevel = json['marketing_opt_in_level'];
    smsMarketingConsent = json['sms_marketing_consent'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['id'] = this.id;
    data['accepts_marketing'] = this.acceptsMarketing;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['orders_count'] = this.ordersCount;
    data['state'] = this.state;
    data['total_spent'] = this.totalSpent;
    data['last_order_id'] = this.lastOrderId;
    data['note'] = this.note;
    data['verified_email'] = this.verifiedEmail;
    data['multipass_identifier'] = this.multipassIdentifier;
    data['tax_exempt'] = this.taxExempt;
    data['tags'] = this.tags;
    data['last_order_name'] = this.lastOrderName;
    data['currency'] = this.currency;
    data['phone'] = this.phone;
    data['accepts_marketing_updated_at'] = this.acceptsMarketingUpdatedAt;
    data['marketing_opt_in_level'] = this.marketingOptInLevel;
    data['sms_marketing_consent'] = this.smsMarketingConsent;
    data['admin_graphql_api_id'] = this.adminGraphqlApiId;
    return data;
  }
}
