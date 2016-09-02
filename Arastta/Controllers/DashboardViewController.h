//
//  ViewController.h
//  Arastta
//
//  Created by Ayhan Dorman on 03/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *viewTabSelection;
@property (strong, nonatomic) IBOutlet UIButton *btnToday;
@property (strong, nonatomic) IBOutlet UIButton *btnMonthly;
@property (strong, nonatomic) IBOutlet UIButton *btnYearly;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UILabel *lblSalesTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblCustomersTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblProductsTotal;

@property (strong, nonatomic) IBOutlet UIView *viewChart;

@property (strong, nonatomic) IBOutlet UILabel *lblAvgOrderValDay;
@property (strong, nonatomic) IBOutlet UILabel *lblAvgOrderDay;
@property (strong, nonatomic) IBOutlet UILabel *lblAvgCustomerDay;
@property (strong, nonatomic) IBOutlet UILabel *lblAvgOrderValCustomer;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;

- (IBAction)btnMenuClick:(id)sender;
- (IBAction)btnTodayClick:(id)sender;
- (IBAction)btnMonthlyClick:(id)sender;
- (IBAction)btnYearlyClick:(id)sender;
- (IBAction)btnOrdersClick:(id)sender;
- (IBAction)btnCustomersClick:(id)sender;
- (IBAction)btnProductsClick:(id)sender;
- (IBAction)btnGetArasttaCloudClick:(id)sender;

@end

