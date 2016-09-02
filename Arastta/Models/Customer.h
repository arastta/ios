//
//  Customer.h
//  Arastta
//
//  Created by Ayhan Dorman on 15/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject

@property (nonatomic, copy) NSString *address_id;
@property (nonatomic, copy) NSString *approved;
@property (nonatomic, copy) NSString *cart;
@property (nonatomic, copy) NSString *custom_field;
@property (nonatomic, copy) NSString *customer_group;
@property (nonatomic, copy) NSString *customer_group_id;
@property (nonatomic, copy) NSString *customer_id;
@property (nonatomic, copy) NSString *date_added;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *fax;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSString *language_id;
@property (nonatomic, copy) NSString *lastname;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *newsletter;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *safe;
@property (nonatomic, copy) NSString *salt;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *store_id;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *wishlist;

@property (nonatomic, copy) NSString *order_number;
@property (nonatomic, copy) NSString *order_total;
@property (nonatomic, copy) NSString *order_nice_total;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
