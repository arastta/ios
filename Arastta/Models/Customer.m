//
//  Customer.m
//  Arastta
//
//  Created by Ayhan Dorman on 15/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "Customer.h"

@implementation Customer

@synthesize description;

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	
	self = [super init];
	
	if (!self) {
		return nil;
	}
	
	self.address_id = [attributes valueForKey:@"address_id"];
	self.approved = [attributes valueForKey:@"approved"];
	self.cart = [attributes valueForKey:@"cart"];
	self.custom_field = [attributes valueForKey:@"custom_field"];
	self.customer_group = [attributes valueForKey:@"customer_group"];
	self.customer_group_id = [attributes valueForKey:@"customer_group_id"];
	self.customer_id = [attributes valueForKey:@"customer_id"];
	self.date_added = [attributes valueForKey:@"date_added"];
	self.description = [attributes valueForKey:@"description"];
	self.email = [attributes valueForKey:@"email"];
	self.fax = [attributes valueForKey:@"fax"];
	self.firstname = [attributes valueForKey:@"firstname"];
	self.ip = [attributes valueForKey:@"ip"];
	self.language_id = [attributes valueForKey:@"language_id"];
	self.lastname = [attributes valueForKey:@"lastname"];
	self.name = [attributes valueForKey:@"name"];
	self.newsletter = [attributes valueForKey:@"newsletter"];
	self.password = [attributes valueForKey:@"password"];
	self.safe = [attributes valueForKey:@"safe"];
	self.salt = [attributes valueForKey:@"salt"];
	self.status = [attributes valueForKey:@"status"];
	self.store_id = [attributes valueForKey:@"store_id"];
	self.telephone = [attributes valueForKey:@"telephone"];
	self.token = [attributes valueForKey:@"token"];
	self.wishlist = [attributes valueForKey:@"wishlist"];
	self.order_number = [[attributes valueForKey:@"order_number"] stringValue];
	self.order_total = [NSString stringWithFormat:@"%@", [attributes valueForKey:@"order_total"]];
	self.order_nice_total = [attributes valueForKey:@"order_nice_total"];
	
	return self;
	
}

@end