//
//  Dashboard.h
//  Arastta
//
//  Created by Ayhan Dorman on 08/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Dashboard : NSObject

@property (nonatomic, copy) NSString *orders;
@property (nonatomic, copy) NSString *orders_price;
@property (nonatomic, copy) NSString *orders_niceprice;
@property NSMutableArray *orders_daily;
@property (nonatomic, copy) NSString *products;
@property (nonatomic, copy) NSString *customers;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
