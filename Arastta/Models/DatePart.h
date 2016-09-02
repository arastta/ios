//
//  DatePart.h
//  Arastta
//
//  Created by Ayhan Dorman on 03/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatePart : NSObject

+(NSDateFormatter*)formatter;
+(NSString*)today;
+(NSString*)tomorrow;
+(NSString*)beginningOfMonth;
+(NSString*)endOfMonth;
+(NSString*)beginningOfYear;
+(NSString*)endOfYear;

@end
