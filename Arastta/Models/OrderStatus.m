//
//  OrderStatus.m
//  Arastta
//
//  Created by Ayhan Dorman on 04/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "OrderStatus.h"

@implementation OrderStatus

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	
	self = [super init];
	
	if (!self) {
		return nil;
	}
	
	self.order_status_id = [attributes valueForKey:@"order_status_id"];
	self.name = [attributes valueForKey:@"name"];
	
	return self;
	
}

@end
