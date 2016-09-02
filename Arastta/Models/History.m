//
//  History.m
//  Arastta
//
//  Created by Ayhan Dorman on 27/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "History.h"

@implementation History

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	
	self = [super init];
	
	if (!self) {
		return nil;
	}
	
	self.order_history_id = [attributes valueForKey:@"order_history_id"];
	self.order_status_id = [attributes valueForKey:@"order_status_id"];
	self.order_status_name = [attributes valueForKey:@"order_status_name"];
	self.date_added = [attributes valueForKey:@"date_added"];
	self.status = [attributes valueForKey:@"status"];
	self.comment = [attributes valueForKey:@"comment"];
	self.notify = [attributes valueForKey:@"notify"];
	
	return self;
	
}

@end
