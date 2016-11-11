//
//  ManageStoreViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 02/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "ManageStoreViewController.h"
#import "ManageStoresViewController.h"
#import "MenuViewController.h"
#import "SliderViewController.h"
#import "ArasttaAPI.h"

@interface ManageStoreViewController () {
	
	BOOL	retrieveTitleAutomatically,
			useSecureConnection,
			orderCreated,
			orderStatusChanged,
			newCustomerRegistered;
	
}

@end

@implementation ManageStoreViewController


- (UIStatusBarStyle)preferredStatusBarStyle
{
	
	return UIStatusBarStyleLightContent;
	
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	retrieveTitleAutomatically = NO;
	
	useSecureConnection = NO;
	
	orderCreated = YES;
	
	orderStatusChanged = YES;
	
	newCustomerRegistered = YES;
	
	
	if (self.store != nil)
	{
		
		self.lblTitle.text = self.store.config_name;
		
		self.txtStoreTitle.text = self.store.config_name;
		
		self.txtStoreUrl.text = self.store.store_url;
		
		useSecureConnection = !self.store.use_tls;
		
		[self btnUseSecureConnectionClick:nil];
		
		self.txtUsername.text = self.store.username;
		
		self.txtPassword.text = self.store.password;
		
		self.imgDelete.hidden = NO;
		
		self.btnDelete.hidden = NO;
		
	}
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 572);
	
}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}


- (IBAction)btnBackClick:(id)sender {
	
	[self btnCancelClick:nil];
	
}


