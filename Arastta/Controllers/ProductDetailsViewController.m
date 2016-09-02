//
//  ProductDetailsViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 28/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "ArasttaAPI.h"
#import "ImageCache.h"

@interface ProductDetailsViewController () {
	
	Store *currentStore;
	
	int i;
	
}

@end

@implementation ProductDetailsViewController


- (UIStatusBarStyle)preferredStatusBarStyle
{
	
	return UIStatusBarStyleLightContent;
	
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	currentStore = [Store get];
	
	
	// <render info>
	
	self.lblTitle.text = [NSString stringWithFormat:@"%@ (ID: %@)", self.product.name, self.product.product_id];
	
	self.model.text = self.product.model;
	
	self.nice_price.text = self.product.nice_price;
	
	self.manufacturer_name.text = self.product.manufacturer_name;
	
	// </render info>
	
	
	
	// <load images>
	
	if (self.product.images.count == 0) {
		
		[self.indicatorLoading startAnimating];
		
		[ArasttaAPI product:^(Product *product) {
			
			self.product = product;
			
			[self loadImages];
			
		} failure:^(NSError *error) {
			
			[[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
			
			[self.indicatorLoading stopAnimating];
			
		} product_id:self.product.product_id parameters:nil];
		
	}
	else
	{
		
		[self loadImages];
		
	}
	
	// </load images>
	
}


- (void)loadImages {
	
	self.pageImages.numberOfPages = self.product.images.count;
	
	self.scrollImages.contentSize = CGSizeMake(self.scrollImages.frame.size.width * self.product.images.count, self.scrollImages.frame.size.height);
	
	
	i = 0;
	
	for (NSString *image in self.product.images) {
		
		[self.indicatorLoading startAnimating];
		
		[ImageCache loadImage:[NSString stringWithFormat:@"http://%@/%@",currentStore.store_url, image] complete:^(UIImage *image) {
			
			CGRect frm = CGRectMake(i * self.scrollImages.frame.size.width, 0, self.scrollImages.frame.size.width, self.scrollImages.frame.size.height);
			
			UIImageView *viewImg = [[UIImageView alloc] initWithFrame:frm];
			
			viewImg.image = image;
			
			[self.scrollImages addSubview:viewImg];
			
			i++;
			
			[self.indicatorLoading stopAnimating];
			
		}];
		
	}
	
}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	
	CGFloat pageWidth = self.scrollImages.frame.size.width;
	
	self.pageImages.currentPage = self.scrollImages.contentOffset.x / pageWidth;
	
}


- (IBAction)pageImagesChanged:(id)sender {
	
	int page = (int)self.pageImages.currentPage;
	
	[UIView animateWithDuration:0.3 animations:^{
		
		self.scrollImages.contentOffset = CGPointMake(page * self.scrollImages.frame.size.width, 0);
		
	}];
	
}


- (IBAction)btnBackClick:(id)sender {
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}


- (IBAction)btnGetArasttaCloudClick:(id)sender {
	
	[ArasttaAPI goToCloud];
	
}


@end
