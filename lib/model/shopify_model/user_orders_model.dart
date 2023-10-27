class UserOrdersModel {
  List<Orders>? orders;

  UserOrdersModel({this.orders});

  UserOrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? id;
  dynamic adminGraphqlApiId;
  int? appId;
  dynamic browserIp;
  dynamic buyerAcceptsMarketing;
  dynamic cancelReason;
  dynamic cancelledAt;
  dynamic cartToken;
  int? checkoutId;
  dynamic checkoutToken;
  ClientDetails? clientDetails;
  dynamic closedAt;
  dynamic confirmed;
  dynamic contactEmail;
  dynamic createdAt;
  dynamic currency;
  dynamic currentSubtotalPrice;
  CurrentSubtotalPriceSet? currentSubtotalPriceSet;
  dynamic currentTotalDiscounts;
  CurrentSubtotalPriceSet? currentTotalDiscountsSet;
  dynamic currentTotalDutiesSet;
  dynamic currentTotalPrice;
  CurrentSubtotalPriceSet? currentTotalPriceSet;
  dynamic currentTotalTax;
  CurrentSubtotalPriceSet? currentTotalTaxSet;
  dynamic customerLocale;
  dynamic deviceId;
  // List<Null>? discountCodes;
  dynamic email;
  dynamic estimatedTaxes;
  dynamic financialStatus;
  dynamic fulfillmentStatus;
  dynamic gateway;
  dynamic landingSite;
  dynamic landingSiteRef;
  dynamic locationId;
  dynamic merchantOfRecordAppId;
  dynamic name;
  dynamic note;
  // List<Null>? noteAttributes;
  int? number;
  int? orderNumber;
  dynamic orderStatusUrl;
  dynamic originalTotalDutiesSet;
  List<String>? paymentGatewayNames;
  dynamic phone;
  dynamic presentmentCurrency;
  dynamic processedAt;
  dynamic processingMethod;
  dynamic reference;
  dynamic referringSite;
  dynamic sourceIdentifier;
  dynamic sourceName;
  dynamic sourceUrl;
  dynamic subtotalPrice;
  CurrentSubtotalPriceSet? subtotalPriceSet;
  dynamic tags;
  // List<Null>? taxLines;
  dynamic taxesIncluded;
  dynamic test;
  dynamic token;
  dynamic totalDiscounts;
  CurrentSubtotalPriceSet? totalDiscountsSet;
  dynamic totalLineItemsPrice;
  CurrentSubtotalPriceSet? totalLineItemsPriceSet;
  dynamic totalOutstanding;
  dynamic totalPrice;
  CurrentSubtotalPriceSet? totalPriceSet;
  CurrentSubtotalPriceSet? totalShippingPriceSet;
  dynamic totalTax;
  CurrentSubtotalPriceSet? totalTaxSet;
  dynamic totalTipReceived;
  int? totalWeight;
  dynamic updatedAt;
  dynamic userId;
  BillingAddress? billingAddress;
  Customer? customer;
  // List<Null>? discountApplications;
  // List<Null>? fulfillments;
  List<LineItems>? lineItems;
  dynamic paymentTerms;
  // List<Null>? refunds;
  BillingAddress? shippingAddress;
  List<ShippingLines>? shippingLines;

  Orders(
      {this.id,
      this.adminGraphqlApiId,
      this.appId,
      this.browserIp,
      this.buyerAcceptsMarketing,
      this.cancelReason,
      this.cancelledAt,
      this.cartToken,
      this.checkoutId,
      this.checkoutToken,
      this.clientDetails,
      this.closedAt,
      this.confirmed,
      this.contactEmail,
      this.createdAt,
      this.currency,
      this.currentSubtotalPrice,
      this.currentSubtotalPriceSet,
      this.currentTotalDiscounts,
      this.currentTotalDiscountsSet,
      this.currentTotalDutiesSet,
      this.currentTotalPrice,
      this.currentTotalPriceSet,
      this.currentTotalTax,
      this.currentTotalTaxSet,
      this.customerLocale,
      this.deviceId,
      // this.discountCodes,
      this.email,
      this.estimatedTaxes,
      this.financialStatus,
      this.fulfillmentStatus,
      this.gateway,
      this.landingSite,
      this.landingSiteRef,
      this.locationId,
      this.merchantOfRecordAppId,
      this.name,
      this.note,
      // this.noteAttributes,
      this.number,
      this.orderNumber,
      this.orderStatusUrl,
      this.originalTotalDutiesSet,
      this.paymentGatewayNames,
      this.phone,
      this.presentmentCurrency,
      this.processedAt,
      this.processingMethod,
      this.reference,
      this.referringSite,
      this.sourceIdentifier,
      this.sourceName,
      this.sourceUrl,
      this.subtotalPrice,
      this.subtotalPriceSet,
      this.tags,
      // this.taxLines,
      this.taxesIncluded,
      this.test,
      this.token,
      this.totalDiscounts,
      this.totalDiscountsSet,
      this.totalLineItemsPrice,
      this.totalLineItemsPriceSet,
      this.totalOutstanding,
      this.totalPrice,
      this.totalPriceSet,
      this.totalShippingPriceSet,
      this.totalTax,
      this.totalTaxSet,
      this.totalTipReceived,
      this.totalWeight,
      this.updatedAt,
      this.userId,
      this.billingAddress,
      this.customer,
      // this.discountApplications,
      // this.fulfillments,
      this.lineItems,
      this.paymentTerms,
      // this.refunds,
      this.shippingAddress,
      this.shippingLines});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
    appId = json['app_id'];
    browserIp = json['browser_ip'];
    buyerAcceptsMarketing = json['buyer_accepts_marketing'];
    cancelReason = json['cancel_reason'];
    cancelledAt = json['cancelled_at'];
    cartToken = json['cart_token'];
    checkoutId = json['checkout_id'];
    checkoutToken = json['checkout_token'];
    clientDetails = json['client_details'] != null
        ? new ClientDetails.fromJson(json['client_details'])
        : null;
    closedAt = json['closed_at'];
    confirmed = json['confirmed'];
    contactEmail = json['contact_email'];
    createdAt = json['created_at'];
    currency = json['currency'];
    currentSubtotalPrice = json['current_subtotal_price'];
    currentSubtotalPriceSet = json['current_subtotal_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(
            json['current_subtotal_price_set'])
        : null;
    currentTotalDiscounts = json['current_total_discounts'];
    currentTotalDiscountsSet = json['current_total_discounts_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(
            json['current_total_discounts_set'])
        : null;
    currentTotalDutiesSet = json['current_total_duties_set'];
    currentTotalPrice = json['current_total_price'];
    currentTotalPriceSet = json['current_total_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['current_total_price_set'])
        : null;
    currentTotalTax = json['current_total_tax'];
    currentTotalTaxSet = json['current_total_tax_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['current_total_tax_set'])
        : null;
    customerLocale = json['customer_locale'];
    deviceId = json['device_id'];
    // if (json['discount_codes'] != null) {
    //   discountCodes = <Null>[];
    //   json['discount_codes'].forEach((v) {
    //     discountCodes!.add(new Null.fromJson(v));
    //   });
    // }
    email = json['email'];
    estimatedTaxes = json['estimated_taxes'];
    financialStatus = json['financial_status'];
    fulfillmentStatus = json['fulfillment_status'];
    gateway = json['gateway'];
    landingSite = json['landing_site'];
    landingSiteRef = json['landing_site_ref'];
    locationId = json['location_id'];
    merchantOfRecordAppId = json['merchant_of_record_app_id'];
    name = json['name'];
    note = json['note'];
    // if (json['note_attributes'] != null) {
    //   noteAttributes = <Null>[];
    //   json['note_attributes'].forEach((v) {
    //     noteAttributes!.add(new Null.fromJson(v));
    //   });
    // }
    number = json['number'];
    orderNumber = json['order_number'];
    orderStatusUrl = json['order_status_url'];
    originalTotalDutiesSet = json['original_total_duties_set'];
    paymentGatewayNames = json['payment_gateway_names'].cast<String>();
    phone = json['phone'];
    presentmentCurrency = json['presentment_currency'];
    processedAt = json['processed_at'];
    processingMethod = json['processing_method'];
    reference = json['reference'];
    referringSite = json['referring_site'];
    sourceIdentifier = json['source_identifier'];
    sourceName = json['source_name'];
    sourceUrl = json['source_url'];
    subtotalPrice = json['subtotal_price'];
    subtotalPriceSet = json['subtotal_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['subtotal_price_set'])
        : null;
    tags = json['tags'];
    // if (json['tax_lines'] != null) {
    //   taxLines = <Null>[];
    //   json['tax_lines'].forEach((v) {
    //     taxLines!.add(new Null.fromJson(v));
    //   });
    // }
    taxesIncluded = json['taxes_included'];
    test = json['test'];
    token = json['token'];
    totalDiscounts = json['total_discounts'];
    totalDiscountsSet = json['total_discounts_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['total_discounts_set'])
        : null;
    totalLineItemsPrice = json['total_line_items_price'];
    totalLineItemsPriceSet = json['total_line_items_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(
            json['total_line_items_price_set'])
        : null;
    totalOutstanding = json['total_outstanding'];
    totalPrice = json['total_price'];
    totalPriceSet = json['total_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['total_price_set'])
        : null;
    totalShippingPriceSet = json['total_shipping_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['total_shipping_price_set'])
        : null;
    totalTax = json['total_tax'];
    totalTaxSet = json['total_tax_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['total_tax_set'])
        : null;
    totalTipReceived = json['total_tip_received'];
    totalWeight = json['total_weight'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    // if (json['discount_applications'] != null) {
    //   discountApplications = <Null>[];
    //   json['discount_applications'].forEach((v) {
    //     discountApplications!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['fulfillments'] != null) {
    //   fulfillments = <Null>[];
    //   json['fulfillments'].forEach((v) {
    //     fulfillments!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add(new LineItems.fromJson(v));
      });
    }
    paymentTerms = json['payment_terms'];
    // if (json['refunds'] != null) {
    //   refunds = <Null>[];
    //   json['refunds'].forEach((v) {
    //     refunds!.add(new Null.fromJson(v));
    //   });
    // }
    shippingAddress = json['shipping_address'] != null
        ? new BillingAddress.fromJson(json['shipping_address'])
        : null;
    if (json['shipping_lines'] != null) {
      shippingLines = <ShippingLines>[];
      json['shipping_lines'].forEach((v) {
        shippingLines!.add(new ShippingLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admin_graphql_api_id'] = this.adminGraphqlApiId;
    data['app_id'] = this.appId;
    data['browser_ip'] = this.browserIp;
    data['buyer_accepts_marketing'] = this.buyerAcceptsMarketing;
    data['cancel_reason'] = this.cancelReason;
    data['cancelled_at'] = this.cancelledAt;
    data['cart_token'] = this.cartToken;
    data['checkout_id'] = this.checkoutId;
    data['checkout_token'] = this.checkoutToken;
    if (this.clientDetails != null) {
      data['client_details'] = this.clientDetails!.toJson();
    }
    data['closed_at'] = this.closedAt;
    data['confirmed'] = this.confirmed;
    data['contact_email'] = this.contactEmail;
    data['created_at'] = this.createdAt;
    data['currency'] = this.currency;
    data['current_subtotal_price'] = this.currentSubtotalPrice;
    if (this.currentSubtotalPriceSet != null) {
      data['current_subtotal_price_set'] =
          this.currentSubtotalPriceSet!.toJson();
    }
    data['current_total_discounts'] = this.currentTotalDiscounts;
    if (this.currentTotalDiscountsSet != null) {
      data['current_total_discounts_set'] =
          this.currentTotalDiscountsSet!.toJson();
    }
    data['current_total_duties_set'] = this.currentTotalDutiesSet;
    data['current_total_price'] = this.currentTotalPrice;
    if (this.currentTotalPriceSet != null) {
      data['current_total_price_set'] = this.currentTotalPriceSet!.toJson();
    }
    data['current_total_tax'] = this.currentTotalTax;
    if (this.currentTotalTaxSet != null) {
      data['current_total_tax_set'] = this.currentTotalTaxSet!.toJson();
    }
    data['customer_locale'] = this.customerLocale;
    data['device_id'] = this.deviceId;
    // if (this.discountCodes != null) {
    //   data['discount_codes'] =
    //       this.discountCodes!.map((v) => v.toJson()).toList();
    // }
    data['email'] = this.email;
    data['estimated_taxes'] = this.estimatedTaxes;
    data['financial_status'] = this.financialStatus;
    data['fulfillment_status'] = this.fulfillmentStatus;
    data['gateway'] = this.gateway;
    data['landing_site'] = this.landingSite;
    data['landing_site_ref'] = this.landingSiteRef;
    data['location_id'] = this.locationId;
    data['merchant_of_record_app_id'] = this.merchantOfRecordAppId;
    data['name'] = this.name;
    data['note'] = this.note;
    // if (this.noteAttributes != null) {
    //   data['note_attributes'] =
    //       this.noteAttributes!.map((v) => v.toJson()).toList();
    // }
    data['number'] = this.number;
    data['order_number'] = this.orderNumber;
    data['order_status_url'] = this.orderStatusUrl;
    data['original_total_duties_set'] = this.originalTotalDutiesSet;
    data['payment_gateway_names'] = this.paymentGatewayNames;
    data['phone'] = this.phone;
    data['presentment_currency'] = this.presentmentCurrency;
    data['processed_at'] = this.processedAt;
    data['processing_method'] = this.processingMethod;
    data['reference'] = this.reference;
    data['referring_site'] = this.referringSite;
    data['source_identifier'] = this.sourceIdentifier;
    data['source_name'] = this.sourceName;
    data['source_url'] = this.sourceUrl;
    data['subtotal_price'] = this.subtotalPrice;
    if (this.subtotalPriceSet != null) {
      data['subtotal_price_set'] = this.subtotalPriceSet!.toJson();
    }
    data['tags'] = this.tags;
    // if (this.taxLines != null) {
    //   data['tax_lines'] = this.taxLines!.map((v) => v.toJson()).toList();
    // }
    data['taxes_included'] = this.taxesIncluded;
    data['test'] = this.test;
    data['token'] = this.token;
    data['total_discounts'] = this.totalDiscounts;
    if (this.totalDiscountsSet != null) {
      data['total_discounts_set'] = this.totalDiscountsSet!.toJson();
    }
    data['total_line_items_price'] = this.totalLineItemsPrice;
    if (this.totalLineItemsPriceSet != null) {
      data['total_line_items_price_set'] =
          this.totalLineItemsPriceSet!.toJson();
    }
    data['total_outstanding'] = this.totalOutstanding;
    data['total_price'] = this.totalPrice;
    if (this.totalPriceSet != null) {
      data['total_price_set'] = this.totalPriceSet!.toJson();
    }
    if (this.totalShippingPriceSet != null) {
      data['total_shipping_price_set'] = this.totalShippingPriceSet!.toJson();
    }
    data['total_tax'] = this.totalTax;
    if (this.totalTaxSet != null) {
      data['total_tax_set'] = this.totalTaxSet!.toJson();
    }
    data['total_tip_received'] = this.totalTipReceived;
    data['total_weight'] = this.totalWeight;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    // if (this.discountApplications != null) {
    //   data['discount_applications'] =
    //       this.discountApplications!.map((v) => v.toJson()).toList();
    // }
    // if (this.fulfillments != null) {
    //   data['fulfillments'] = this.fulfillments!.map((v) => v.toJson()).toList();
    // }
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
    }
    data['payment_terms'] = this.paymentTerms;
    // if (this.refunds != null) {
    //   data['refunds'] = this.refunds!.map((v) => v.toJson()).toList();
    // }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    if (this.shippingLines != null) {
      data['shipping_lines'] =
          this.shippingLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientDetails {
  dynamic acceptLanguage;
  dynamic browserHeight;
  dynamic browserIp;
  dynamic browserWidth;
  dynamic sessionHash;
  dynamic userAgent;

  ClientDetails(
      {this.acceptLanguage,
      this.browserHeight,
      this.browserIp,
      this.browserWidth,
      this.sessionHash,
      this.userAgent});

  ClientDetails.fromJson(Map<String, dynamic> json) {
    acceptLanguage = json['accept_language'];
    browserHeight = json['browser_height'];
    browserIp = json['browser_ip'];
    browserWidth = json['browser_width'];
    sessionHash = json['session_hash'];
    userAgent = json['user_agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accept_language'] = this.acceptLanguage;
    data['browser_height'] = this.browserHeight;
    data['browser_ip'] = this.browserIp;
    data['browser_width'] = this.browserWidth;
    data['session_hash'] = this.sessionHash;
    data['user_agent'] = this.userAgent;
    return data;
  }
}

class CurrentSubtotalPriceSet {
  ShopMoney? shopMoney;
  ShopMoney? presentmentMoney;

  CurrentSubtotalPriceSet({this.shopMoney, this.presentmentMoney});

  CurrentSubtotalPriceSet.fromJson(Map<String, dynamic> json) {
    shopMoney = json['shop_money'] != null
        ? new ShopMoney.fromJson(json['shop_money'])
        : null;
    presentmentMoney = json['presentment_money'] != null
        ? new ShopMoney.fromJson(json['presentment_money'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shopMoney != null) {
      data['shop_money'] = this.shopMoney!.toJson();
    }
    if (this.presentmentMoney != null) {
      data['presentment_money'] = this.presentmentMoney!.toJson();
    }
    return data;
  }
}

class ShopMoney {
  dynamic amount;
  dynamic currencyCode;

  ShopMoney({this.amount, this.currencyCode});

  ShopMoney.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currencyCode = json['currency_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency_code'] = this.currencyCode;
    return data;
  }
}

class BillingAddress {
  dynamic firstName;
  dynamic address1;
  dynamic phone;
  dynamic city;
  dynamic zip;
  dynamic province;
  dynamic country;
  dynamic lastName;
  dynamic address2;
  dynamic company;
  double? latitude;
  double? longitude;
  dynamic name;
  dynamic countryCode;
  dynamic provinceCode;

  BillingAddress(
      {this.firstName,
      this.address1,
      this.phone,
      this.city,
      this.zip,
      this.province,
      this.country,
      this.lastName,
      this.address2,
      this.company,
      this.latitude,
      this.longitude,
      this.name,
      this.countryCode,
      this.provinceCode});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    address1 = json['address1'];
    phone = json['phone'];
    city = json['city'];
    zip = json['zip'];
    province = json['province'];
    country = json['country'];
    lastName = json['last_name'];
    address2 = json['address2'];
    company = json['company'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    countryCode = json['country_code'];
    provinceCode = json['province_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['address1'] = this.address1;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['province'] = this.province;
    data['country'] = this.country;
    data['last_name'] = this.lastName;
    data['address2'] = this.address2;
    data['company'] = this.company;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['province_code'] = this.provinceCode;
    return data;
  }
}

class Customer {
  int? id;
  dynamic email;
  dynamic acceptsMarketing;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic firstName;
  dynamic lastName;
  dynamic state;
  dynamic note;
  dynamic verifiedEmail;
  dynamic multipassIdentifier;
  dynamic taxExempt;
  dynamic phone;
  EmailMarketingConsent? emailMarketingConsent;
  dynamic smsMarketingConsent;
  dynamic tags;
  dynamic currency;
  dynamic acceptsMarketingUpdatedAt;
  dynamic marketingOptInLevel;
  // List<Null>? taxExemptions;
  dynamic adminGraphqlApiId;
  DefaultAddress? defaultAddress;

  Customer(
      {this.id,
      this.email,
      this.acceptsMarketing,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName,
      this.state,
      this.note,
      this.verifiedEmail,
      this.multipassIdentifier,
      this.taxExempt,
      this.phone,
      this.emailMarketingConsent,
      this.smsMarketingConsent,
      this.tags,
      this.currency,
      this.acceptsMarketingUpdatedAt,
      this.marketingOptInLevel,
      // this.taxExemptions,
      this.adminGraphqlApiId,
      this.defaultAddress});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    acceptsMarketing = json['accepts_marketing'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    state = json['state'];
    note = json['note'];
    verifiedEmail = json['verified_email'];
    multipassIdentifier = json['multipass_identifier'];
    taxExempt = json['tax_exempt'];
    phone = json['phone'];
    emailMarketingConsent = json['email_marketing_consent'] != null
        ? new EmailMarketingConsent.fromJson(json['email_marketing_consent'])
        : null;
    smsMarketingConsent = json['sms_marketing_consent'];
    tags = json['tags'];
    currency = json['currency'];
    acceptsMarketingUpdatedAt = json['accepts_marketing_updated_at'];
    marketingOptInLevel = json['marketing_opt_in_level'];
    // if (json['tax_exemptions'] != null) {
    //   taxExemptions = <Null>[];
    //   json['tax_exemptions'].forEach((v) {
    //     taxExemptions!.add(new Null.fromJson(v));
    //   });
    // }
    adminGraphqlApiId = json['admin_graphql_api_id'];
    defaultAddress = json['default_address'] != null
        ? new DefaultAddress.fromJson(json['default_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['accepts_marketing'] = this.acceptsMarketing;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['state'] = this.state;
    data['note'] = this.note;
    data['verified_email'] = this.verifiedEmail;
    data['multipass_identifier'] = this.multipassIdentifier;
    data['tax_exempt'] = this.taxExempt;
    data['phone'] = this.phone;
    if (this.emailMarketingConsent != null) {
      data['email_marketing_consent'] = this.emailMarketingConsent!.toJson();
    }
    data['sms_marketing_consent'] = this.smsMarketingConsent;
    data['tags'] = this.tags;
    data['currency'] = this.currency;
    data['accepts_marketing_updated_at'] = this.acceptsMarketingUpdatedAt;
    data['marketing_opt_in_level'] = this.marketingOptInLevel;
    // if (this.taxExemptions != null) {
    //   data['tax_exemptions'] =
    //       this.taxExemptions!.map((v) => v.toJson()).toList();
    // }
    data['admin_graphql_api_id'] = this.adminGraphqlApiId;
    if (this.defaultAddress != null) {
      data['default_address'] = this.defaultAddress!.toJson();
    }
    return data;
  }
}

class EmailMarketingConsent {
  dynamic state;
  dynamic optInLevel;
  dynamic consentUpdatedAt;

  EmailMarketingConsent({this.state, this.optInLevel, this.consentUpdatedAt});

  EmailMarketingConsent.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    optInLevel = json['opt_in_level'];
    consentUpdatedAt = json['consent_updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['opt_in_level'] = this.optInLevel;
    data['consent_updated_at'] = this.consentUpdatedAt;
    return data;
  }
}

class DefaultAddress {
  int? id;
  int? customerId;
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

  DefaultAddress(
      {this.id,
      this.customerId,
      this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.province,
      this.country,
      this.zip,
      this.phone,
      this.name,
      this.provinceCode,
      this.countryCode,
      this.countryName,
      this.defaultAddress});

  DefaultAddress.fromJson(Map<String, dynamic> json) {
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

class LineItems {
  dynamic id;
  dynamic adminGraphqlApiId;
  dynamic fulfillableQuantity;
  dynamic fulfillmentService;
  dynamic fulfillmentStatus;
  dynamic giftCard;
  dynamic grams;
  dynamic name;
  dynamic price;
  CurrentSubtotalPriceSet? priceSet;
  dynamic productExists;
  int? productId;
  // List<Null>? properties;
  int? quantity;
  dynamic requiresShipping;
  dynamic sku;
  dynamic taxable;
  dynamic title;
  dynamic totalDiscount;
  CurrentSubtotalPriceSet? totalDiscountSet;
  int? variantId;
  dynamic variantInventoryManagement;
  dynamic variantTitle;
  dynamic vendor;
  // List<Null>? taxLines;
  // List<Null>? duties;
  // List<Null>? discountAllocations;

  LineItems(
      {this.id,
      this.adminGraphqlApiId,
      this.fulfillableQuantity,
      this.fulfillmentService,
      this.fulfillmentStatus,
      this.giftCard,
      this.grams,
      this.name,
      this.price,
      this.priceSet,
      this.productExists,
      this.productId,
      // this.properties,
      this.quantity,
      this.requiresShipping,
      this.sku,
      this.taxable,
      this.title,
      this.totalDiscount,
      this.totalDiscountSet,
      this.variantId,
      this.variantInventoryManagement,
      this.variantTitle,
      this.vendor,
      // this.taxLines,
      // this.duties,
      // this.discountAllocations
      });

  LineItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
    fulfillableQuantity = json['fulfillable_quantity'];
    fulfillmentService = json['fulfillment_service'];
    fulfillmentStatus = json['fulfillment_status'];
    giftCard = json['gift_card'];
    grams = json['grams'];
    name = json['name'];
    price = json['price'];
    priceSet = json['price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['price_set'])
        : null;
    productExists = json['product_exists'];
    productId = json['product_id'];
    // if (json['properties'] != null) {
    //   properties = <Null>[];
    //   json['properties'].forEach((v) {
    //     properties!.add(new Null.fromJson(v));
    //   });
    // }
    quantity = json['quantity'];
    requiresShipping = json['requires_shipping'];
    sku = json['sku'];
    taxable = json['taxable'];
    title = json['title'];
    totalDiscount = json['total_discount'];
    totalDiscountSet = json['total_discount_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['total_discount_set'])
        : null;
    variantId = json['variant_id'];
    variantInventoryManagement = json['variant_inventory_management'];
    variantTitle = json['variant_title'];
    vendor = json['vendor'];
    // if (json['tax_lines'] != null) {
    //   taxLines = <Null>[];
    //   json['tax_lines'].forEach((v) {
    //     taxLines!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['duties'] != null) {
    //   duties = <Null>[];
    //   json['duties'].forEach((v) {
    //     duties!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['discount_allocations'] != null) {
    //   discountAllocations = <Null>[];
    //   json['discount_allocations'].forEach((v) {
    //     discountAllocations!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admin_graphql_api_id'] = this.adminGraphqlApiId;
    data['fulfillable_quantity'] = this.fulfillableQuantity;
    data['fulfillment_service'] = this.fulfillmentService;
    data['fulfillment_status'] = this.fulfillmentStatus;
    data['gift_card'] = this.giftCard;
    data['grams'] = this.grams;
    data['name'] = this.name;
    data['price'] = this.price;
    if (this.priceSet != null) {
      data['price_set'] = this.priceSet!.toJson();
    }
    data['product_exists'] = this.productExists;
    data['product_id'] = this.productId;
    // if (this.properties != null) {
    //   data['properties'] = this.properties!.map((v) => v.toJson()).toList();
    // }
    data['quantity'] = this.quantity;
    data['requires_shipping'] = this.requiresShipping;
    data['sku'] = this.sku;
    data['taxable'] = this.taxable;
    data['title'] = this.title;
    data['total_discount'] = this.totalDiscount;
    if (this.totalDiscountSet != null) {
      data['total_discount_set'] = this.totalDiscountSet!.toJson();
    }
    data['variant_id'] = this.variantId;
    data['variant_inventory_management'] = this.variantInventoryManagement;
    data['variant_title'] = this.variantTitle;
    data['vendor'] = this.vendor;
    // if (this.taxLines != null) {
    //   data['tax_lines'] = this.taxLines!.map((v) => v.toJson()).toList();
    // }
    // if (this.duties != null) {
    //   data['duties'] = this.duties!.map((v) => v.toJson()).toList();
    // }
    // if (this.discountAllocations != null) {
    //   data['discount_allocations'] =
    //       this.discountAllocations!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class ShippingLines {
  int? id;
  dynamic carrierIdentifier;
  dynamic code;
  dynamic deliveryCategory;
  dynamic discountedPrice;
  CurrentSubtotalPriceSet? discountedPriceSet;
  dynamic phone;
  dynamic price;
  CurrentSubtotalPriceSet? priceSet;
  dynamic requestedFulfillmentServiceId;
  dynamic source;
  dynamic title;
  // List<Null>? taxLines;
  // List<Null>? discountAllocations;

  ShippingLines(
      {this.id,
      this.carrierIdentifier,
      this.code,
      this.deliveryCategory,
      this.discountedPrice,
      this.discountedPriceSet,
      this.phone,
      this.price,
      this.priceSet,
      this.requestedFulfillmentServiceId,
      this.source,
      this.title,
      // this.taxLines,
      // this.discountAllocations
      });

  ShippingLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carrierIdentifier = json['carrier_identifier'];
    code = json['code'];
    deliveryCategory = json['delivery_category'];
    discountedPrice = json['discounted_price'];
    discountedPriceSet = json['discounted_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['discounted_price_set'])
        : null;
    phone = json['phone'];
    price = json['price'];
    priceSet = json['price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['price_set'])
        : null;
    requestedFulfillmentServiceId = json['requested_fulfillment_service_id'];
    source = json['source'];
    title = json['title'];
    // if (json['tax_lines'] != null) {
    //   taxLines = <Null>[];
    //   json['tax_lines'].forEach((v) {
    //     taxLines!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['discount_allocations'] != null) {
    //   discountAllocations = <Null>[];
    //   json['discount_allocations'].forEach((v) {
    //     discountAllocations!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carrier_identifier'] = this.carrierIdentifier;
    data['code'] = this.code;
    data['delivery_category'] = this.deliveryCategory;
    data['discounted_price'] = this.discountedPrice;
    if (this.discountedPriceSet != null) {
      data['discounted_price_set'] = this.discountedPriceSet!.toJson();
    }
    data['phone'] = this.phone;
    data['price'] = this.price;
    if (this.priceSet != null) {
      data['price_set'] = this.priceSet!.toJson();
    }
    data['requested_fulfillment_service_id'] =
        this.requestedFulfillmentServiceId;
    data['source'] = this.source;
    data['title'] = this.title;
    // if (this.taxLines != null) {
    //   data['tax_lines'] = this.taxLines!.map((v) => v.toJson()).toList();
    // }
    // if (this.discountAllocations != null) {
    //   data['discount_allocations'] =
    //       this.discountAllocations!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class OrdersNew {
  int? id;
  dynamic adminGraphqlApiId;
  int? appId;
  dynamic browserIp;
  dynamic buyerAcceptsMarketing;
  dynamic cancelReason;
  dynamic cancelledAt;
  dynamic cartToken;
  int? checkoutId;
  dynamic checkoutToken;
  ClientDetails? clientDetails;
  dynamic closedAt;
  dynamic confirmed;
  dynamic contactEmail;
  dynamic createdAt;
  dynamic currency;
  dynamic currentSubtotalPrice;
  CurrentSubtotalPriceSet? currentSubtotalPriceSet;
  dynamic currentTotalDiscounts;
  CurrentSubtotalPriceSet? currentTotalDiscountsSet;
  dynamic currentTotalDutiesSet;
  dynamic currentTotalPrice;
  CurrentSubtotalPriceSet? currentTotalPriceSet;
  dynamic currentTotalTax;
  CurrentSubtotalPriceSet? currentTotalTaxSet;
  dynamic customerLocale;
  dynamic deviceId;
  // List<Null>? discountCodes;
  dynamic email;
  dynamic estimatedTaxes;
  dynamic financialStatus;
  dynamic fulfillmentStatus;
  dynamic gateway;
  dynamic landingSite;
  dynamic landingSiteRef;
  dynamic locationId;
  dynamic merchantOfRecordAppId;
  dynamic name;
  dynamic note;
  // List<Null>? noteAttributes;
  int? number;
  int? orderNumber;
  dynamic orderStatusUrl;
  dynamic originalTotalDutiesSet;
  List<String>? paymentGatewayNames;
  dynamic phone;
  dynamic presentmentCurrency;
  dynamic processedAt;
  dynamic processingMethod;
  dynamic reference;
  dynamic referringSite;
  dynamic sourceIdentifier;
  dynamic sourceName;
  dynamic sourceUrl;
  dynamic subtotalPrice;
  CurrentSubtotalPriceSet? subtotalPriceSet;
  dynamic tags;
  // List<Null>? taxLines;
  dynamic taxesIncluded;
  dynamic test;
  dynamic token;
  dynamic totalDiscounts;
  CurrentSubtotalPriceSet? totalDiscountsSet;
  dynamic totalLineItemsPrice;
  CurrentSubtotalPriceSet? totalLineItemsPriceSet;
  dynamic totalOutstanding;
  dynamic totalPrice;
  CurrentSubtotalPriceSet? totalPriceSet;
  CurrentSubtotalPriceSet? totalShippingPriceSet;
  dynamic totalTax;
  CurrentSubtotalPriceSet? totalTaxSet;
  dynamic totalTipReceived;
  int? totalWeight;
  dynamic updatedAt;
  dynamic userId;
  BillingAddress? billingAddress;
  Customer? customer;
  // List<Null>? discountApplications;
  // List<Null>? fulfillments;
  List<LineItems>? lineItems;
  dynamic paymentTerms;
  // List<Null>? refunds;
  BillingAddress? shippingAddress;
  List<ShippingLines>? shippingLines;

  OrdersNew(
      {this.id,
      this.adminGraphqlApiId,
      this.appId,
      this.browserIp,
      this.buyerAcceptsMarketing,
      this.cancelReason,
      this.cancelledAt,
      this.cartToken,
      this.checkoutId,
      this.checkoutToken,
      this.clientDetails,
      this.closedAt,
      this.confirmed,
      this.contactEmail,
      this.createdAt,
      this.currency,
      this.currentSubtotalPrice,
      this.currentSubtotalPriceSet,
      this.currentTotalDiscounts,
      this.currentTotalDiscountsSet,
      this.currentTotalDutiesSet,
      this.currentTotalPrice,
      this.currentTotalPriceSet,
      this.currentTotalTax,
      this.currentTotalTaxSet,
      this.customerLocale,
      this.deviceId,
      // this.discountCodes,
      this.email,
      this.estimatedTaxes,
      this.financialStatus,
      this.fulfillmentStatus,
      this.gateway,
      this.landingSite,
      this.landingSiteRef,
      this.locationId,
      this.merchantOfRecordAppId,
      this.name,
      this.note,
      // this.noteAttributes,
      this.number,
      this.orderNumber,
      this.orderStatusUrl,
      this.originalTotalDutiesSet,
      this.paymentGatewayNames,
      this.phone,
      this.presentmentCurrency,
      this.processedAt,
      this.processingMethod,
      this.reference,
      this.referringSite,
      this.sourceIdentifier,
      this.sourceName,
      this.sourceUrl,
      this.subtotalPrice,
      this.subtotalPriceSet,
      this.tags,
      // this.taxLines,
      this.taxesIncluded,
      this.test,
      this.token,
      this.totalDiscounts,
      this.totalDiscountsSet,
      this.totalLineItemsPrice,
      this.totalLineItemsPriceSet,
      this.totalOutstanding,
      this.totalPrice,
      this.totalPriceSet,
      this.totalShippingPriceSet,
      this.totalTax,
      this.totalTaxSet,
      this.totalTipReceived,
      this.totalWeight,
      this.updatedAt,
      this.userId,
      this.billingAddress,
      this.customer,
      // this.discountApplications,
      // this.fulfillments,
      this.lineItems,
      this.paymentTerms,
      // this.refunds,
      this.shippingAddress,
      this.shippingLines});

  OrdersNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
    appId = json['app_id'];
    browserIp = json['browser_ip'];
    buyerAcceptsMarketing = json['buyer_accepts_marketing'];
    cancelReason = json['cancel_reason'];
    cancelledAt = json['cancelled_at'];
    cartToken = json['cart_token'];
    checkoutId = json['checkout_id'];
    checkoutToken = json['checkout_token'];
    clientDetails = json['client_details'] != null
        ? new ClientDetails.fromJson(json['client_details'])
        : null;
    closedAt = json['closed_at'];
    confirmed = json['confirmed'];
    contactEmail = json['contact_email'];
    createdAt = json['created_at'];
    currency = json['currency'];
    currentSubtotalPrice = json['current_subtotal_price'];
    currentSubtotalPriceSet = json['current_subtotal_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(
            json['current_subtotal_price_set'])
        : null;
    currentTotalDiscounts = json['current_total_discounts'];
    currentTotalDiscountsSet = json['current_total_discounts_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(
            json['current_total_discounts_set'])
        : null;
    currentTotalDutiesSet = json['current_total_duties_set'];
    currentTotalPrice = json['current_total_price'];
    currentTotalPriceSet = json['current_total_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['current_total_price_set'])
        : null;
    currentTotalTax = json['current_total_tax'];
    currentTotalTaxSet = json['current_total_tax_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['current_total_tax_set'])
        : null;
    customerLocale = json['customer_locale'];
    deviceId = json['device_id'];
    // if (json['discount_codes'] != null) {
    //   discountCodes = <Null>[];
    //   json['discount_codes'].forEach((v) {
    //     discountCodes!.add(new Null.fromJson(v));
    //   });
    // }
    email = json['email'];
    estimatedTaxes = json['estimated_taxes'];
    financialStatus = json['financial_status'];
    fulfillmentStatus = json['fulfillment_status'];
    gateway = json['gateway'];
    landingSite = json['landing_site'];
    landingSiteRef = json['landing_site_ref'];
    locationId = json['location_id'];
    merchantOfRecordAppId = json['merchant_of_record_app_id'];
    name = json['name'];
    note = json['note'];
    // if (json['note_attributes'] != null) {
    //   noteAttributes = <Null>[];
    //   json['note_attributes'].forEach((v) {
    //     noteAttributes!.add(new Null.fromJson(v));
    //   });
    // }
    number = json['number'];
    orderNumber = json['order_number'];
    orderStatusUrl = json['order_status_url'];
    originalTotalDutiesSet = json['original_total_duties_set'];
    paymentGatewayNames = json['payment_gateway_names'].cast<String>();
    phone = json['phone'];
    presentmentCurrency = json['presentment_currency'];
    processedAt = json['processed_at'];
    processingMethod = json['processing_method'];
    reference = json['reference'];
    referringSite = json['referring_site'];
    sourceIdentifier = json['source_identifier'];
    sourceName = json['source_name'];
    sourceUrl = json['source_url'];
    subtotalPrice = json['subtotal_price'];
    subtotalPriceSet = json['subtotal_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['subtotal_price_set'])
        : null;
    tags = json['tags'];
    // if (json['tax_lines'] != null) {
    //   taxLines = <Null>[];
    //   json['tax_lines'].forEach((v) {
    //     taxLines!.add(new Null.fromJson(v));
    //   });
    // }
    taxesIncluded = json['taxes_included'];
    test = json['test'];
    token = json['token'];
    totalDiscounts = json['total_discounts'];
    totalDiscountsSet = json['total_discounts_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['total_discounts_set'])
        : null;
    totalLineItemsPrice = json['total_line_items_price'];
    totalLineItemsPriceSet = json['total_line_items_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(
            json['total_line_items_price_set'])
        : null;
    totalOutstanding = json['total_outstanding'];
    totalPrice = json['total_price'];
    totalPriceSet = json['total_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['total_price_set'])
        : null;
    totalShippingPriceSet = json['total_shipping_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['total_shipping_price_set'])
        : null;
    totalTax = json['total_tax'];
    totalTaxSet = json['total_tax_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['total_tax_set'])
        : null;
    totalTipReceived = json['total_tip_received'];
    totalWeight = json['total_weight'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    // if (json['discount_applications'] != null) {
    //   discountApplications = <Null>[];
    //   json['discount_applications'].forEach((v) {
    //     discountApplications!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['fulfillments'] != null) {
    //   fulfillments = <Null>[];
    //   json['fulfillments'].forEach((v) {
    //     fulfillments!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add(new LineItems.fromJson(v));
      });
    }
    paymentTerms = json['payment_terms'];
    // if (json['refunds'] != null) {
    //   refunds = <Null>[];
    //   json['refunds'].forEach((v) {
    //     refunds!.add(new Null.fromJson(v));
    //   });
    // }
    shippingAddress = json['shipping_address'] != null
        ? new BillingAddress.fromJson(json['shipping_address'])
        : null;
    if (json['shipping_lines'] != null) {
      shippingLines = <ShippingLines>[];
      json['shipping_lines'].forEach((v) {
        shippingLines!.add(new ShippingLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admin_graphql_api_id'] = this.adminGraphqlApiId;
    data['app_id'] = this.appId;
    data['browser_ip'] = this.browserIp;
    data['buyer_accepts_marketing'] = this.buyerAcceptsMarketing;
    data['cancel_reason'] = this.cancelReason;
    data['cancelled_at'] = this.cancelledAt;
    data['cart_token'] = this.cartToken;
    data['checkout_id'] = this.checkoutId;
    data['checkout_token'] = this.checkoutToken;
    if (this.clientDetails != null) {
      data['client_details'] = this.clientDetails!.toJson();
    }
    data['closed_at'] = this.closedAt;
    data['confirmed'] = this.confirmed;
    data['contact_email'] = this.contactEmail;
    data['created_at'] = this.createdAt;
    data['currency'] = this.currency;
    data['current_subtotal_price'] = this.currentSubtotalPrice;
    if (this.currentSubtotalPriceSet != null) {
      data['current_subtotal_price_set'] =
          this.currentSubtotalPriceSet!.toJson();
    }
    data['current_total_discounts'] = this.currentTotalDiscounts;
    if (this.currentTotalDiscountsSet != null) {
      data['current_total_discounts_set'] =
          this.currentTotalDiscountsSet!.toJson();
    }
    data['current_total_duties_set'] = this.currentTotalDutiesSet;
    data['current_total_price'] = this.currentTotalPrice;
    if (this.currentTotalPriceSet != null) {
      data['current_total_price_set'] = this.currentTotalPriceSet!.toJson();
    }
    data['current_total_tax'] = this.currentTotalTax;
    if (this.currentTotalTaxSet != null) {
      data['current_total_tax_set'] = this.currentTotalTaxSet!.toJson();
    }
    data['customer_locale'] = this.customerLocale;
    data['device_id'] = this.deviceId;
    // if (this.discountCodes != null) {
    //   data['discount_codes'] =
    //       this.discountCodes!.map((v) => v.toJson()).toList();
    // }
    data['email'] = this.email;
    data['estimated_taxes'] = this.estimatedTaxes;
    data['financial_status'] = this.financialStatus;
    data['fulfillment_status'] = this.fulfillmentStatus;
    data['gateway'] = this.gateway;
    data['landing_site'] = this.landingSite;
    data['landing_site_ref'] = this.landingSiteRef;
    data['location_id'] = this.locationId;
    data['merchant_of_record_app_id'] = this.merchantOfRecordAppId;
    data['name'] = this.name;
    data['note'] = this.note;
    // if (this.noteAttributes != null) {
    //   data['note_attributes'] =
    //       this.noteAttributes!.map((v) => v.toJson()).toList();
    // }
    data['number'] = this.number;
    data['order_number'] = this.orderNumber;
    data['order_status_url'] = this.orderStatusUrl;
    data['original_total_duties_set'] = this.originalTotalDutiesSet;
    data['payment_gateway_names'] = this.paymentGatewayNames;
    data['phone'] = this.phone;
    data['presentment_currency'] = this.presentmentCurrency;
    data['processed_at'] = this.processedAt;
    data['processing_method'] = this.processingMethod;
    data['reference'] = this.reference;
    data['referring_site'] = this.referringSite;
    data['source_identifier'] = this.sourceIdentifier;
    data['source_name'] = this.sourceName;
    data['source_url'] = this.sourceUrl;
    data['subtotal_price'] = this.subtotalPrice;
    if (this.subtotalPriceSet != null) {
      data['subtotal_price_set'] = this.subtotalPriceSet!.toJson();
    }
    data['tags'] = this.tags;
    // if (this.taxLines != null) {
    //   data['tax_lines'] = this.taxLines!.map((v) => v.toJson()).toList();
    // }
    data['taxes_included'] = this.taxesIncluded;
    data['test'] = this.test;
    data['token'] = this.token;
    data['total_discounts'] = this.totalDiscounts;
    if (this.totalDiscountsSet != null) {
      data['total_discounts_set'] = this.totalDiscountsSet!.toJson();
    }
    data['total_line_items_price'] = this.totalLineItemsPrice;
    if (this.totalLineItemsPriceSet != null) {
      data['total_line_items_price_set'] =
          this.totalLineItemsPriceSet!.toJson();
    }
    data['total_outstanding'] = this.totalOutstanding;
    data['total_price'] = this.totalPrice;
    if (this.totalPriceSet != null) {
      data['total_price_set'] = this.totalPriceSet!.toJson();
    }
    if (this.totalShippingPriceSet != null) {
      data['total_shipping_price_set'] = this.totalShippingPriceSet!.toJson();
    }
    data['total_tax'] = this.totalTax;
    if (this.totalTaxSet != null) {
      data['total_tax_set'] = this.totalTaxSet!.toJson();
    }
    data['total_tip_received'] = this.totalTipReceived;
    data['total_weight'] = this.totalWeight;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    // if (this.discountApplications != null) {
    //   data['discount_applications'] =
    //       this.discountApplications!.map((v) => v.toJson()).toList();
    // }
    // if (this.fulfillments != null) {
    //   data['fulfillments'] = this.fulfillments!.map((v) => v.toJson()).toList();
    // }
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
    }
    data['payment_terms'] = this.paymentTerms;
    // if (this.refunds != null) {
    //   data['refunds'] = this.refunds!.map((v) => v.toJson()).toList();
    // }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    if (this.shippingLines != null) {
      data['shipping_lines'] =
          this.shippingLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentSubtotalPriceSetSecond {
  ShopMoney? shopMoney;
  ShopMoney? presentmentMoney;

  CurrentSubtotalPriceSetSecond({this.shopMoney, this.presentmentMoney});

  CurrentSubtotalPriceSetSecond.fromJson(Map<String, dynamic> json) {
    shopMoney = json['shop_money'] != null
        ? new ShopMoney.fromJson(json['shop_money'])
        : null;
    presentmentMoney = json['presentment_money'] != null
        ? new ShopMoney.fromJson(json['presentment_money'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shopMoney != null) {
      data['shop_money'] = this.shopMoney!.toJson();
    }
    if (this.presentmentMoney != null) {
      data['presentment_money'] = this.presentmentMoney!.toJson();
    }
    return data;
  }
}

class LineItemsSecond {
  int? id;
  dynamic adminGraphqlApiId;
  int? fulfillableQuantity;
  dynamic fulfillmentService;
  dynamic fulfillmentStatus;
  dynamic giftCard;
  int? grams;
  dynamic name;
  dynamic price;
  CurrentSubtotalPriceSet? priceSet;
  dynamic productExists;
  int? productId;
  // List<Null>? properties;
  int? quantity;
  dynamic requiresShipping;
  dynamic sku;
  dynamic taxable;
  dynamic title;
  dynamic totalDiscount;
  CurrentSubtotalPriceSet? totalDiscountSet;
  int? variantId;
  dynamic variantInventoryManagement;
  dynamic variantTitle;
  dynamic vendor;
  // List<Null>? taxLines;
  // List<Null>? duties;
  // List<Null>? discountAllocations;

  LineItemsSecond(
      {this.id,
      this.adminGraphqlApiId,
      this.fulfillableQuantity,
      this.fulfillmentService,
      this.fulfillmentStatus,
      this.giftCard,
      this.grams,
      this.name,
      this.price,
      this.priceSet,
      this.productExists,
      this.productId,
      // this.properties,
      this.quantity,
      this.requiresShipping,
      this.sku,
      this.taxable,
      this.title,
      this.totalDiscount,
      this.totalDiscountSet,
      this.variantId,
      this.variantInventoryManagement,
      this.variantTitle,
      this.vendor,
      // this.taxLines,
      // this.duties,
      // this.discountAllocations
      });

  LineItemsSecond.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
    fulfillableQuantity = json['fulfillable_quantity'];
    fulfillmentService = json['fulfillment_service'];
    fulfillmentStatus = json['fulfillment_status'];
    giftCard = json['gift_card'];
    grams = json['grams'];
    name = json['name'];
    price = json['price'];
    priceSet = json['price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['price_set'])
        : null;
    productExists = json['product_exists'];
    productId = json['product_id'];
    // if (json['properties'] != null) {
    //   properties = <Null>[];
    //   json['properties'].forEach((v) {
    //     properties!.add(new Null.fromJson(v));
    //   });
    // }
    quantity = json['quantity'];
    requiresShipping = json['requires_shipping'];
    sku = json['sku'];
    taxable = json['taxable'];
    title = json['title'];
    totalDiscount = json['total_discount'];
    totalDiscountSet = json['total_discount_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['total_discount_set'])
        : null;
    variantId = json['variant_id'];
    variantInventoryManagement = json['variant_inventory_management'];
    variantTitle = json['variant_title'];
    vendor = json['vendor'];
    // if (json['tax_lines'] != null) {
    //   taxLines = <Null>[];
    //   json['tax_lines'].forEach((v) {
    //     taxLines!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['duties'] != null) {
    //   duties = <Null>[];
    //   json['duties'].forEach((v) {
    //     duties!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['discount_allocations'] != null) {
    //   discountAllocations = <Null>[];
    //   json['discount_allocations'].forEach((v) {
    //     discountAllocations!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admin_graphql_api_id'] = this.adminGraphqlApiId;
    data['fulfillable_quantity'] = this.fulfillableQuantity;
    data['fulfillment_service'] = this.fulfillmentService;
    data['fulfillment_status'] = this.fulfillmentStatus;
    data['gift_card'] = this.giftCard;
    data['grams'] = this.grams;
    data['name'] = this.name;
    data['price'] = this.price;
    if (this.priceSet != null) {
      data['price_set'] = this.priceSet!.toJson();
    }
    data['product_exists'] = this.productExists;
    data['product_id'] = this.productId;
    // if (this.properties != null) {
    //   data['properties'] = this.properties!.map((v) => v.toJson()).toList();
    // }
    data['quantity'] = this.quantity;
    data['requires_shipping'] = this.requiresShipping;
    data['sku'] = this.sku;
    data['taxable'] = this.taxable;
    data['title'] = this.title;
    data['total_discount'] = this.totalDiscount;
    if (this.totalDiscountSet != null) {
      data['total_discount_set'] = this.totalDiscountSet!.toJson();
    }
    data['variant_id'] = this.variantId;
    data['variant_inventory_management'] = this.variantInventoryManagement;
    data['variant_title'] = this.variantTitle;
    data['vendor'] = this.vendor;
    // if (this.taxLines != null) {
    //   data['tax_lines'] = this.taxLines!.map((v) => v.toJson()).toList();
    // }
    // if (this.duties != null) {
    //   data['duties'] = this.duties!.map((v) => v.toJson()).toList();
    // }
    // if (this.discountAllocations != null) {
    //   data['discount_allocations'] =
    //       this.discountAllocations!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class ShippingLinesSecond {
  int? id;
  dynamic carrierIdentifier;
  dynamic code;
  dynamic deliveryCategory;
  dynamic discountedPrice;
  CurrentSubtotalPriceSet? discountedPriceSet;
  dynamic phone;
  dynamic price;
  CurrentSubtotalPriceSet? priceSet;
  dynamic requestedFulfillmentServiceId;
  dynamic source;
  dynamic title;
  // List<Null>? taxLines;
  // List<Null>? discountAllocations;

  ShippingLinesSecond(
      {this.id,
      this.carrierIdentifier,
      this.code,
      this.deliveryCategory,
      this.discountedPrice,
      this.discountedPriceSet,
      this.phone,
      this.price,
      this.priceSet,
      this.requestedFulfillmentServiceId,
      this.source,
      this.title,
      // this.taxLines,
      // this.discountAllocations
      });

  ShippingLinesSecond.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carrierIdentifier = json['carrier_identifier'];
    code = json['code'];
    deliveryCategory = json['delivery_category'];
    discountedPrice = json['discounted_price'];
    discountedPriceSet = json['discounted_price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['discounted_price_set'])
        : null;
    phone = json['phone'];
    price = json['price'];
    priceSet = json['price_set'] != null
        ? new CurrentSubtotalPriceSet.fromJson(json['price_set'])
        : null;
    requestedFulfillmentServiceId = json['requested_fulfillment_service_id'];
    source = json['source'];
    title = json['title'];
    // if (json['tax_lines'] != null) {
    //   taxLines = <Null>[];
    //   json['tax_lines'].forEach((v) {
    //     taxLines!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['discount_allocations'] != null) {
    //   discountAllocations = <Null>[];
    //   json['discount_allocations'].forEach((v) {
    //     discountAllocations!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carrier_identifier'] = this.carrierIdentifier;
    data['code'] = this.code;
    data['delivery_category'] = this.deliveryCategory;
    data['discounted_price'] = this.discountedPrice;
    if (this.discountedPriceSet != null) {
      data['discounted_price_set'] = this.discountedPriceSet!.toJson();
    }
    data['phone'] = this.phone;
    data['price'] = this.price;
    if (this.priceSet != null) {
      data['price_set'] = this.priceSet!.toJson();
    }
    data['requested_fulfillment_service_id'] =
        this.requestedFulfillmentServiceId;
    data['source'] = this.source;
    data['title'] = this.title;
    // if (this.taxLines != null) {
    //   data['tax_lines'] = this.taxLines!.map((v) => v.toJson()).toList();
    // }
    // if (this.discountAllocations != null) {
    //   data['discount_allocations'] =
    //       this.discountAllocations!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
