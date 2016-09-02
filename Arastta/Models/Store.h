//
//  Store.h
//  Arastta
//
//  Created by Ayhan Dorman on 28/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject

@property (nonatomic, copy) NSString *store_url;
@property (nonatomic) BOOL use_tls;
@property (nonatomic, copy) NSString *config_name;
@property (nonatomic, copy) NSString *config_image;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+(BOOL)exists;

+(BOOL)set:(NSString*)store_url config_name:(NSString*)config_name config_image:(NSString*)config_image username:(NSString*)username password:(NSString*)password use_tls:(BOOL)use_tls;

+(Store*)get;

+(BOOL)update:(Store*)oldStore newStore:(NSDictionary*)newStore;

+(BOOL)addToList:(Store*)store;

+(NSArray*)list;

+(BOOL)switchTo:(Store*)store;

@end
