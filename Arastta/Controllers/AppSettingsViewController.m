//
//  AppSettingsViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 08/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "AppSettingsViewController.h"
#import "ArasttaAPI.h"

@interface AppSettingsViewController () {
	
	BOOL notifications;
	
}

@end

@implementation AppSettingsViewController


- (UIStatusBarStyle)preferredStatusBarStyle
{
	
	return UIStatusBarStyleLightContent;
	
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	notifications = YES;
	
}


- (void)didReceiveMemoryWarning {
	
	[super didReceiveMemoryWarning];
	
}


- (IBAction)btnBackClick:(id)sender {
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}


- (IBAction)btnInterfaceLanguageClick:(id)sender {
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General&path=INTERNATIONAL"]];
	
}


- (IBAction)btnNotificationsClick:(id)sender {
	
	notifications = !notifications;
	
	if (notifications)
	{
		
		self.imgNotifications.image = [UIImage imageNamed:@"checkbox-checked.png"];
		
	}
	else
	{
		
		self.imgNotifications.image = [UIImage imageNamed:@"checkbox-unchecked.png"];
		
	}
	
}


- (IBAction)btnGetArasttaCloudClick:(id)sender {
	
	[ArasttaAPI goToCloud];
	
}


@end
