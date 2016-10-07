//
//  ArasttaAPI.m
//  Arastta
//
//  Created by Ayhan Dorman on 15/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "ArasttaAPI.h"
#import "UIColor+Expanded.h"
#import "Customer.h"
#import "Order.h"
#import "Product.h"
#import "History.h"
#import "OrderStatus.h"

@implementation ArasttaAPI

static Store *currentStore;

static NSString *storeLink;

static NSString *username;

static NSString *password;

static BOOL use_tls;


NSURLSessionDataTask *dataTask;


+ (void) getCurrentStore {
	
	currentStore = [Store get];
	
	storeLink = currentStore.store_url;
	
	username = currentStore.username;
	
	password = currentStore.password;
	
	use_tls = currentStore.use_tls;
	
}


+ (NSURL*) baseURLwithPathAndParams:(NSString*)storeLink path:(NSString*)path parameters:(NSDictionary*)parameters {
	
	storeLink = [self storeLinkWithProtocol:storeLink];
	
	if (parameters == nil)
	{
		
		NSLog(@"url - %@", [NSURL URLWithString:[NSString stringWithFormat:@"%@/api%@", storeLink, path]]);
		
		return [NSURL URLWithString:[NSString stringWithFormat:@"%@/api%@", storeLink, path]];
		
	}
	else
	{
	
		NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"%@/api%@", storeLink, path]];
		
		NSMutableArray *queryItems = [[NSMutableArray alloc] init];
		
		for (NSString *param in parameters) {
			
			[queryItems addObject:[NSURLQueryItem queryItemWithName:param value:[parameters objectForKey:param]]];
			
		}
		
		components.queryItems = queryItems;
		
		NSLog(@"url - %@", components.URL);
		
		return components.URL;
		
	}
	
}


+ (void) goToCloud {
	
	NSString *path = [[NSBundle mainBundle] pathForResource: @"Info" ofType: @"plist"];
	
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
	
	NSString *myurl = [dict objectForKey: @"ArasttaCloudUrl"];
	
	NSURL *url = [NSURL URLWithString:myurl];
	
	[[UIApplication sharedApplication] openURL:url];
	
}


+ (NSString*) storeLinkWithProtocol:(NSString*)storeLink {
	
	return	(
			use_tls ?
			 [NSString stringWithFormat:@"https://%@", storeLink]
			:
			 [NSString stringWithFormat:@"http://%@", storeLink]
			);
	
}


+ (NSString*) storeLinkWithoutProtocol:(NSString*)storeLink {
	
	storeLink = [storeLink stringByReplacingOccurrencesOfString:@"https://" withString:@""];
	
	storeLink = [storeLink stringByReplacingOccurrencesOfString:@"http://" withString:@""];
	
	return storeLink;
	
}


+ (NSString *)percentEscapeString:(NSString *)string
{
	
	NSString *result = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
																				 (CFStringRef)string,
																				 (CFStringRef)@" ",
																				 (CFStringRef)@":/?@!$&'()*+,;=",
																				 kCFStringEncodingUTF8));
	
	return [result stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	
}


+ (NSData *)httpBodyForParamsDictionary:(NSDictionary *)paramDictionary
{
	
	NSMutableArray *parameterArray = [NSMutableArray array];
	
	[paramDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
		
		NSString *param = [NSString stringWithFormat:@"%@=%@", key, [self percentEscapeString:obj]];
		
		[parameterArray addObject:param];
		
	}];
	
	NSString *string = [parameterArray componentsJoinedByString:@"&"];
	
	return [string dataUsingEncoding:NSUTF8StringEncoding];
	
}


