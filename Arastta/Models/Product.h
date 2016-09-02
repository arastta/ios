//
//  Product.h
//  Arastta
//
//  Created by Ayhan Dorman on 17/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, copy) NSString *date_added;
@property (nonatomic, copy) NSString *date_available;
@property (nonatomic, copy) NSString *date_modified;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *ean;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *isbn;
@property (nonatomic, copy) NSString *jan;
@property (nonatomic, copy) NSString *length;
@property (nonatomic, copy) NSString *length_class_id;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *manufacturer;
@property (nonatomic, copy) NSString *manufacturer_id;
@property (nonatomic, copy) NSString *meta_description;
@property (nonatomic, copy) NSString *meta_keyword;
@property (nonatomic, copy) NSString *meta_title;
@property (nonatomic, copy) NSString *minimum;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *mpn;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *points;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *reviews;
@property (nonatomic, copy) NSString *reward;
@property (nonatomic, copy) NSString *sku;
@property (nonatomic, copy) NSString *sort_order;
@property (nonatomic, copy) NSString *special;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *stock_color;
@property (nonatomic, copy) NSString *stock_status;
@property (nonatomic, copy) NSString *subtract;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *tax_class_id;
@property (nonatomic, copy) NSString *upc;
@property (nonatomic, copy) NSString *viewed;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *weight_class_id;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *manufacturer_name;
@property (nonatomic, copy) NSString *nice_price;
@property NSMutableArray *images;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
