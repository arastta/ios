//
//  OrdersViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 28/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "OrdersViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "UIColor+Expanded.h"
#import "ArasttaAPI.h"
#import "Order.h"
#import "OrderCell.h"
#import "OrderDetailsViewController.h"
#import "DatePart.h"

@interface OrdersViewController () {
	
	NSMutableArray *orderList;
	
	CGFloat orderTotal;
	
	NSString *stringSearch;
	
}

@end


@implementation OrdersViewController

@synthesize currentTab;


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	stringSearch = @"";
	
	
	currentTab = 0;
	
	
	/// <sliding menu>
	if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]])
	{
		
		MenuViewController *mViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewMenu"];
		
		self.slidingViewController.underLeftViewController = mViewController;
		
	}
	[self.view addGestureRecognizer:self.slidingViewController.panGesture];
	/// </sliding menu>
	
	
	[self loadOrders:0];
	
}


-(void)loadOrders:(int)tabId {
	
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
	
	
	// <order list>
	
	[self.indicatorLoading startAnimating];
	
	[ArasttaAPI orderList:^(NSMutableArray *orders) {
		
		[self.indicatorLoading stopAnimating];
		
		orderList = [orders copy];
		
		[self.tableOrders reloadData];
		
	} failure:^(NSError *error) {
		
		[[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
		
		[self.indicatorLoading stopAnimating];
		
	} parameters:parameters];
	// </order list>
	
	
	// <order total>
	[ArasttaAPI orderTotal:^(NSString *nice_price) {
		
		self.lblTotal.text = nice_price;
		
	} failure:^(NSError *error) {
		
		[[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
		
	} parameters:parameters];
	// </order total>
	
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
	
	[self loadOrders:currentTab];
	
	[self.view endEditing:YES];
	
}

- (IBAction)btnRightMenuClick:(id)sender {
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
	
	[self loadOrders:tabId];
	
}


- (IBAction)btnGetArasttaCloudClick:(id)sender {
	
	[ArasttaAPI goToCloud];
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return orderList.count;
	
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *cellIdentifier = @"cellOrder";
	
	OrderCell *cell = (OrderCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
	
	if (cell == nil) cell = [[OrderCell alloc] init];
	
	Order *order = [orderList objectAtIndex:indexPath.row];
	
	cell.lblCustomerName.text = [NSString stringWithFormat:@"%@ %@", order.firstname, order.lastname];
	
	cell.lblOrderTotal.text = order.nice_total;
	
	cell.lblOrderStatus.text = order.order_status;
	
	cell.lblOrderDate.text = order.date_added;
	
	cell.lblCustomerId.text = [NSString stringWithFormat:@"Customer ID: %@", order.customer_id];
	
	cell.lblProductCount.text = [NSString stringWithFormat:@"Products: %@", @"0"];
	
	UIColor *statusColour = [ArasttaAPI colourByOrderStatus:order.order_status_id];
	
	cell.lblOrderTotal.textColor = statusColour;
	
	cell.lblOrderStatus.textColor = statusColour;
	
	return cell;
	
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	Order *order = [orderList objectAtIndex:indexPath.row];
	
	OrderDetailsViewController *odvc = (OrderDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"viewOrderDetails"];
	
	odvc.order = order;
	
	[self presentViewController:odvc animated:YES completion:nil];
	
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
	
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	if (textField.text.length > 0)
	{
		
		stringSearch = textField.text;
		
		[self loadOrders:currentTab];
		
	}
	
	[self.view endEditing:YES];
	
	return YES;
	
}


@end
