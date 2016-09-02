//
//  MenuViewController.h
//  Arastta
//
//  Created by Ayhan Dorman on 27/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Store.h"

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrentStoreName;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrentStoreLink;
@property (strong, nonatomic) IBOutlet UIView *viewMenu;
@property (strong, nonatomic) IBOutlet UIView *viewStoreList;
@property (strong, nonatomic) IBOutlet UITableView *tableStores;
@property (strong, nonatomic) IBOutlet UIView *viewManageStores;

- (void)loadStores;
- (void)loadStore:(Store*)store;

- (IBAction)btnSwitchStoreClick:(id)sender;
- (IBAction)btnMenuItem1Click:(id)sender;
- (IBAction)btnMenuItem2Click:(id)sender;
- (IBAction)btnMenuItem3Click:(id)sender;
- (IBAction)btnMenuItem4Click:(id)sender;
- (IBAction)btnSettingsClick:(id)sender;
- (IBAction)btnManageStoresClick:(id)sender;


@end
