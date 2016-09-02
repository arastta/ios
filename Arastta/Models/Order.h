//
//  Order.h
//  Arastta
//
//  Created by Ayhan Dorman on 16/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property (nonatomic, copy) NSString *accept_language;
@property (nonatomic, copy) NSString *affiliate_id;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *commission;
@property (nonatomic, copy) NSString *currency_code;
@property (nonatomic, copy) NSString *currency_id;
@property (nonatomic, copy) NSString *currency_value;
@property (nonatomic, copy) NSString *custom_field;
@property (nonatomic, copy) NSString *customer_id;
@property (nonatomic, copy) NSString *date_added;
@property (nonatomic, copy) NSString *date_modified;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *fax;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *forwarded_ip;
@property (nonatomic, copy) NSString *invoice_no;
@property (nonatomic, copy) NSString *invoice_prefix;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSString *language_code;
@property (nonatomic, copy) NSString *language_directory;
@property (nonatomic, copy) NSString *language_id;
@property (nonatomic, copy) NSString *lastname;
@property (nonatomic, copy) NSString *nice_total;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *order_status;
@property (nonatomic, copy) NSString *order_status_id;
@property (nonatomic, copy) NSString *payment_address_1;
@property (nonatomic, copy) NSString *payment_address_2;
@property (nonatomic, copy) NSString *payment_address_format;
@property (nonatomic, copy) NSString *payment_city;
@property (nonatomic, copy) NSString *payment_code;
@property (nonatomic, copy) NSString *payment_company;
@property (nonatomic, copy) NSString *payment_country;
@property (nonatomic, copy) NSString *payment_country_id;
@property (nonatomic, copy) NSString *payment_custom_field;
@property (nonatomic, copy) NSString *payment_firstname;
@property (nonatomic, copy) NSString *payment_iso_code_2;
@property (nonatomic, copy) NSString *payment_iso_code_3;
@property (nonatomic, copy) NSString *payment_lastname;
@property (nonatomic, copy) NSString *payment_method;
@property (nonatomic, copy) NSString *payment_postcode;
@property (nonatomic, copy) NSString *payment_zone;
@property (nonatomic, copy) NSString *payment_zone_code;
@property (nonatomic, copy) NSString *payment_zone_id;
@property (nonatomic, copy) NSString *shipping_address_1;
@property (nonatomic, copy) NSString *shipping_address_2;
@property (nonatomic, copy) NSString *shipping_address_format;
@property (nonatomic, copy) NSString *shipping_city;
@property (nonatomic, copy) NSString *shipping_code;
@property (nonatomic, copy) NSString *shipping_company;
@property (nonatomic, copy) NSString *shipping_country;
@property (nonatomic, copy) NSString *shipping_country_id;
@property (nonatomic, copy) NSString *shipping_custom_field;
@property (nonatomic, copy) NSString *shipping_firstname;
@property (nonatomic, copy) NSString *shipping_iso_code_2;
@property (nonatomic, copy) NSString *shipping_iso_code_3;
@property (nonatomic, copy) NSString *shipping_lastname;
@property (nonatomic, copy) NSString *shipping_method;
@property (nonatomic, copy) NSString *shipping_postcode;
@property (nonatomic, copy) NSString *shipping_zone;
@property (nonatomic, copy) NSString *shipping_zone_code;
@property (nonatomic, copy) NSString *shipping_zone_id;
@property (nonatomic, copy) NSString *store_id;
@property (nonatomic, copy) NSString *store_name;
@property (nonatomic, copy) NSString *store_url;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *user_agent;
@property (nonatomic, copy) NSString *product_number;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
