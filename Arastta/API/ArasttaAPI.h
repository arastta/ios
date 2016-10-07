//
//  ArasttaAPI.h
//  Arastta
//
//  Created by Ayhan Dorman on 15/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Customer.h"
#import "Store.h"
#import "Product.h"
#import "Dashboard.h"

@interface ArasttaAPI : NSObject

+ (void) goToCloud;

+ (NSString*) storeLinkWithProtocol:(NSString*)storeLink;

+ (NSString*) storeLinkWithoutProtocol:(NSString*)storeLink;

+ (UIColor*) colourByOrderStatus:(NSString*)orderStatus;

+ (UIColor*) colourByProductStatus:(NSString*)productStatus;

+ (NSURLSessionDataTask*) settings:(void (^)(Store *store))storeDetails failure:(void (^)(NSError *error))failure storeLink:(NSString *)storeLink username:(NSString *)username password:(NSString *)password;

+ (NSURLSessionDataTask*) stats:(void (^)(Dashboard *dashboard))dashboard failure:(void (^)(NSError *error))failure parameters:(id)parameters;
	
+ (NSURLSessionDataTask*) customerList:(void (^)(NSMutableArray *customers))customerList failure:(void (^)(NSError *error))failure parameters:(id)parameters;

+ (NSURLSessionDataTask*) customerTotal:(void (^)(int customer_total))customerTotal failure:(void (^)(NSError *error))failure parameters:(id)parameters;

+ (NSURLSessionDataTask*) orderList:(void (^)(NSMutableArray *orders))orderList failure:(void (^)(NSError *error))failure parameters:(id)parameters;

+ (NSURLSessionDataTask*) orderListByCustomerId:(void (^)(NSMutableArray *orders))orderList failure:(void (^)(NSError *error))failure customer_id:(NSString*)customer_id parameters:(id)parameters;

+ (NSURLSessionDataTask*) orderTotal:(void (^)(NSString *nice_price))orderTotal failure:(void (^)(NSError *error))failure parameters:(id)parameters;

+ (NSURLSessionDataTask*) orderStatusList:(void (^)(NSMutableArray *statuses))statusList failure:(void (^)(NSError *error))failure;

+ (NSURLSessionDataTask*) orderHistoriesAdd:(void (^)())success failure:(void (^)(NSError *error))failure order_id:(NSString *)order_id parameters:(NSDictionary*)parameters;

+ (NSURLSessionDataTask*) productList:(void (^)(NSMutableArray *products))productList failure:(void (^)(NSError *error))failure parameters:(id)parameters;

+ (NSURLSessionDataTask*) productTotal:(void (^)(int product_total))productTotal failure:(void (^)(NSError *error))failure parameters:(id)parameters;

+ (NSURLSessionDataTask*) productListByOrderId:(void (^)(NSMutableArray *products))productList failure:(void (^)(NSError *error))failure order_id:(NSString *)order_id parameters:(id)parameters;

+ (NSURLSessionDataTask*) product:(void (^)(Product *product))product failure:(void (^)(NSError *error))failure product_id:(NSString *)product_id parameters:(id)parameters;

+ (NSURLSessionDataTask*) historyByOrderId:(void (^)(NSMutableArray *histories))historyList failure:(void (^)(NSError *error))failure order_id:(NSString *)order_id parameters:(id)parameters;


@end
