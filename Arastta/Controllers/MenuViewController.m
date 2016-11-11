//
//  MenuViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 27/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "MenuViewController.h"
#import "ECSlidingViewController.h"
#import "UIColor+Expanded.h"
#import "ImageCache.h"
#import "StoreCell.h"

@interface MenuViewController () {
	
	CGRect screenRect;
	
	NSArray *storeList;
	
	CGRect storeListRect;
	
}

@end

@implementation MenuViewController


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	screenRect = [[UIScreen mainScreen] bounds];
	
	
	[self.slidingViewController setAnchorRightRevealAmount:screenRect.size.width - screenRect.size.width / 3];
	
	self.slidingViewController.underLeftWidthLayout = ECFullWidth;
	
	
	// <login control>
	if (![Store exists])
	{
		
		[self performSelector:@selector(goToLogin) withObject:nil afterDelay:0.1];
		
	}
	else
	{
		
		self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 214);
		
		// <current store>
		
		Store *currentStore = [Store get];
		
		[self loadStore:currentStore];
		
		// </current store>
		
		
		// <store list>
		
		[self loadStores];
		
		// </store list>
		
	}
	// </login control>
	
}


- (void)loadStores {
	
	storeList = [Store list];
	
	storeListRect = CGRectMake(0, 54, self.tableStores.frame.size.width, (42 * storeList.count) + 10);
	
	self.tableStores.frame = CGRectMake(0, 0, self.tableStores.frame.size.width, 42 * storeList.count);
	
}


- (void)loadStore:(Store*)store {
	
	[ImageCache loadImage:store.config_image complete:^(UIImage *image) {
		
		self.imgAvatar.image = image;
		
	}];
	
	self.imgAvatar.clipsToBounds = YES;
	
	self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.size.width / 2;
	
	self.imgAvatar.layer.borderWidth = 2;
	
	self.imgAvatar.layer.borderColor = [UIColor colorWithHexString:@"008db9"].CGColor;
	
	CGRect frmAvatar = self.imgAvatar.frame;
	
	frmAvatar.size.height = frmAvatar.size.width;
	
	self.imgAvatar.frame = frmAvatar;
	
	
	self.lblCurrentStoreName.text = store.config_name;
	
	self.lblCurrentStoreLink.text = store.store_url;
	
}


- (void)goToLogin {
	
	[self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"viewManageStore"] animated:NO completion:nil];
	
}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}


- (IBAction)btnSwitchStoreClick:(id)sender {
	
	[UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		
		if (self.viewStoreList.frame.size.height == 0)
		{
			
			self.viewStoreList.frame = storeListRect;
			
			CGRect frmMenu = self.viewMenu.frame;
			
			frmMenu.origin.y = storeListRect.origin.y + storeListRect.size.height;
			
			self.viewMenu.frame = frmMenu;
			
			self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 224 + (storeList.count * 42));
			
			self.viewManageStores.hidden = NO;
			
		}
		else
		{
			
			self.viewStoreList.frame = CGRectMake(0, 54, storeListRect.size.width, 0);
			
			CGRect frmMenu = self.viewMenu.frame;
			
			frmMenu.origin.y = 53;
			
			self.viewMenu.frame = frmMenu;
			
			self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 214);
			
			self.viewManageStores.hidden = YES;
			
		}

	} completion:nil];
	
}


- (void)closeMenu {
	
	[self.slidingViewController resetTopViewWithAnimations:nil onComplete:nil];
	
}


- (IBAction)btnMenuItem1Click:(id)sender {
	
	[self closeMenu];
	
	self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewDashboard"];
	
}


- (IBAction)btnMenuItem2Click:(id)sender {
	
	[self closeMenu];
	
	self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewOrders"];
	
}


- (IBAction)btnMenuItem3Click:(id)sender {
	
	[self closeMenu];
	
	self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewCustomers"];
	
}


- (IBAction)btnMenuItem4Click:(id)sender {
	
	[self closeMenu];
	
	self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewProducts"];
	
}


- (IBAction)btnSettingsClick:(id)sender {
	
	[self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"viewAppSettings"] animated:YES completion:nil];
	
}


- (IBAction)btnManageStoresClick:(id)sender {
	
	[self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"viewManageStores"] animated:YES completion:nil];
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return storeList.count;
	
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *cellIdentifier = @"cellStore";
	
	StoreCell *cell = (StoreCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
	
	if (cell == nil) cell = [[StoreCell alloc] init];
	
	Store *store = [storeList objectAtIndex:indexPath.row];
	
	cell.lblStoreTitle.text = store.config_name;
	
	return cell;
	
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	Store *store = [storeList objectAtIndex:indexPath.row];
	
	[Store switchTo:store];
	
	[self loadStore:store];
	
	self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewDashboard"];
	
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
	
}


@end
