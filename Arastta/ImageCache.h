//
//  ImageCache.h
//  Arastta
//
//  Created by Ayhan Dorman on 28/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCache : NSObject

+ (void)loadImage:(NSString*)url complete:(void (^)(UIImage* image))complete;

@end
