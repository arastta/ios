//
//  ManageStoresViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 02/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "ManageStoresViewController.h"
#import "ManageStoreViewController.h"
#import "Store.h"
#import "StoreCell.h"

@interface ManageStoresViewController () {
	
	NSArray *storeList;
	
}

@end


@implementation ManageStoresViewController


- (UIStatusBarStyle)preferredStatusBarStyle
{
	
	return UIStatusBarStyleLightContent;
	
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	[self listStores];
	
	
}


- (void)listStores {
	
	// <store list>
	
	storeList = [Store list];
	
	if (storeList.count == 0)
	{
		
		self.btnBack.hidden = YES;
		
		self.imgBack.hidden = YES;
		
	}
	else
	{
		
		self.btnBack.hidden = NO;
		
		self.imgBack.hidden = NO;
		
	}
	
	[self.tableStores reloadData];
	
	self.tableStores.frame = CGRectMake(0, 0, self.tableStores.frame.size.width, 70 * storeList.count);
	
	CGRect frmAddStore = self.viewAddStore.frame;
	
	frmAddStore.origin.y = self.tableStores.frame.size.height;
	
	self.viewAddStore.frame = frmAddStore;
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.tableStores.frame.size.height + frmAddStore.size.height);
	
	// </store list>
	
}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}


- (IBAction)btnBackClick:(id)sender {
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}


- (IBAction)btnAddStoreClick:(id)sender {
	
	[self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"viewManageStore"] animated:YES completion:nil];
	
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
	
	cell.btnManageStore.tag = indexPath.row;
	
	[cell.btnManageStore addTarget:self action:@selector(btnManageStoreClick:) forControlEvents:UIControlEventTouchUpInside];
	
	return cell;
	
}


-(IBAction)btnManageStoreClick:(id)sender
{
	
	NSUInteger tag = ((UIButton *)sender).tag;
	
	Store *store = (Store*)[storeList objectAtIndex:tag];
	
	ManageStoreViewController *msvc = (ManageStoreViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"viewManageStore"];
	
	msvc.store = store;
	
	[self presentViewController:msvc animated:YES completion:nil];
	
}


@end
