//
//  ManageStoresViewController.h
//  Arastta
//
//  Created by Ayhan Dorman on 02/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageStoresViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIImageView *imgBack;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITableView *tableStores;
@property (strong, nonatomic) IBOutlet UIView *viewAddStore;

- (void)listStores;

- (IBAction)btnBackClick:(id)sender;
- (IBAction)btnAddStoreClick:(id)sender;

@end
