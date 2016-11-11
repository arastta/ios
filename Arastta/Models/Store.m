//
//  Store.m
//  Arastta
//
//  Created by Ayhan Dorman on 28/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "Store.h"
#import "ArasttaAPI.h"

@implementation Store


- (instancetype)initWithAttributes:(NSDictionary *)attributes {

	self = [super init];
	
	if (!self) {
		return nil;
	}
	
	self.store_url = [attributes valueForKey:@"store_url"];
	self.config_name = [attributes valueForKey:@"config_name"];
	self.config_image = [attributes valueForKey:@"config_image"];
	self.username = [attributes valueForKey:@"username"];
	self.password = [attributes valueForKey:@"password"];
	self.use_tls = [[attributes valueForKey:@"use_tls"] boolValue];
	
	return self;
	
}



+(BOOL)exists {
	
	return [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/store.data", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]]];
	
}


+(BOOL)set:(NSString*)store_url config_name:(NSString*)config_name config_image:(NSString*)config_image username:(NSString*)username password:(NSString*)password use_tls:(BOOL)use_tls {
	
	NSMutableDictionary *store = [[NSMutableDictionary alloc] initWithDictionary:
										 @{@"store_url": store_url,
										   @"config_name": config_name,
										   @"config_image": [NSString stringWithFormat:@"%@/%@", [ArasttaAPI storeLinkWithProtocol:store_url], config_image],
										   @"username": username,
										   @"password": password,
										   @"use_tls": [NSNumber numberWithBool:use_tls]}];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	return [store writeToFile:[NSString stringWithFormat:@"%@/store.data", [paths objectAtIndex:0]] atomically:YES];
	
}


+(Store*)get {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSMutableDictionary *storeDict = [NSMutableDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/store.data", [paths objectAtIndex:0]]];
	
	Store *store = [[Store alloc] initWithAttributes:storeDict];
	
	return store;
	
}


+(BOOL)update:(Store*)oldStore newStore:(NSDictionary*)newStore {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSMutableArray *storeArray = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/storeList.data", [paths objectAtIndex:0]]];
	
	NSDictionary *storeDict;
	
	Store *store;
	
	for (int i = 0; i < storeArray.count; i++)
	{
		
		storeDict = [storeArray objectAtIndex:i];
		
		store = [[Store alloc] initWithAttributes:storeDict];
		
		if ([store.store_url isEqualToString:oldStore.store_url])
			[storeArray replaceObjectAtIndex:i withObject:newStore];
		
	}
	
	return [storeArray writeToFile:[NSString stringWithFormat:@"%@/storeList.data", [paths objectAtIndex:0]] atomically:YES];
	
}


+(Store*)delete:(Store*)storeToDelete {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSMutableArray *storeArray = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/storeList.data", [paths objectAtIndex:0]]];
	
	NSDictionary *storeDict;
	
	Store *store;
	
	for (int i = 0; i < storeArray.count; i++)
	{
		
		storeDict = [storeArray objectAtIndex:i];
		
		store = [[Store alloc] initWithAttributes:storeDict];
		
		if ([store.store_url isEqualToString:storeToDelete.store_url])
			[storeArray removeObjectAtIndex:i];
		
	}
	
	if (storeArray.count > 0)
	{
		
		storeDict = [storeArray objectAtIndex:0];
		
		store = [[Store alloc] initWithAttributes:storeDict];
		
		[self switchTo:store];
		
	}
	
	if ([storeArray writeToFile:[NSString stringWithFormat:@"%@/storeList.data", [paths objectAtIndex:0]] atomically:YES])
	{
		return store;
	}
	else
	{
		return nil;
	}
	
}


+(BOOL)addToList:(Store*)store {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSMutableArray *storeArray;
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/store.data", [paths objectAtIndex:0]]])
	{
	
		storeArray = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/storeList.data", [paths objectAtIndex:0]]];
		
	}
	else
	{
		
		storeArray = [[NSMutableArray alloc] init];
		
	}
	
	NSMutableDictionary *storeDict = [[NSMutableDictionary alloc] initWithDictionary:
								  @{@"store_url": store.store_url,
									@"config_name": store.config_name,
									@"config_image": [NSString stringWithFormat:@"%@/%@", [ArasttaAPI storeLinkWithProtocol:store.store_url], store.config_image],
									@"username": store.username,
									@"password": store.password,
									@"use_tls": [NSNumber numberWithBool:store.use_tls]}];
	
	[storeArray addObject:storeDict];
	
	return [storeArray writeToFile:[NSString stringWithFormat:@"%@/storeList.data", [paths objectAtIndex:0]] atomically:YES];
	
}


+(NSArray*)list {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSMutableArray *storeArray;
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/store.data", [paths objectAtIndex:0]]])
	{
		
		storeArray = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/storeList.data", [paths objectAtIndex:0]]];
		
		
		NSDictionary *storeDict;
		
		Store *store;
		
		for (int i = 0; i < storeArray.count; i++)
		{
			
			storeDict = [storeArray objectAtIndex:i];
			
			store = [[Store alloc] initWithAttributes:storeDict];
			
			[storeArray replaceObjectAtIndex:i withObject:store];
			
		}
		
	}
	else
	{
		
		storeArray = [[NSMutableArray alloc] init];
		
	}
	
	return storeArray;
	
}


+(BOOL)switchTo:(Store*)store {
	
	NSMutableDictionary *storeDict = [[NSMutableDictionary alloc] initWithDictionary:
									  @{@"store_url": store.store_url,
										@"config_name": store.config_name,
										@"config_image": [NSString stringWithFormat:@"%@/%@", store.store_url, store.config_image],
										@"username": store.username,
										@"password": store.password,
										@"use_tls": [NSNumber numberWithBool:store.use_tls]}];
	
	NSLog(@"store_url: %@", store.store_url);
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	return [storeDict writeToFile:[NSString stringWithFormat:@"%@/store.data", [paths objectAtIndex:0]] atomically:YES];
	
}


@end
