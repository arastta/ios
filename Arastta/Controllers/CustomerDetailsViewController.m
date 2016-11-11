//
//  CustomerDetailsViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 29/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "CustomerDetailsViewController.h"
#import "OrderDetailsViewController.h"
#import "Order.h"
#import "UIColor+Expanded.h"
#import "ArasttaAPI.h"
#import "OrderCell.h"

@interface CustomerDetailsViewController () {
	
	NSMutableArray *orderList;
	
}


@end


@implementation CustomerDetailsViewController


@synthesize description;


- (UIStatusBarStyle)preferredStatusBarStyle
{
	
	return UIStatusBarStyleLightContent;
	
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	// <render title section>
	
	self.lblTitle.text = self.customer.name;
	
	self.lblEmail.text = self.customer.email;
	
	self.lblTelephone.text = self.customer.telephone;
	
	self.lblTotal.text = self.customer.order_nice_total;
	
	self.lblTelephone.userInteractionEnabled = YES;
	UITapGestureRecognizer *tapGesture =
	[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneNumberLabelTap)];
	[self.lblTelephone addGestureRecognizer:tapGesture];
	
	// </render title section>
	
	
	
	// <render info tab>
	
	self.customer_id.text = self.customer.customer_id;
	
	self.name.text = self.customer.name;
	
	self.ip.text = self.customer.ip;
	
	self.description.text = self.customer.description;
	
	self.order_number.text = self.customer.order_number;
	
	self.date_added.text = self.customer.date_added;
	
	// </render info tab>
	
	
	
	// <order list>
	
	[self.indicatorLoading startAnimating];
	
	[ArasttaAPI orderListByCustomerId:^(NSMutableArray *orders) {
		
		[self.indicatorLoading stopAnimating];
		
		orderList = [orders copy];
		
		[self.tableOrders reloadData];
		
	} failure:^(NSError *error) {
		
		[[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
		
		[self.indicatorLoading stopAnimating];
		
	} customer_id:self.customer.customer_id parameters:nil];
	
	// </order list>
	
}


-(void)phoneNumberLabelTap
{
	NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", self.lblTelephone.text]];
	
	if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
		[[UIApplication sharedApplication] openURL:phoneUrl];
	} else {
		UIAlertView * calert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"alertError", nil) message:NSLocalizedString(@"alertCallFacilityUnavailable", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"alertOK", nil) otherButtonTitles:nil, nil];
		[calert show];
	}
}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}


- (IBAction)btnBackClick:(id)sender {
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}


- (IBAction)btnProductsClick:(id)sender {
	
	[self switchToTab:0];
	
}


- (IBAction)btnInfoClick:(id)sender {
	
	[self switchToTab:1];
	
}


- (void)switchToTab:(int)tabId {
	
	UIColor *grayColour = [UIColor colorWithHexString:@"6D6E71"];
	
	UIColor *arasttaColour = [UIColor colorWithHexString:@"008DB9"];
	
	UIFont *fontBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
	
	UIFont *fontNormal = [UIFont fontWithName:@"HelveticaNeue" size:14];
	
	[self.btnProducts setTitleColor:grayColour forState:UIControlStateNormal];
	
	[self.btnProducts.titleLabel setFont:fontNormal];
	
	[self.btnInfo setTitleColor:grayColour forState:UIControlStateNormal];
	
	[self.btnInfo.titleLabel setFont:fontNormal];
	
	CGRect frmTabSelection = self.viewTabSelection.frame;
	
	frmTabSelection.origin.x = frmTabSelection.size.width * tabId;
	
	self.viewTabSelection.frame = frmTabSelection;
	
	switch (tabId) {
			
		case 0:
			
			[self.btnProducts setTitleColor:arasttaColour forState:UIControlStateNormal];
			
			[self.btnProducts.titleLabel setFont:fontBold];
			
			self.tableOrders.hidden = NO;
			
			self.viewInfo.hidden = YES;
			
			break;
			
		case 1:
			
			[self.btnInfo setTitleColor:arasttaColour forState:UIControlStateNormal];
			
			[self.btnInfo.titleLabel setFont:fontBold];
			
			self.tableOrders.hidden = YES;
			
			self.viewInfo.hidden = NO;
			
			break;
			
	}
	
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
	
	cell.lblOrderId.text = [NSString stringWithFormat:@"ID: %@", order.order_id];
	
	cell.lblOrderTotal.text = order.nice_total;
	
	cell.lblOrderStatus.text = order.order_status;
	
	cell.lblOrderDate.text = order.date_added;
	
	cell.lblProductCount.text = [NSString stringWithFormat:@"Products: %@", order.product_number];
	
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


@end
