//
//  ManageStoreViewController.h
//  Arastta
//
//  Created by Ayhan Dorman on 02/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Store.h"

@interface ManageStoreViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@property (strong, nonatomic) IBOutlet UIImageView *imgDelete;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *txtStoreTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgRetrieveTitleAutomatically;
@property (strong, nonatomic) IBOutlet UITextField *txtStoreUrl;
@property (strong, nonatomic) IBOutlet UIImageView *imgUseSecureConnection;
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIImageView *imgOrderCreated;
@property (strong, nonatomic) IBOutlet UIImageView *imgOrderStatusChanged;
@property (strong, nonatomic) IBOutlet UIImageView *imgNewCustomerRegistered;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;

@property BOOL firstLaunch;

@property Store *store;

- (IBAction)btnBackClick:(id)sender;
- (IBAction)btnDeleteClick:(id)sender;
- (IBAction)btnRetrieveTitleAutomaticallyClick:(id)sender;
- (IBAction)btnUseSecureConnectionClick:(id)sender;
- (IBAction)btnOrderCreatedClick:(id)sender;
- (IBAction)btnOrderStatusChangedClick:(id)sender;
- (IBAction)btnNewCustomerRegisteredClick:(id)sender;
- (IBAction)btnSaveClick:(id)sender;
- (IBAction)btnCancelClick:(id)sender;

@end
