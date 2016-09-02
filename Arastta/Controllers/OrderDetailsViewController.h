//
//  OrderDetailsViewController.h
//  Arastta
//
//  Created by Ayhan Dorman on 11/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate>

@property Order *order;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderDate;
@property (strong, nonatomic) IBOutlet UIImageView *imgOrderStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderStatus;
@property (strong, nonatomic) IBOutlet UIView *viewTabSelection;
@property (strong, nonatomic) IBOutlet UIButton *btnProducts;
@property (strong, nonatomic) IBOutlet UIButton *btnInfo;
@property (strong, nonatomic) IBOutlet UIButton *btnHistory;
@property (strong, nonatomic) IBOutlet UITableView *tableProducts;
@property (strong, nonatomic) IBOutlet UIScrollView *viewInfo;
@property (strong, nonatomic) IBOutlet UILabel *order_id;
@property (strong, nonatomic) IBOutlet UILabel *invoice_prefix;
@property (strong, nonatomic) IBOutlet UILabel *payment_company;
@property (strong, nonatomic) IBOutlet UILabel *payment_address_1;
@property (strong, nonatomic) IBOutlet UILabel *payment_city;
@property (strong, nonatomic) IBOutlet UILabel *payment_country;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *telephone;
@property (strong, nonatomic) IBOutlet UILabel *fax;
@property (strong, nonatomic) IBOutlet UILabel *payment_method;
@property (strong, nonatomic) IBOutlet UITableView *tableHistories;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;
@property (strong, nonatomic) IBOutlet UIView *viewChangeStatus;
@property (strong, nonatomic) IBOutlet UIView *viewChangeStatusInner;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerStatus;
@property (strong, nonatomic) IBOutlet UIImageView *imgNotifyCustomer;
@property (strong, nonatomic) IBOutlet UITextView *txtComment;

- (IBAction)btnBackClick:(id)sender;
- (IBAction)btnRightMenuClick:(id)sender;
- (IBAction)btnProductsClick:(id)sender;
- (IBAction)btnInfoClick:(id)sender;
- (IBAction)btnHistoryClick:(id)sender;
- (IBAction)btnGetArasttaCloudClick:(id)sender;
- (IBAction)btnNotifyCustomerClick:(id)sender;
- (IBAction)btnSaveStatusClick:(id)sender;
- (IBAction)btnCancelStatusClick:(id)sender;


@end
