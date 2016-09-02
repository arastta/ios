//
//  History.h
//  Arastta
//
//  Created by Ayhan Dorman on 27/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject

@property (nonatomic, copy) NSString *order_history_id;
@property (nonatomic, copy) NSString *order_status_id;
@property (nonatomic, copy) NSString *order_status_name;
@property (nonatomic, copy) NSString *date_added;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *notify;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end