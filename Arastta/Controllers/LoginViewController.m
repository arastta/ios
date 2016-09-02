//
//  LoginViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 28/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+Expanded.h"
#import "ArasttaAPI.h"
#import "Store.h"

@interface LoginViewController () {
	
	CGRect screenRect;
	
}

@end

@implementation LoginViewController


- (UIStatusBarStyle)preferredStatusBarStyle
{
	
	return UIStatusBarStyleLightContent;
	
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	screenRect = [[UIScreen mainScreen] bounds];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
	
	// <set gradient background>
	CAGradientLayer *gradient = [CAGradientLayer layer];
	
	gradient.frame = self.view.bounds;
	
	gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHexString:@"1a90b8"] CGColor], (id)[[UIColor colorWithHexString:@"27acd9"] CGColor], nil];
	
	[self.view.layer insertSublayer:gradient atIndex:0];
	// </set gradient background>
	
}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}


- (void)keyboardWillShow:(NSNotification *)notification
{
	
	CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	
	[UIView animateWithDuration:0.3
						  delay:0.0
						options: UIViewAnimationOptionCurveEaseIn
					 animations:^
	 {
		 
		 [self.view setFrame:CGRectMake(0, -keyboardSize.height / 2, screenRect.size.width, screenRect.size.height)];
		 
	 } completion:nil];
	
}



-(void)keyboardWillHide:(NSNotification *)notification {
	
	[UIView animateWithDuration:0.18
						  delay:0.0
						options: UIViewAnimationOptionCurveEaseIn
					 animations:^
	 {
		 
		 [self.view setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
		 
	 } completion:nil];
	
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	[self.view endEditing:YES];
	
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	if (textField == self.txtStoreLink)
	{
		
		[self.txtUsername becomeFirstResponder];
		
	}
	else if (textField == self.txtUsername)
	{
		
		[self.txtPassword becomeFirstResponder];
		
	}
	else
	{
		
		[textField resignFirstResponder];
		
	}
	
	return YES;
	
}


- (IBAction)btnLoginClick:(id)sender {
	
	[self.indicatorLoading startAnimating];
	
	[ArasttaAPI settings:^(Store *store) {
		
		[self.indicatorLoading stopAnimating];
		
		BOOL success = [Store addToList:store];
		
		NSLog(@"✓ store was successfully added to list!");
		
		success = [Store set:self.txtStoreLink.text config_name:store.config_name config_image:store.config_image username:self.txtUsername.text password:self.txtPassword.text use_tls:NO];
		
		NSLog(@"✓ store was successfully set as current store!");

		if (success)
		{
			
			[self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"viewSlider"] animated:YES completion:nil];
			
		}
		else
		{
			
			[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Store details can not be saved." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
			
		}
		
	} failure:^(NSError *error) {
		
		[self.indicatorLoading stopAnimating];
		
		[[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
		
	} storeLink:self.txtStoreLink.text username:self.txtUsername.text password:self.txtPassword.text];
	
}


@end
