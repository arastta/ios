//
//  CustomersViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 29/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "CustomersViewController.h"
#import "ECSlidingViewController.h"
#import "CustomerDetailsViewController.h"
#import "MenuViewController.h"
#import "UIColor+Expanded.h"
#import "ArasttaAPI.h"
#import "CustomerCell.h"
#import "Customer.h"
#import "DatePart.h"

@interface CustomersViewController () {
	
	NSMutableArray *customerList;
	
	Store *currentStore;
	
	int currentTab;
	
	NSString *stringSearch;
	
}

@end

@implementation CustomersViewController


- (UIStatusBarStyle)preferredStatusBarStyle
{
	
	return UIStatusBarStyleLightContent;
	
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	stringSearch = @"";
	
	currentTab = 0;
	
	currentStore = [Store get];
	
	/// <sliding menu>
	if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]])
	{
		
		MenuViewController *mViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewMenu"];
		
		self.slidingViewController.underLeftViewController = mViewController;
		
	}
	[self.view addGestureRecognizer:self.slidingViewController.panGesture];
	/// </sliding menu>
	
	
	// <customer list>
	
	[self loadCustomers:0];
	
	// </customer list>
	
}


-(void)loadCustomers:(int)tabId {
	
	// <set parameters>
	
	id parameters;
	
	
	switch (tabId) {
			
		case 0:
		{
			
			NSString *strToday = [DatePart today];
			
			NSString *strTomorrow = [DatePart tomorrow];
			
			parameters = @{@"date_from": strToday, @"date_to": strTomorrow, @"search": stringSearch};
			
		}
			break;
			
		case 1:
		{
			
			NSString *strBeginningOfMonth = [DatePart beginningOfMonth];
			
			NSString *strEndOfMonth = [DatePart endOfMonth];
			
			parameters = @{@"date_from": strBeginningOfMonth, @"date_to": strEndOfMonth, @"search": stringSearch};
			
		}
			break;
			
		case 2:
		{
			
			NSString *strBeginningOfYear = [DatePart beginningOfYear];
			
			NSString *strEndOfYear = [DatePart endOfYear];
			
			parameters = @{@"date_from": strBeginningOfYear, @"date_to": strEndOfYear, @"search": stringSearch};
			
		}
			break;
			
	}
	
	// </set parameters>
	
	
	[self.indicatorLoading startAnimating];
	
	[ArasttaAPI customerList:^(NSMutableArray *customers) {
		
		[self.indicatorLoading stopAnimating];
		
		customerList = [customers copy];
		
		[self.tableCustomers reloadData];
		
	} failure:^(NSError *error) {
		
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alertError", nil) message:error.description delegate:self cancelButtonTitle:NSLocalizedString(@"alertOK", nil) otherButtonTitles:nil, nil] show];
		
		[self.indicatorLoading stopAnimating];
		
	} parameters:parameters]; /// PARAMETERS DON'T WORK, API MUST BE FIXED.
	//} parameters:parameters];
	
	
}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}


- (IBAction)btnMenuClick:(id)sender {
	
	ECSlidingViewController *slidingViewController = self.slidingViewController;
	
	[slidingViewController anchorTopViewTo:ECRight animations:nil onComplete:nil];
	
}


- (IBAction)btnSearchClick:(id)sender {
	
	self.viewSearch.hidden = NO;
	
	[self.txtSearch becomeFirstResponder];
	
}


- (IBAction)btnCloseSearchClick:(id)sender {
	
	self.viewSearch.hidden = YES;
	
	stringSearch = @"";
	
	[self loadCustomers:currentTab];
	
	[self.view endEditing:YES];
	
}


- (IBAction)btnTodayClick:(id)sender {
	
	[self switchToTab:0];
	
}


- (IBAction)btnMonthlyClick:(id)sender {
	
	[self switchToTab:1];
	
}


- (IBAction)btnYearlyClick:(id)sender {
	
	[self switchToTab:2];
	
}


- (void)switchToTab:(int)tabId {
	
	currentTab = tabId;
	
	UIColor *grayColour = [UIColor colorWithHexString:@"6D6E71"];
	
	UIColor *arasttaColour = [UIColor colorWithHexString:@"008DB9"];
	
	UIFont *fontBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
	
	UIFont *fontNormal = [UIFont fontWithName:@"HelveticaNeue" size:14];
	
	[self.btnToday setTitleColor:grayColour forState:UIControlStateNormal];
	
	[self.btnToday.titleLabel setFont:fontNormal];
	
	[self.btnMonthly setTitleColor:grayColour forState:UIControlStateNormal];
	
	[self.btnMonthly.titleLabel setFont:fontNormal];
	
	[self.btnYearly setTitleColor:grayColour forState:UIControlStateNormal];
	
	[self.btnYearly.titleLabel setFont:fontNormal];
	
	CGRect frmTabSelection = self.viewTabSelection.frame;
	
	frmTabSelection.origin.x = frmTabSelection.size.width * tabId;
	
	self.viewTabSelection.frame = frmTabSelection;
	
	switch (tabId) {
			
		case 0:
			
			[self.btnToday setTitleColor:arasttaColour forState:UIControlStateNormal];
			
			[self.btnToday.titleLabel setFont:fontBold];
			
			break;
			
		case 1:
			
			[self.btnMonthly setTitleColor:arasttaColour forState:UIControlStateNormal];
			
			[self.btnMonthly.titleLabel setFont:fontBold];
			
			break;
			
		case 2:
			
			[self.btnYearly setTitleColor:arasttaColour forState:UIControlStateNormal];
			
			[self.btnYearly.titleLabel setFont:fontBold];
			
			break;
			
	}
	
	[self loadCustomers:tabId];
	
}


- (IBAction)btnGetArasttaCloudClick:(id)sender {
	
	[ArasttaAPI goToCloud];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return customerList.count;
	
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *cellIdentifier = @"cellCustomer";
	
	CustomerCell *cell = (CustomerCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
	
	if (cell == nil) cell = [[CustomerCell alloc] init];
	
	Customer *customer = [customerList objectAtIndex:indexPath.row];
	
	cell.lblCustomerName.text = [NSString stringWithFormat:@"%@", customer.name];
	
	cell.lblEmail.text = customer.email;
	
	cell.lblCustomerId.text = [NSString stringWithFormat:@"ID: %@", customer.customer_id];
	
	cell.lblOrders.text = customer.order_number;
	
	cell.lblRegistered.text = customer.date_added;
	
	return cell;
	
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	Customer *customer = [customerList objectAtIndex:indexPath.row];
	
	CustomerDetailsViewController *cdvc = (CustomerDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"viewCustomerDetails"];
	
	cdvc.customer = customer;
	
	[self presentViewController:cdvc animated:YES completion:nil];
	
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
	
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	if (textField.text.length > 0)
	{
		
		stringSearch = textField.text;
		
		[self loadCustomers:currentTab];
		
	}
	
	[self.view endEditing:YES];
	
	return YES;
	
}


@end
