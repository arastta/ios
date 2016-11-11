//
//  ProductsViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 28/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "ProductsViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "UIColor+Expanded.h"
#import "ProductDetailsViewController.h"
#import "ArasttaAPI.h"
#import "Product.h"
#import "ProductCell.h"
#import "ImageCache.h"

@interface ProductsViewController () {
	
	NSMutableArray *productList, *productListOrdered;
	
	Store *currentStore;
	
	int currentTab;
	
	NSString *stringSearch;
	
}

@end

@implementation ProductsViewController


- (UIStatusBarStyle)preferredStatusBarStyle
{
	
	return UIStatusBarStyleLightContent;
	
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	stringSearch = @"";
	
	
	currentStore = [Store get];
	
	
	productList = [[NSMutableArray alloc] init];
	
	productListOrdered = [[NSMutableArray alloc] init];
	
	
	
	/// <sliding menu>
	if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]])
	{
		
		MenuViewController *mViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewMenu"];
		
		self.slidingViewController.underLeftViewController = mViewController;
		
	}
	[self.view addGestureRecognizer:self.slidingViewController.panGesture];
	/// </sliding menu>
	
	NSLog(@"loading products..");
	
	[self loadProducts:0];
	
}


-(void)loadProducts:(int)tabId {

	// <set parameters>
	
	id parameters;
	
	switch (tabId) {
	
		case 0:
			
			parameters = @{@"ordered": @"0", @"search": stringSearch};
			
			break;
			
		case 1:
			
			parameters = @{@"ordered": @"1", @"search": stringSearch};
			
			break;
			
	}
	
	// </set parameters>
	
	
	// <product list>
	
	[self.indicatorLoading startAnimating];
	
	[ArasttaAPI productList:^(NSMutableArray *products) {
		
		[self.indicatorLoading stopAnimating];
		
		switch (tabId) {
				
			case 0:
				
				productList = [products copy];
				
				[self.tableProducts reloadData];
				
				break;
				
			case 1:
				
				productListOrdered = [products copy];
				
				[self.tableProductsOrdered reloadData];
				
				break;
				
		}
		
	} failure:^(NSError *error) {
		
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alertError", nil) message:error.description delegate:self cancelButtonTitle:NSLocalizedString(@"alertOK", nil) otherButtonTitles:nil, nil] show];
		
		[self.indicatorLoading stopAnimating];
		
	} parameters:parameters];
	
	// </product list>
	
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
	
	[self loadProducts:currentTab];
	
	[self.view endEditing:YES];
	
}


- (IBAction)btnAllClick:(id)sender {
	
	[self switchToTab:0];
	
}


- (IBAction)btnOrderedClick:(id)sender {
	
	[self switchToTab:1];
	
}


- (void)switchToTab:(int)tabId {
	
	currentTab = tabId;
	
	UIColor *grayColour = [UIColor colorWithHexString:@"6D6E71"];
	
	UIColor *arasttaColour = [UIColor colorWithHexString:@"008DB9"];
	
	UIFont *fontBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
	
	UIFont *fontNormal = [UIFont fontWithName:@"HelveticaNeue" size:14];
	
	[self.btnAll setTitleColor:grayColour forState:UIControlStateNormal];
	
	[self.btnAll.titleLabel setFont:fontNormal];
	
	[self.btnOrdered setTitleColor:grayColour forState:UIControlStateNormal];
	
	[self.btnOrdered.titleLabel setFont:fontNormal];
	
	CGRect frmTabSelection = self.viewTabSelection.frame;
	
	frmTabSelection.origin.x = frmTabSelection.size.width * tabId;
	
	self.viewTabSelection.frame = frmTabSelection;
	
	switch (tabId) {
			
		case 0:
			
			[self.btnAll setTitleColor:arasttaColour forState:UIControlStateNormal];
			
			[self.btnAll.titleLabel setFont:fontBold];
			
			self.tableProducts.hidden = NO;
			
			self.tableProductsOrdered.hidden = YES;
			
			break;
			
		case 1:
			
			[self.btnOrdered setTitleColor:arasttaColour forState:UIControlStateNormal];
			
			[self.btnOrdered.titleLabel setFont:fontBold];
			
			self.tableProducts.hidden = YES;
			
			self.tableProductsOrdered.hidden = NO;
			
			break;
			
	}
	
	[self loadProducts:currentTab];
	
}


- (IBAction)btnGetArasttaCloudClick:(id)sender {
	
	[ArasttaAPI goToCloud];
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	if (tableView == self.tableProducts)
	{
		
		return productList.count;
		
	}
	else
	{
		
		return productListOrdered.count;
		
	}
	
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

	static NSString *cellIdentifier = @"cellProduct";

	ProductCell *cell = (ProductCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
	
	if (cell == nil) cell = [[ProductCell alloc] init];

	Product *product;
	
	if (tableView == self.tableProducts)
	{
		
		product = [productList objectAtIndex:indexPath.row];
		
	}
	else
	{
		
		product = [productList objectAtIndex:indexPath.row];
		
	}
	
	[ImageCache loadImage:[NSString stringWithFormat:@"http://%@/%@", currentStore.store_url, [product.images objectAtIndex:0]] complete:^(UIImage *image) {
		
		NSLog(@"%@", [NSString stringWithFormat:@"http://%@/%@", currentStore.store_url, [product.images objectAtIndex:0]]);
		
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
	
	UIColor *statusColour = [ArasttaAPI colourByProductStatus:product.status];
	
	cell.lblProductStatus.textColor = statusColour;
	
	cell.lblProductPrice.textColor = statusColour;
	
	if ([product.status isEqualToString:@"0"])
	{
		cell.lblProductStatus.text = NSLocalizedString(@"disabled", nil);
	}
	else
	{
		cell.lblProductStatus.text = NSLocalizedString(@"enabled", nil);
	}
	
	
	return cell;
	
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	Product *product;
	
	if (tableView == self.tableProducts)
	{
		
		product = [productList objectAtIndex:indexPath.row];
		
	}
	else
	{
		
		product = [productListOrdered objectAtIndex:indexPath.row];
		
	}

	ProductDetailsViewController *pdvc = (ProductDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"viewProductDetails"];
	
	pdvc.product = product;
	
	[self presentViewController:pdvc animated:YES completion:nil];

	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
	
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	if (textField.text.length > 0)
	{
		
		stringSearch = textField.text;
		
		[self loadProducts:currentTab];
		
	}
	
	[self.view endEditing:YES];
	
	return YES;
	
}


@end