+ (UIColor*) colourByOrderStatus:(NSString*)orderStatus {
	
	// Default colour implementations for order statuses.
	
	NSDictionary *colourDict = @{
								 /* Missing Orders */	@"0": [UIColor colorWithHexString:@"000000"],
								 /* Pending */			@"1": [UIColor colorWithHexString:@"2279ea"],
								 /* Processing */		@"2": [UIColor colorWithHexString:@"03b3da"],
								 /* Shipped */			@"3": [UIColor colorWithHexString:@"8626df"],
								 /* Complete */			@"5": [UIColor colorWithHexString:@"0b860a"],
								 /* Canceled */			@"7": [UIColor colorWithHexString:@"dc0f3a"],
								 /* Denied */			@"8": [UIColor colorWithHexString:@"be1210"],
								 /* Canceled Reversal */@"9": [UIColor colorWithHexString:@"d94b27"],
								 /* Failed */			@"10": [UIColor colorWithHexString:@"a84476"],
								 /* Refunded */			@"11": [UIColor colorWithHexString:@"ef2d12"],
								 /* Reversed */			@"12": [UIColor colorWithHexString:@"d71135"],
								 /* Chargeback */		@"13": [UIColor colorWithHexString:@"86041c"],
								 /* Expired */			@"14": [UIColor colorWithHexString:@"6b6b6b"],
								 /* Processed */		@"15": [UIColor colorWithHexString:@"26b326"],
								 /* Voided */			@"16": [UIColor colorWithHexString:@"71716f"],
								 };
	
	UIColor *colourStatus = [colourDict objectForKey:orderStatus];
	
	if (colourStatus == nil) colourStatus = [colourDict objectForKey:@"0"];
	
	return colourStatus;
	
	
}


+ (UIColor*) colourByProductStatus:(NSString*)productStatus {
	
	NSDictionary *colourDict = @{
								 @"0": [UIColor colorWithHexString:@"c0143c"],
								 @"1": [UIColor colorWithHexString:@"00c375"],
								 };
	
	return [colourDict objectForKey:productStatus];
	
	
}


