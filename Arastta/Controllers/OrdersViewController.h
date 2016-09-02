//
//  OrdersViewController.h
//  Arastta
//
//  Created by Ayhan Dorman on 28/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewSearch;
@property (strong, nonatomic) IBOutlet UITextField *txtSearch;
@property (strong, nonatomic) IBOutlet UIView *viewTabSelection;
@property (strong, nonatomic) IBOutlet UIButton *btnToday;
@property (strong, nonatomic) IBOutlet UIButton *btnMonthly;
@property (strong, nonatomic) IBOutlet UIButton *btnYearly;
@property (strong, nonatomic) IBOutlet UITableView *tableOrders;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;

@property int currentTab;

- (void)loadOrders:(int)tabId;

- (IBAction)btnMenuClick:(id)sender;
- (IBAction)btnSearchClick:(id)sender;
- (IBAction)btnCloseSearchClick:(id)sender;
- (IBAction)btnRightMenuClick:(id)sender;
- (IBAction)btnTodayClick:(id)sender;
- (IBAction)btnMonthlyClick:(id)sender;
- (IBAction)btnYearlyClick:(id)sender;
- (IBAction)btnGetArasttaCloudClick:(id)sender;

@end
