//
//  ProductsViewController.h
//  Arastta
//
//  Created by Ayhan Dorman on 28/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIView *viewSearch;
@property (strong, nonatomic) IBOutlet UITextField *txtSearch;
@property (strong, nonatomic) IBOutlet UIView *viewTabSelection;
@property (strong, nonatomic) IBOutlet UIButton *btnAll;
@property (strong, nonatomic) IBOutlet UIButton *btnOrdered;
@property (strong, nonatomic) IBOutlet UITableView *tableProducts;
@property (strong, nonatomic) IBOutlet UITableView *tableProductsOrdered;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;
@property (strong, nonatomic) IBOutlet UILabel *lblCount;

- (IBAction)btnMenuClick:(id)sender;
- (IBAction)btnSearchClick:(id)sender;
- (IBAction)btnCloseSearchClick:(id)sender;
- (IBAction)btnAllClick:(id)sender;
- (IBAction)btnOrderedClick:(id)sender;
- (IBAction)btnGetArasttaCloudClick:(id)sender;

@end
