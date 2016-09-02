//
//  Order.m
//  Arastta
//
//  Created by Ayhan Dorman on 16/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "Order.h"

@implementation Order

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	
	self = [super init];
	
	if (!self) {
		return nil;
	}
	
	self.accept_language = [attributes valueForKey:@"accept_language"];
	self.affiliate_id = [attributes valueForKey:@"affiliate_id"];
	self.comment = [attributes valueForKey:@"comment"];
	self.commission = [attributes valueForKey:@"commission"];
	self.currency_code = [attributes valueForKey:@"currency_code"];
	self.currency_id = [attributes valueForKey:@"currency_id"];
	self.currency_value = [attributes valueForKey:@"currency_value"];
	self.custom_field = [attributes valueForKey:@"custom_field"];
	self.customer_id = [attributes valueForKey:@"customer_id"];
	self.date_added = [attributes valueForKey:@"date_added"];
	self.date_modified = [attributes valueForKey:@"date_modified"];
	self.email = [attributes valueForKey:@"email"];
	self.fax = [attributes valueForKey:@"fax"];
	self.firstname = [attributes valueForKey:@"firstname"];
	self.forwarded_ip = [attributes valueForKey:@"forwarded_ip"];
	self.invoice_no = [attributes valueForKey:@"invoice_no"];
	self.invoice_prefix = [attributes valueForKey:@"invoice_prefix"];
	self.ip = [attributes valueForKey:@"ip"];
	self.language_code = [attributes valueForKey:@"language_code"];
	self.language_directory = [attributes valueForKey:@"language_directory"];
	self.language_id = [attributes valueForKey:@"language_id"];
	self.lastname = [attributes valueForKey:@"lastname"];
	self.nice_total = [attributes valueForKey:@"nice_total"];
	self.order_id = [attributes valueForKey:@"order_id"];
	self.order_status = [attributes valueForKey:@"order_status"];
	self.order_status_id = [attributes valueForKey:@"order_status_id"];
	self.payment_address_1 = [attributes valueForKey:@"payment_address_1"];
	self.payment_address_2 = [attributes valueForKey:@"payment_address_2"];
	self.payment_address_format = [attributes valueForKey:@"payment_address_format"];
	self.payment_city = [attributes valueForKey:@"payment_city"];
	self.payment_code = [attributes valueForKey:@"payment_code"];
	self.payment_company = [attributes valueForKey:@"payment_company"];
	self.payment_country = [attributes valueForKey:@"payment_country"];
	self.payment_country_id = [attributes valueForKey:@"payment_country_id"];
	self.payment_custom_field = [attributes valueForKey:@"payment_custom_field"];
	self.payment_firstname = [attributes valueForKey:@"payment_firstname"];
	self.payment_iso_code_2 = [attributes valueForKey:@"payment_iso_code_2"];
	self.payment_iso_code_3 = [attributes valueForKey:@"payment_iso_code_3"];
	self.payment_lastname = [attributes valueForKey:@"payment_lastname"];
	self.payment_method = [attributes valueForKey:@"payment_method"];
	self.payment_postcode = [attributes valueForKey:@"payment_postcode"];
	self.payment_zone = [attributes valueForKey:@"payment_zone"];
	self.payment_zone_code = [attributes valueForKey:@"payment_zone_code"];
	self.payment_zone_id = [attributes valueForKey:@"payment_zone_id"];
	self.shipping_address_1 = [attributes valueForKey:@"shipping_address_1"];
	self.shipping_address_2 = [attributes valueForKey:@"shipping_address_2"];
	self.shipping_address_format = [attributes valueForKey:@"shipping_address_format"];
	self.shipping_city = [attributes valueForKey:@"shipping_city"];
	self.shipping_code = [attributes valueForKey:@"shipping_code"];
	self.shipping_company = [attributes valueForKey:@"shipping_company"];
	self.shipping_country = [attributes valueForKey:@"shipping_country"];
	self.shipping_country_id = [attributes valueForKey:@"shipping_country_id"];
	self.shipping_custom_field = [attributes valueForKey:@"shipping_custom_field"];
	self.shipping_firstname = [attributes valueForKey:@"shipping_firstname"];
	self.shipping_iso_code_2 = [attributes valueForKey:@"shipping_iso_code_2"];
	self.shipping_iso_code_3 = [attributes valueForKey:@"shipping_iso_code_3"];
	self.shipping_lastname = [attributes valueForKey:@"shipping_lastname"];
	self.shipping_method = [attributes valueForKey:@"shipping_method"];
	self.shipping_postcode = [attributes valueForKey:@"shipping_postcode"];
	self.shipping_zone = [attributes valueForKey:@"shipping_zone"];
	self.shipping_zone_code = [attributes valueForKey:@"shipping_zone_code"];
	self.shipping_zone_id = [attributes valueForKey:@"shipping_zone_id"];
	self.store_id = [attributes valueForKey:@"store_id"];
	self.store_name = [attributes valueForKey:@"store_name"];
	self.store_url = [attributes valueForKey:@"store_url"];
	self.telephone = [attributes valueForKey:@"telephone"];
	self.total = [attributes valueForKey:@"total"];
	self.user_agent = [attributes valueForKey:@"user_agent"];
	self.product_number = [NSString stringWithFormat:@"%@", [attributes valueForKey:@"product_number"]];
	
	return self;
	
}

@end
