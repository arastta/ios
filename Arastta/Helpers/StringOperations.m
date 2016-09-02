//
//  StringOperations.m
//  Arastta
//
//  Created by Ayhan Dorman on 16/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "StringOperations.h"

@implementation StringOperations


+ (NSString*)encodeString:(NSString*)string
{
	
	return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

}


+ (NSString*)decodeString:(NSString*)string
{
	
	return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
}


@end
