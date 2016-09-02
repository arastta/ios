//
//  CustomerDetailsViewController.h
//  Arastta
//
//  Created by Ayhan Dorman on 29/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"

@interface CustomerDetailsViewController : UIViewController

@property Customer *customer;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblTelephone;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (strong, nonatomic) IBOutlet UIView *viewTabSelection;
@property (strong, nonatomic) IBOutlet UIButton *btnProducts;
@property (strong, nonatomic) IBOutlet UIButton *btnInfo;
@property (strong, nonatomic) IBOutlet UITableView *tableOrders;
@property (strong, nonatomic) IBOutlet UIScrollView *viewInfo;
@property (strong, nonatomic) IBOutlet UILabel *customer_id;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *ip;
@property (strong, nonatomic) IBOutlet UILabel *description;
@property (strong, nonatomic) IBOutlet UILabel *order_number;
@property (strong, nonatomic) IBOutlet UILabel *date_added;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;

- (IBAction)btnBackClick:(id)sender;
- (IBAction)btnProductsClick:(id)sender;
- (IBAction)btnInfoClick:(id)sender;
- (IBAction)btnGetArasttaCloudClick:(id)sender;

@end
