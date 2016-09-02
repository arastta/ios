//
//  AppSettingsViewController.h
//  Arastta
//
//  Created by Ayhan Dorman on 08/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppSettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imgNotifications;

- (IBAction)btnBackClick:(id)sender;
- (IBAction)btnInterfaceLanguageClick:(id)sender;
- (IBAction)btnNotificationsClick:(id)sender;
- (IBAction)btnGetArasttaCloudClick:(id)sender;

@end