+ (NSURLSessionDataTask*) settings:(void (^)(Store *store))storeDetails failure:(void (^)(NSError *error))failure storeLink:(NSString *)storeLink username:(NSString *)username password:(NSString *)password {
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:@"/settings" parameters:nil]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("user settings", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSDictionary *settingsDict = [NSJSONSerialization
											  JSONObjectWithData:data
											  options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
											  error:&error];
				
				if (error)
				{
					
					dispatch_async(dispatch_get_main_queue(), ^{
						
						failure(error);
						
					});
					
				}
				else
				{
					
					
					dispatch_async(dispatch_get_main_queue(), ^{
						
						if ([settingsDict objectForKey:@"error"] == nil)
						{
							
							NSString *storeLinkWithoutProtocol = [storeLink stringByReplacingOccurrencesOfString:@"https://" withString:@""];
							
							storeLinkWithoutProtocol = [storeLinkWithoutProtocol stringByReplacingOccurrencesOfString:@"http://" withString:@""];
							
							[settingsDict setValue:storeLinkWithoutProtocol forKey:@"store_url"];
							
							[settingsDict setValue:username forKey:@"username"];
							
							[settingsDict setValue:password forKey:@"password"];
						
							Store *store = [[Store alloc] initWithAttributes:settingsDict];
						
							storeDetails(store);
							
						}
						else
						{
							
							NSError *error = [[NSError alloc] initWithDomain:@"com.whispto" code:200 userInfo:@{NSLocalizedDescriptionKey: [settingsDict objectForKey:@"error"]}];
							
							failure(error);
							
						}
						
					});
					
				}
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) stats:(void (^)(Dashboard *dashboard))dashboard failure:(void (^)(NSError *error))failure parameters:(id)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:@"/stats" parameters:parameters]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get dashboard data", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSDictionary *dashboardIn = [NSJSONSerialization
											   JSONObjectWithData:data
											   options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
											   error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						
						failure(error);
						
					}
					else
					{
						
						Dashboard *d = [[Dashboard alloc] initWithAttributes:dashboardIn];
						
						dashboard(d);
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) customerList:(void (^)(NSMutableArray *customers))customerList failure:(void (^)(NSError *error))failure parameters:(id)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:@"/customers" parameters:parameters]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get customer list", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSMutableArray *customersIn = [NSJSONSerialization
											   JSONObjectWithData:data
											   options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
											   error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						
						failure(error);
						
					}
					else
					{
						
						@try {
							
							NSMutableArray *customersOut = [[NSMutableArray alloc] init];
							
							for (NSDictionary *_customer in customersIn) {
								
								Customer *customer = [[Customer alloc] initWithAttributes:_customer];
								
								[customersOut addObject:customer];
								
							}
							
							customerList(customersOut);
							
						}
						@catch (NSException *exception) {
							
							failure(nil);
							
						}
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
				
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) customerTotal:(void (^)(int customer_total))customerTotal failure:(void (^)(NSError *error))failure parameters:(id)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:@"/customers/totals" parameters:parameters]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get customer total", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSDictionary *customerTotalIn = [NSJSONSerialization
												 JSONObjectWithData:data
												 options:0
												 error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						failure(error);
					}
					else
					{
						
						customerTotal([[customerTotalIn objectForKey:@"number"] intValue]);
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
				
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) orderList:(void (^)(NSMutableArray *orders))orderList failure:(void (^)(NSError *error))failure parameters:(id)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:@"/orders" parameters:parameters]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get order list", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSMutableArray *ordersIn = [NSJSONSerialization
											   JSONObjectWithData:data
											   options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
											   error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
				
					if (error)
					{
						failure(error);
					}
					else
					{
						
						@try {
							
							NSMutableArray *ordersOut = [[NSMutableArray alloc] init];
							
							for (NSDictionary *_order in ordersIn) {
								
								Order *order = [[Order alloc] initWithAttributes:_order];
								
								[ordersOut addObject:order];
								
							}
							
							orderList(ordersOut);
							
						}
						@catch (NSException *exception) {
							
							failure(nil);
							
						}
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
				
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) orderListByCustomerId:(void (^)(NSMutableArray *orders))orderList failure:(void (^)(NSError *error))failure customer_id:(NSString*)customer_id parameters:(id)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:[NSString stringWithFormat:@"/customers/%@/orders", customer_id] parameters:parameters]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get order list", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSMutableArray *ordersIn = [NSJSONSerialization
											JSONObjectWithData:data
											options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
											error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						failure(error);
					}
					else
					{
						
						@try {
							
							NSMutableArray *ordersOut = [[NSMutableArray alloc] init];
							
							for (NSDictionary *_order in ordersIn) {
								
								Order *order = [[Order alloc] initWithAttributes:_order];
								
								[ordersOut addObject:order];
								
							}
							
							orderList(ordersOut);
							
						}
						@catch (NSException *exception) {
							
							failure(nil);
							
						}
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) orderTotal:(void (^)(NSString *nice_price))orderTotal failure:(void (^)(NSError *error))failure parameters:(id)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:@"/orders/totals" parameters:parameters]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get order total", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSDictionary *orderTotalIn = [NSJSONSerialization
												 JSONObjectWithData:data
												 options:0
												 error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						failure(error);
					}
					else
					{
						
						orderTotal([orderTotalIn objectForKey:@"nice_price"]);
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) orderStatusList:(void (^)(NSMutableArray *statuses))statusList failure:(void (^)(NSError *error))failure {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:@"/orders/statuses" parameters:nil]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get order status list", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSMutableArray *orderStatusesIn = [NSJSONSerialization
												   JSONObjectWithData:data
												   options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
												   error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						failure(error);
					}
					else
					{
						
						@try {
							
							NSMutableArray *orderStatusesOut = [[NSMutableArray alloc] init];
							
							for (NSDictionary *_status in orderStatusesIn) {
								
								OrderStatus *status = [[OrderStatus alloc] initWithAttributes:_status];
								
								[orderStatusesOut addObject:status];
								
							}
							
							statusList(orderStatusesOut);
							
						}
						@catch (NSException *exception) {
							
							failure(nil);
							
						}
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) orderHistoriesAdd:(void (^)())success failure:(void (^)(NSError *error))failure order_id:(NSString *)order_id parameters:(NSDictionary*)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:[NSString stringWithFormat:@"/orders/%@/histories", order_id] parameters:nil]];
	
	[request setHTTPMethod:@"POST"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
	
	[request setHTTPBody:[self httpBodyForParamsDictionary:parameters]];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("post new order status", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						failure(error);
					}
					else
					{
						
						success();
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) productList:(void (^)(NSMutableArray *products))productList failure:(void (^)(NSError *error))failure parameters:(id)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:@"/products" parameters:parameters]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get product list", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSMutableArray *productsIn = [NSJSONSerialization
											JSONObjectWithData:data
											options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
											error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						failure(error);
					}
					else
					{
						
						@try {
							
							NSMutableArray *productsOut = [[NSMutableArray alloc] init];
							
							for (NSDictionary *_product in productsIn) {
								
								Product *product = [[Product alloc] initWithAttributes:_product];
								
								[productsOut addObject:product];
								
							}
							
							productList(productsOut);
							
						}
						@catch (NSException *exception) {
							
							failure(nil);
							
						}
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
				
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) productTotal:(void (^)(int product_total))productTotal failure:(void (^)(NSError *error))failure parameters:(id)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:@"/products/totals" parameters:parameters]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get product total", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSDictionary *productTotalIn = [NSJSONSerialization
												 JSONObjectWithData:data
												 options:0
												 error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						failure(error);
					}
					else
					{
						
						productTotal([[productTotalIn objectForKey:@"number"] intValue]);
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
				
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) productListByOrderId:(void (^)(NSMutableArray *))productList failure:(void (^)(NSError *))failure order_id:(NSString *)order_id parameters:(id)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:[NSString stringWithFormat:@"/orders/%@/products", order_id] parameters:parameters]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get order product list", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSMutableArray *productsIn = [NSJSONSerialization
											  JSONObjectWithData:data
											  options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
											  error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						failure(error);
					}
					else
					{
						
						@try {
							
							NSMutableArray *productsOut = [[NSMutableArray alloc] init];
							
							for (NSDictionary *_product in productsIn) {
								
								Product *product = [[Product alloc] initWithAttributes:_product];
								
								[productsOut addObject:product];
								
							}
							
							productList(productsOut);
							
						}
						@catch (NSException *exception) {
							
							failure(nil);
							
						}
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) product:(void (^)(Product *product))product failure:(void (^)(NSError *error))failure product_id:(NSString *)product_id parameters:(id)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:[NSString stringWithFormat:@"/products/%@", product_id] parameters:parameters]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get product", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSMutableDictionary *productIn = [NSJSONSerialization
											  JSONObjectWithData:data
											  options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
											  error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						failure(error);
					}
					else
					{
						
						@try {
							
							Product *p = [[Product alloc] initWithAttributes:productIn];
							
							product(p);
							
						}
						@catch (NSException *exception) {
							
							failure(nil);
							
						}
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


+ (NSURLSessionDataTask*) historyByOrderId:(void (^)(NSMutableArray *histories))historyList failure:(void (^)(NSError *error))failure order_id:(NSString *)order_id parameters:(id)parameters {
	
	[self getCurrentStore];
	
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
	
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self baseURLwithPathAndParams:storeLink path:[NSString stringWithFormat:@"/orders/%@/histories", order_id] parameters:parameters]];
	
	[request setHTTPMethod:@"GET"];
	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
 
	NSURLSession *session = [NSURLSession sharedSession];
	
	dispatch_async(dispatch_queue_create("get order history list", NULL), ^{
		
		dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (data.length > 0 && error == nil)
			{
				
				NSMutableArray *historiesIn = [NSJSONSerialization
											  JSONObjectWithData:data
											  options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
											  error:&error];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					if (error)
					{
						failure(error);
					}
					else
					{
						
						@try {
							
							NSMutableArray *historiesOut = [[NSMutableArray alloc] init];
							
							for (NSDictionary *_history in historiesIn) {
								
								History *history = [[History alloc] initWithAttributes:_history];
								
								[historiesOut addObject:history];
								
							}
							
							historyList(historiesOut);
							
						}
						@catch (NSException *exception) {
							
							failure(nil);
							
						}
						
					}
					
				});
				
			}
			else
			{
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					failure(error);
					
				});
				
			}
			
		}];
		
		[dataTask resume];
		
	});
	
	return nil;
	
}


@end
