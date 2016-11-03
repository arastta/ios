//
//  ProductDetailsViewController.h
//  Arastta
//
//  Created by Ayhan Dorman on 28/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductDetailsViewController : UIViewController <UIScrollViewDelegate>

@property Product *product;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollImages;
@property (strong, nonatomic) IBOutlet UIPageControl *pageImages;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;
@property (strong, nonatomic) IBOutlet UIScrollView *viewInfo;
@property (strong, nonatomic) IBOutlet UILabel *no;
@property (strong, nonatomic) IBOutlet UILabel *model;
@property (strong, nonatomic) IBOutlet UILabel *sku;
@property (strong, nonatomic) IBOutlet UILabel *nice_price;
@property (strong, nonatomic) IBOutlet UILabel *quantity;
@property (strong, nonatomic) IBOutlet UILabel *manufacturer_name;
@property (strong, nonatomic) IBOutlet UILabel *status0;
@property (strong, nonatomic) IBOutlet UILabel *status1;
@property (strong, nonatomic) IBOutlet UIWebView *product_description;

- (IBAction)btnBackClick:(id)sender;
- (IBAction)pageImagesChanged:(id)sender;
- (IBAction)btnGetArasttaCloudClick:(id)sender;

@end
