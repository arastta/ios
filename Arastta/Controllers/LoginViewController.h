//
//  LoginViewController.h
//  Arastta
//
//  Created by Ayhan Dorman on 28/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtStoreLink;
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;

- (IBAction)btnLoginClick:(id)sender;

@end
