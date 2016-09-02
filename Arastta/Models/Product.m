//
//  Product.m
//  Arastta
//
//  Created by Ayhan Dorman on 17/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize description;

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	
	self = [super init];
	
	if (!self) {
		return nil;
	}
	
	self.date_added = [attributes valueForKey:@"date_added"];
	self.date_available = [attributes valueForKey:@"date_available"];
	self.date_modified = [attributes valueForKey:@"date_modified"];
	self.description = [attributes valueForKey:@"description"];
	self.ean = [attributes valueForKey:@"ean"];
	self.height = [attributes valueForKey:@"height"];
	self.image = [attributes valueForKey:@"image"];
	self.isbn = [attributes valueForKey:@"isbn"];
	self.jan = [attributes valueForKey:@"jan"];
	self.length = [attributes valueForKey:@"length"];
	self.length_class_id = [attributes valueForKey:@"length_class_id"];
	self.location = [attributes valueForKey:@"location"];
	self.manufacturer = [attributes valueForKey:@"manufacturer"];
	self.manufacturer_id = [attributes valueForKey:@"manufacturer_id"];
	self.meta_description = [attributes valueForKey:@"meta_description"];
	self.meta_keyword = [attributes valueForKey:@"meta_keyword"];
	self.meta_title = [attributes valueForKey:@"meta_title"];
	self.minimum = [attributes valueForKey:@"minimum"];
	self.model = [attributes valueForKey:@"model"];
	self.mpn = [attributes valueForKey:@"mpn"];
	self.name = [attributes valueForKey:@"name"];
	self.points = [attributes valueForKey:@"points"];
	self.price = [attributes valueForKey:@"price"];
	self.product_id = [attributes valueForKey:@"product_id"];
	self.quantity = [NSString stringWithFormat:@"%@", [attributes valueForKey:@"quantity"]];
	self.rating = [attributes valueForKey:@"rating"];
	self.reviews = [attributes valueForKey:@"reviews"];
	self.reward = [attributes valueForKey:@"reward"];
	self.sku = [attributes valueForKey:@"sku"];
	self.sort_order = [attributes valueForKey:@"sort_order"];
	self.special = [attributes valueForKey:@"special"];
	self.status = [attributes valueForKey:@"status"];
	self.stock_color = [attributes valueForKey:@"stock_color"];
	self.stock_status = [attributes valueForKey:@"stock_status"];
	self.subtract = [attributes valueForKey:@"subtract"];
	self.tag = [attributes valueForKey:@"tag"];
	self.tax_class_id = [attributes valueForKey:@"tax_class_id"];
	self.upc = [attributes valueForKey:@"upc"];
	self.viewed = [attributes valueForKey:@"viewed"];
	self.weight = [attributes valueForKey:@"weight"];
	self.weight_class_id = [attributes valueForKey:@"weight_class_id"];
	self.width = [attributes valueForKey:@"width"];
	self.manufacturer_name = [attributes valueForKey:@"manufacturer_name"];
	self.nice_price = [attributes valueForKey:@"nice_price"];
	
	self.images = [[NSMutableArray alloc] init];
	for (NSString *image in [attributes valueForKey:@"images"]) {
		[self.images addObject:image];
	}
	
	return self;
	
}

@end
