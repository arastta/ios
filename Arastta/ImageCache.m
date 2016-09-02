//
//  ImageCache.m
//  Arastta
//
//  Created by Ayhan Dorman on 28/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "ImageCache.h"

@implementation ImageCache

+ (void)loadImage:(NSString*)url complete:(void (^)(UIImage* image))complete
{
	
	
	//// TODO: ADD FULL LINK TO FILE NAME TO AVOID POSSIBLE DUPLICATIONS
	
	dispatch_async(dispatch_queue_create("get stored image", NULL), ^{
	
		NSString *imageUrl = url;
		
		NSRange range = [imageUrl rangeOfString:@"/" options:NSBackwardsSearch];
		
		NSString *imageFileName = [[imageUrl substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		imageUrl = [NSString stringWithFormat:@"%@%@", [imageUrl substringToIndex:NSMaxRange(range)], imageFileName];
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
		
		NSString *cachesDirectory = [paths objectAtIndex:0];
		
		NSString  *filePath = [NSString stringWithFormat:@"%@/%@", cachesDirectory, imageFileName];
		
		NSData *imageData;
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		if ([fileManager fileExistsAtPath:filePath]){
			
			imageData = [[NSData alloc] initWithContentsOfFile:filePath];
			
		}
		else
		{
			
			NSURL *url = [NSURL URLWithString:imageUrl];
			
			imageData = [NSData dataWithContentsOfURL:url];
			
			if (imageData)
			{
				
				[imageData writeToFile:filePath atomically:YES];
				
				NSLog(@"Downloading image \"%@\"..", imageFileName);
				
			}
			
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
		
			complete ([UIImage imageWithData:imageData]);
			
		});
		
	});
	
}

@end
