//
//  OrderDetailsViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 11/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "ProductDetailsViewController.h"
#import "OrdersViewController.h"
#import "SliderViewController.h"
#import "UIColor+Expanded.h"
#import "ArasttaAPI.h"
#import "ImageCache.h"
#import "ProductCell.h"
#import "Product.h"
#import "HistoryCell.h"
#import "History.h"
#import "OrderStatus.h"

@interface OrderDetailsViewController () {
	
	NSMutableArray *productList, *historyList, *statusList;
	
	Store *currentStore;
	
	NSInteger selected_status_row;
	
	BOOL notifyCustomer;
	
}

@end

@implementation OrderDetailsViewController


- (UIStatusBarStyle)preferredStatusBarStyle
{
	
	return UIStatusBarStyleLightContent;
	
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	// <render title>
	
	self.lblTitle.text = [NSString stringWithFormat:@"%@ %@", self.order.firstname, self.order.lastname];
	
	self.lblOrderTotal.text = self.order.nice_total;
	
	self.lblOrderDate.text = self.order.date_added;
	
	self.imgOrderStatus.image = [self.imgOrderStatus.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	
	self.imgOrderStatus.tintColor = [ArasttaAPI colourByOrderStatus:self.order.order_status_id];
	
	self.lblOrderStatus.text = self.order.order_status;
	
	// </render title>
	
	
	
	currentStore = [Store get];
	
	
	
	// <product list>
	
	[self.indicatorLoading startAnimating];
	
	
	[ArasttaAPI productListByOrderId:^(NSMutableArray *products) {
		
		[self.indicatorLoading stopAnimating];
		
		productList = [products copy];
		
		[self.tableProducts reloadData];
		
	} failure:^(NSError *error) {
		
		[[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
		
		[self.indicatorLoading stopAnimating];
		
	} order_id:self.order.order_id parameters:nil];
	
	// </product list>
	
	
	
	
	// <render info tab>
	
	self.order_id.text = self.order.order_id;
	
	self.invoice_prefix.text = self.order.invoice_prefix;
	
	self.payment_company.text = self.order.payment_company;
	
	self.payment_address_1.text = [NSString stringWithFormat:@"%@ %@", self.order.payment_address_1, self.order.payment_address_2];
	
	[self.payment_address_1 sizeToFit];
	
	self.payment_city.text = self.order.payment_city;
	
	self.payment_country.text = self.order.payment_country;
	
	self.email.text = self.order.email;
	
	self.telephone.text = self.order.telephone;
	
	self.viewInfo.contentSize = CGSizeMake(self.viewInfo.frame.size.width, 400);
	
	self.fax.text = self.order.fax;
	
	self.payment_method.text = self.order.payment_method;
	
	// </render info tab>
	
	
	
	// <history list>
	
	[ArasttaAPI historyByOrderId:^(NSMutableArray *histories) {
		
		historyList = [histories copy];
		
		[self.tableHistories reloadData];
		
	} failure:^(NSError *error) {
		
		[[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
		
	} order_id:self.order.order_id parameters:nil];
	
	// </history list>
	
	
	
	// <status list>
	
	notifyCustomer = NO;
	
	self.viewChangeStatusInner.layer.borderWidth = 2;
	
	self.viewChangeStatusInner.layer.borderColor = [UIColor colorWithHexString:@"008DB9"].CGColor;
	
	self.txtComment.layer.borderWidth = 1;
	
	self.txtComment.layer.borderColor = [UIColor colorWithHexString:@"D2D2D2"].CGColor;
	
	[ArasttaAPI orderStatusList:^(NSMutableArray *statuses) {
		
		statusList = [statuses copy];
		
		[self.pickerStatus reloadComponent:0];
		
	} failure:^(NSError *error) {
		
		[[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
		
	}];
	
	// </status list>
	
	
}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}


- (IBAction)btnBackClick:(id)sender {
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}


- (IBAction)btnRightMenuClick:(id)sender {
	
	self.viewChangeStatus.hidden = NO;
	
}


- (IBAction)btnProductsClick:(id)sender {
	
	[self switchToTab:0];
	
}


- (IBAction)btnInfoClick:(id)sender {
	
	[self switchToTab:1];
	
}


- (IBAction)btnHistoryClick:(id)sender {
	
	[self switchToTab:2];
	
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
	
	[self.btnHistory setTitleColor:grayColour forState:UIControlStateNormal];
	
	[self.btnHistory.titleLabel setFont:fontNormal];
	
	CGRect frmTabSelection = self.viewTabSelection.frame;
	
	frmTabSelection.origin.x = frmTabSelection.size.width * tabId;
	
	self.viewTabSelection.frame = frmTabSelection;
	
	switch (tabId) {
			
		case 0:
			
			[self.btnProducts setTitleColor:arasttaColour forState:UIControlStateNormal];
			
			[self.btnProducts.titleLabel setFont:fontBold];
			
			self.tableProducts.hidden = NO;
			
			self.viewInfo.hidden = YES;
			
			self.tableHistories.hidden = YES;
			
			break;
			
		case 1:
			
			[self.btnInfo setTitleColor:arasttaColour forState:UIControlStateNormal];
			
			[self.btnInfo.titleLabel setFont:fontBold];
			
			self.tableProducts.hidden = YES;
			
			self.viewInfo.hidden = NO;
			
			self.tableHistories.hidden = YES;
			
			break;
			
		case 2:
			
			[self.btnHistory setTitleColor:arasttaColour forState:UIControlStateNormal];
			
			[self.btnHistory.titleLabel setFont:fontBold];
			
			self.tableProducts.hidden = YES;
			
			self.viewInfo.hidden = YES;
			
			self.tableHistories.hidden = NO;
			
			break;
			
	}
	
}


- (IBAction)btnGetArasttaCloudClick:(id)sender {
	
	[ArasttaAPI goToCloud];
	
}


- (IBAction)btnNotifyCustomerClick:(id)sender {
	
	notifyCustomer = !notifyCustomer;
	
	if (notifyCustomer)
	{
		
		self.imgNotifyCustomer.image = [UIImage imageNamed:@"checkbox-checked.png"];
		
	}
	else
	{
		
		self.imgNotifyCustomer.image = [UIImage imageNamed:@"checkbox-unchecked.png"];
		
	}
	
}


- (IBAction)btnSaveStatusClick:(id)sender {
	
	self.viewChangeStatus.hidden = YES;

	OrderStatus *status = (OrderStatus*)[statusList objectAtIndex:selected_status_row];

	NSDictionary *parameters = @{
								 @"status" : status.order_status_id,
								 @"notify" : [NSString stringWithFormat:@"%d", notifyCustomer],
								 @"comment": self.txtComment.text};
	
	[self.indicatorLoading startAnimating];
	
	[ArasttaAPI orderHistoriesAdd:^{
		
		[[[UIAlertView alloc] initWithTitle:@"Success" message:@"Order status was changed successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
		
		self.imgOrderStatus.tintColor = [ArasttaAPI colourByOrderStatus:status.order_status_id];
		
		self.lblOrderStatus.text = status.name;
		
		
		OrdersViewController *ovc = (OrdersViewController*)((SliderViewController*)self.presentingViewController).topViewController;
		
		[ovc loadOrders:ovc.currentTab];
		
		[self.indicatorLoading stopAnimating];
		
	} failure:^(NSError *error) {
		
		[[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
		
		[self.indicatorLoading stopAnimating];
		
	} order_id:self.order.order_id parameters:parameters];
	 
}


- (IBAction)btnCancelStatusClick:(id)sender {
	
	self.viewChangeStatus.hidden = YES;
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	if (tableView == self.tableProducts)
	{
	
		return productList.count;
		
	}
	else
	{
		
		return historyList.count;
		
	}
	
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (tableView == self.tableProducts)
	{
	
		static NSString *cellIdentifier = @"cellProduct";
		
		ProductCell *cell = (ProductCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
		
		if (cell == nil) cell = [[ProductCell alloc] init];
		
		Product *product = [productList objectAtIndex:indexPath.row];
		
		[ImageCache loadImage:[NSString stringWithFormat:@"http://%@/%@", currentStore.store_url, product.image] complete:^(UIImage *image) {
			
			cell.imgProductImage.image = image;
			
			cell.imgProductImage.layer.borderWidth = 1;
			
			cell.imgProductImage.layer.borderColor = [UIColor colorWithHexString:@"e2e2e3"].CGColor;
			
			cell.imgProductImage.layer.cornerRadius = 3;
			
		}];
		
		cell.lblProductName.text = product.name;
		
		cell.lblProductPrice.text = product.nice_price;
		
		cell.lblProductId.text = [NSString stringWithFormat:@"ID: %@", product.product_id];
		
		cell.lblProductQuantity.text = product.quantity;
		
		cell.lblProductModel.text = product.model;
		
		//cell.lblProductStatus.text = product.status;
		
		//UIColor *statusColour = [ArasttaAPI colourByOrderStatus:product.status];
		
		//cell.lblProductStatus.textColor = statusColour;
		
		return cell;
		
	}
	else
	{
		
		static NSString *cellIdentifier = @"cellHistory";
		
		HistoryCell *cell = (HistoryCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
		
		if (cell == nil) cell = [[HistoryCell alloc] init];
		
		History *history = [historyList objectAtIndex:indexPath.row];
		
		
		cell.lblStatus.text = history.order_status_name;

		UIColor *statusColour = [ArasttaAPI colourByOrderStatus:history.order_status_id];
		
		cell.lblStatus.textColor = statusColour;

		
		cell.lblDateAdded.text = history.date_added;
		
		return cell;
		
	}
	
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (tableView == self.tableProducts)
	{
	
		Product *product = [productList objectAtIndex:indexPath.row];
		
		ProductDetailsViewController *pdvc = (ProductDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"viewProductDetails"];
		
		pdvc.product = product;
		
		[self presentViewController:pdvc animated:YES completion:nil];
		
	}
	
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
	
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	
	return 1;
	
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	
	return statusList.count;
	
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	
	selected_status_row = row;
	
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{

	OrderStatus *status = (OrderStatus*)[statusList objectAtIndex:row];

	UILabel *label = [[UILabel alloc] init];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [ArasttaAPI colourByOrderStatus:status.order_status_id];
	label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
	label.textAlignment = NSTextAlignmentCenter;
	
	label.text = status.name;
	
	return label;
	
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	
	if([text isEqualToString:@"\n"])
	{
		[textView resignFirstResponder];
		return NO;
	}
	
	if ([NSString stringWithFormat:@"%@%@", textView.text, text].length >= 100)
		return NO;
	
	return YES;
	
}


@end
