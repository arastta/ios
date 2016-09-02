//
//  OrderStatus.h
//  Arastta
//
//  Created by Ayhan Dorman on 04/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderStatus : NSObject

@property (nonatomic, copy) NSString *order_status_id;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
