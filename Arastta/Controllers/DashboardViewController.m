//
//  ViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 03/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "DashboardViewController.h"
#import "ECSlidingViewController.h"
#import "SliderViewController.h"
#import "MenuViewController.h"
#import "UIColor+Expanded.h"
#import "ArasttaChart.h"
#import "ArasttaAPI.h"
#import "Customer.h"
#import "Order.h"
#import "Product.h"
#import "DatePart.h"

@interface DashboardViewController ()
{
	
	CGRect screenRect;
	
	int currentTab;
	
}

@end

@implementation DashboardViewController


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	screenRect = [[UIScreen mainScreen] bounds];
	
	currentTab = 0;
	
	
	/// <sliding menu>
	if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]])
	{
		
		MenuViewController *mViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewMenu"];
		
		self.slidingViewController.underLeftViewController = mViewController;
		
	}
	
	[self.view addGestureRecognizer:self.slidingViewController.panGesture];
	/// </sliding menu>
	
	
	
	self.scrollView.contentSize = CGSizeMake(screenRect.size.width, 570);
	
	if ([Store exists])
		[self loadDashboard:0];
	
	
}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}


- (IBAction)btnMenuClick:(id)sender {
	
	ECSlidingViewController *slidingViewController = self.slidingViewController;
	
	[slidingViewController anchorTopViewTo:ECRight animations:nil onComplete:nil];
	
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


- (IBAction)btnOrdersClick:(id)sender {
	
	self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewOrders"];
	
}


- (IBAction)btnCustomersClick:(id)sender {
	
	self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewCustomers"];
	
}


- (IBAction)btnProductsClick:(id)sender {
	
	self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewProducts"];
	
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
	
	[self loadDashboard:tabId];
	
}


-(void)loadDashboard:(int)tabId {
	
	// <set parameters>
	id parameters;
	
	
	switch (tabId) {
			
		case 0:
		{
			
			NSString *strToday = [DatePart today];
			
			NSString *strTomorrow = [DatePart tomorrow];
			
			parameters = @{@"date_from": strToday, @"date_to": strTomorrow};
			
		}
			break;
			
		case 1:
		{
			
			NSString *strBeginningOfMonth = [DatePart beginningOfMonth];
			
			NSString *strEndOfMonth = [DatePart endOfMonth];
			
			parameters = @{@"date_from": strBeginningOfMonth, @"date_to": strEndOfMonth};
			
		}
			break;
			
		case 2:
		{
			
			NSString *strBeginningOfYear = [DatePart beginningOfYear];
			
			NSString *strEndOfYear = [DatePart endOfYear];
			
			parameters = @{@"date_from": strBeginningOfYear, @"date_to": strEndOfYear};
			
		}
			break;
			
	}
	// </set parameters>
	
	
	// <load dashboard data>
	
	[self.indicatorLoading startAnimating];
	
	[ArasttaAPI stats:^(Dashboard *dashboard) {
		
		self.lblSalesTotal.text = dashboard.orders_niceprice;
		
		self.lblOrderTotal.text = dashboard.orders;
		
		self.lblCustomersTotal.text = dashboard.customers;
		
		self.lblProductsTotal.text = dashboard.products;
		
		
		/// <chart>
		
		ArasttaChart *chart = [[ArasttaChart alloc] initWithFrame:self.viewChart.frame];
		
		[[self.viewChart subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		
		[self.viewChart addSubview:[chart drawChart:dashboard.orders_daily]];
		
		/// </chart>
		
		
		/// <avarages>
		
		int days = (int)dashboard.orders_daily.count - 1;
		
		if ([dashboard.orders_price floatValue] > 0)
		{
			self.lblAvgOrderValDay.text = [NSString stringWithFormat:@"$%.02f", [dashboard.orders_price floatValue] / days];
		}
		else
		{
			self.lblAvgOrderValDay.text = @"0";
		}
		
		if ([dashboard.orders intValue] > 0)
		{
			self.lblAvgOrderDay.text = [NSString stringWithFormat:@"%.02f", [dashboard.orders floatValue] / days];
		}
		else
		{
			self.lblAvgOrderDay.text = @"0";
		}
		
		if ([dashboard.customers intValue] > 0)
		{
			self.lblAvgCustomerDay.text = [NSString stringWithFormat:@"%.02f", [dashboard.customers floatValue] / days];
		}
		else
		{
			self.lblAvgCustomerDay.text = @"0";
		}
		
		if ([dashboard.orders_price floatValue] > 0)
		{
			self.lblAvgOrderValCustomer.text = [NSString stringWithFormat:@"$%.02f", [dashboard.orders_price floatValue] / [dashboard.customers floatValue]];
		}
		else
		{
			self.lblAvgOrderValCustomer.text = @"0";
		}
		
		/// </avarages>
		
		
		[self.indicatorLoading stopAnimating];
		
	} failure:^(NSError *error) {
		
		[[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
		
		[self.indicatorLoading stopAnimating];
		
	} parameters:parameters];
	
	// </load dashboard data>
	
}


- (IBAction)btnGetArasttaCloudClick:(id)sender {
	
	[ArasttaAPI goToCloud];
	
}


@end
