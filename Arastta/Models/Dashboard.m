//
//  Dashboard.m
//  Arastta
//
//  Created by Ayhan Dorman on 08/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "Dashboard.h"

@implementation Dashboard

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	
	self = [super init];
	
	if (!self) {
		return nil;
	}
	
	self.orders = [[attributes valueForKey:@"orders"] valueForKey:@"number"];
	
	NSString *price = (NSString*)[[attributes valueForKey:@"orders"] valueForKey:@"price"];
	
	self.orders_price = ([price isEqual:[NSNull null]] ? @"0": price);
	
	self.orders_niceprice = [[attributes valueForKey:@"orders"] valueForKey:@"nice_price"];
	
	self.orders_daily = [[NSMutableArray alloc] init];

	NSArray *daily = [[attributes valueForKey:@"orders"] valueForKey:@"daily"];
	
	[self.orders_daily addObject:[NSNumber numberWithFloat:0.0f]];
	
	for (NSDictionary *day in daily) {
		
		@try {
			[self.orders_daily addObject:[NSNumber numberWithFloat:[[day objectForKey:@"price"] floatValue]]];
		} @catch (NSException *exception) {
			[self.orders_daily addObject:[NSNumber numberWithFloat:0.0f]];
		} @finally {
			
		}
		
	}
	
	self.products = [[attributes valueForKey:@"products"] valueForKey:@"number"];
	
	self.customers = [[attributes valueForKey:@"customers"] valueForKey:@"number"];
	
	return self;
	
}

@end