- (IBAction)btnDeleteClick:(id)sender {
	
	UIAlertController *alert =   [UIAlertController
								  alertControllerWithTitle:NSLocalizedString(@"alertDeleteConfirmation", nil)
								  message:NSLocalizedString(@"alertDeleteDescription", nil)
								  preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction* ok = [UIAlertAction
						 actionWithTitle:NSLocalizedString(@"alertDelete", nil)
						 style:UIAlertActionStyleDestructive
						 handler:^(UIAlertAction * action)
						 {
							 
							 Store *newStore = [Store delete:self.store];
							 
							 ManageStoresViewController *msvc = (ManageStoresViewController*)self.presentingViewController;
							 
							 [msvc listStores];
							 
							 [self dismissViewControllerAnimated:YES completion:nil];
							 
							 if (newStore != nil)
							 {
							 
								 // <update switch to store list from menu>
								 
								 MenuViewController *mvc = (MenuViewController*)((SliderViewController*)msvc.presentingViewController).underLeftViewController;
								 
								 [mvc loadStore:newStore];
									 
								 [mvc loadStores];
								 
								 [mvc.tableStores reloadData];
								 
								 // </update switch to store list from menu>
								 
							 }
							 
						 }];
	
	[alert addAction:ok];
	
	UIAlertAction* cancel = [UIAlertAction
						 actionWithTitle:NSLocalizedString(@"alertCancel", nil)
						 style:UIAlertActionStyleCancel
						 handler:nil];
	
	[alert addAction:cancel];
	
	[self presentViewController:alert animated:YES completion:nil];
	
}


- (IBAction)btnRetrieveTitleAutomaticallyClick:(id)sender {
	
	retrieveTitleAutomatically = !retrieveTitleAutomatically;
	
	if (retrieveTitleAutomatically)
	{
		
		self.imgRetrieveTitleAutomatically.image = [UIImage imageNamed:@"checkbox-checked.png"];
		
	}
	else
	{
		
		self.imgRetrieveTitleAutomatically.image = [UIImage imageNamed:@"checkbox-unchecked.png"];
		
	}
	
}


- (IBAction)btnUseSecureConnectionClick:(id)sender {
	
	useSecureConnection = !useSecureConnection;
	
	if (useSecureConnection)
	{
		
		self.imgUseSecureConnection.image = [UIImage imageNamed:@"checkbox-checked.png"];
		
	}
	else
	{
		
		self.imgUseSecureConnection.image = [UIImage imageNamed:@"checkbox-unchecked.png"];
		
	}
	
}


- (IBAction)btnOrderCreatedClick:(id)sender {
	
	orderCreated = !orderCreated;
	
	if (orderCreated)
	{
		
		self.imgOrderCreated.image = [UIImage imageNamed:@"checkbox-checked.png"];
		
	}
	else
	{
		
		self.imgOrderCreated.image = [UIImage imageNamed:@"checkbox-unchecked.png"];
		
	}
	
}


- (IBAction)btnOrderStatusChangedClick:(id)sender {
	
	orderStatusChanged = !orderStatusChanged;
	
	if (orderStatusChanged)
	{
		
		self.imgOrderStatusChanged.image = [UIImage imageNamed:@"checkbox-checked.png"];
		
	}
	else
	{
		
		self.imgOrderStatusChanged.image = [UIImage imageNamed:@"checkbox-unchecked.png"];
		
	}
	
}


- (IBAction)btnNewCustomerRegisteredClick:(id)sender {
	
	newCustomerRegistered = !newCustomerRegistered;
	
	if (newCustomerRegistered)
	{
		
		self.imgNewCustomerRegistered.image = [UIImage imageNamed:@"checkbox-checked.png"];
		
	}
	else
	{
		
		self.imgNewCustomerRegistered.image = [UIImage imageNamed:@"checkbox-unchecked.png"];
		
	}
	
}


- (IBAction)btnSaveClick:(id)sender {
	
	if ([[self.presentingViewController class] isEqual:[ManageStoresViewController class]])
	{
	
		ManageStoresViewController *msvc = (ManageStoresViewController*)self.presentingViewController;
		
		
		if (self.store != nil)
		{
			
			NSDictionary *storeDetails = @{@"store_url": self.txtStoreUrl.text,
										   @"config_name": self.txtStoreTitle.text,
										   @"config_image": self.store.config_image,
										   @"username": self.txtUsername.text,
										   @"password": self.txtPassword.text,
										   @"use_tls": [NSString stringWithFormat:@"%d", useSecureConnection]};
			
			if ([Store update:self.store newStore:storeDetails])
			{
				
				[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alertSuccess", nil) message:NSLocalizedString(@"alertSuccessDescription", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"alertOK", nil) otherButtonTitles:nil, nil] show];
				
				[Store set:self.txtStoreUrl.text config_name:self.txtStoreTitle.text config_image:self.store.config_name username:self.txtUsername.text password:self.txtPassword.text use_tls:useSecureConnection];
				
				
				// <update store list from manage stores>
				
				[msvc listStores];
				
				// </update store list from manage stores>
				
				
				// <update switch to store list from menu>
				
				Store *storeToSwitchTo = [[Store alloc] initWithAttributes:storeDetails];
				
				MenuViewController *mvc = (MenuViewController*)((SliderViewController*)msvc.presentingViewController).underLeftViewController;
				
				[mvc loadStore:storeToSwitchTo];
				
				[mvc loadStores];
				
				[mvc.tableStores reloadData];
				
				// </update switch to store list from menu>
				
				[self dismissViewControllerAnimated:YES completion:nil];
				
			}
			else
			{
				
				[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alertError", nil) message:NSLocalizedString(@"alertStoreDetailsCouldNotBeUpdated", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"alertOK", nil) otherButtonTitles:nil, nil] show];
				
			}
			
		}
		else
		{
			
			[self.indicatorLoading startAnimating];
			
			[ArasttaAPI settings:^(Store *store) {
				
				[self.indicatorLoading stopAnimating];
				
				NSLog(@"retrieveTitleAutomatically: %d", retrieveTitleAutomatically);
				
				if (!retrieveTitleAutomatically) store.config_name = self.txtStoreTitle.text;
				
				BOOL success = [Store addToList:store];
				
				NSLog(@"✓ store was successfully added to list!");
				
				success = [Store set:self.txtStoreUrl.text config_name:store.config_name config_image:store.config_image username:self.txtUsername.text password:self.txtPassword.text use_tls:useSecureConnection];
				
				NSLog(@"✓ store was successfully set as current store!");
				
				if (success)
				{
					
					// <update store list from manage stores>
					
					[msvc listStores];
					
					// </update store list from manage stores>
					
					
					// <update switch to store list from menu>
					
					[Store switchTo:store];
					
					MenuViewController *mvc = (MenuViewController*)((SliderViewController*)msvc.presentingViewController).underLeftViewController;
					
					NSLog(@"store.config_image: %@", store.config_image);
					
					[mvc loadStore:store];
					
					[mvc loadStores];
					
					[mvc.tableStores reloadData];
					
					// </update switch to store list from menu>
					
					[self dismissViewControllerAnimated:YES completion:nil];
					
				}
				else
				{
					
					[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alertError", nil) message:NSLocalizedString(@"alertStoreDetailsCouldNotBeSaved", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"alertOK", nil) otherButtonTitles:nil, nil] show];
					
				}
				
			} failure:^(NSError *error) {
				
				[self.indicatorLoading stopAnimating];
				
				[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alertError", nil) message:error.localizedDescription delegate:self cancelButtonTitle:NSLocalizedString(@"alertOK", nil) otherButtonTitles:nil, nil] show];
				
			} storeLink:self.txtStoreUrl.text username:self.txtUsername.text password:self.txtPassword.text];
			
		}
		
	}
	else
	{
		
		// first launch
		
		[self.indicatorLoading startAnimating];
		
		[ArasttaAPI settings:^(Store *store) {
			
			[self.indicatorLoading stopAnimating];
			
			if (!retrieveTitleAutomatically) store.config_name = self.txtStoreTitle.text;
			
			BOOL success = [Store addToList:store];
			
			NSLog(@"✓ store was successfully added to list!");
			
			success = [Store set:self.txtStoreUrl.text config_name:store.config_name config_image:store.config_image username:self.txtUsername.text password:self.txtPassword.text use_tls:useSecureConnection];
			
			NSLog(@"✓ store was successfully set as current store!");
			
			if (success)
			{
				
				// <update switch to store list from menu>
				
				MenuViewController *mvc = (MenuViewController*)((SliderViewController*)self.presentingViewController).underLeftViewController;
				
				NSLog(@"store.config_image: %@", store.config_image);
				
				[mvc loadStore:store];
				
				[mvc loadStores];
				
				[mvc.tableStores reloadData];
				
				// </update switch to store list from menu>
				
				[self dismissViewControllerAnimated:YES completion:nil];
				
			}
			else
			{
				
				[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alertError", nil) message:NSLocalizedString(@"alertStoreDetailsCouldNotBeSaved", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"alertOK", nil) otherButtonTitles:nil, nil] show];
				
			}
			
		} failure:^(NSError *error) {
			
			[self.indicatorLoading stopAnimating];
			
			[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alertError", nil) message:error.localizedDescription delegate:self cancelButtonTitle:NSLocalizedString(@"alertOK", nil) otherButtonTitles:nil, nil] show];
			
		} storeLink:self.txtStoreUrl.text username:self.txtUsername.text password:self.txtPassword.text];
		
		
	}
	
	
}


- (IBAction)btnCancelClick:(id)sender {
	
	if ([[self.presentingViewController class] isEqual:[ManageStoresViewController class]])
	{
		
		[self dismissViewControllerAnimated:YES completion:nil];
		
	}
	else
	{

		UIApplication *app = [UIApplication sharedApplication];
		
		[app performSelector:@selector(suspend)];
		
		[NSThread sleepForTimeInterval:2.0];
		
		exit(0);
		
	}
	
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[self.view endEditing:YES];
	
	return YES;
	
}


@end
