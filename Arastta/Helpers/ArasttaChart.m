//
//  ArasttaChart.m
//  Arastta
//
//  Created by Ayhan Dorman on 28/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "ArasttaChart.h"
#import "UIColor+Expanded.h"

@interface ArasttaChart() {
	
	UIBezierPath *path;
	
	CAShapeLayer *shapeLayer;
	
	UIColor *lineColour;
	
	CGFloat baseWidth, baseHeight, multiplier, stepWidth, currentVal;
	
	int maxValue;
		
}

@end

@implementation ArasttaChart


-(id)initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];

	lineColour = [UIColor colorWithHexString:@"008db9"];
	
	baseWidth = frame.size.width - 14;
	
	baseHeight = frame.size.height - 14;

	return self;
	
}


-(UIView*)drawChart:(NSMutableArray*)vals {
	
	// <draw base lines>
	
	path = [UIBezierPath bezierPath];
	
	[path moveToPoint:CGPointMake(0, 0)];
	
	[path addLineToPoint:CGPointMake(0, baseHeight)];
	
	[path addLineToPoint:CGPointMake(baseWidth, baseHeight)];
	
	
	shapeLayer = [CAShapeLayer layer];
	
	shapeLayer.path = [path CGPath];
	
	shapeLayer.strokeColor = [[UIColor colorWithHexString:@"6d6e71"] CGColor];
	
	shapeLayer.lineWidth = 2.0;
	
	shapeLayer.fillColor = [[UIColor clearColor] CGColor];
	
	[self.layer addSublayer:shapeLayer];
	// </draw base lines>
	
	
	stepWidth = baseWidth / (vals.count - 1); // horizontal gap between each value
	
	maxValue = [[vals valueForKeyPath:@"@max.intValue"] intValue]; // max value in the array of sales
	
	multiplier =  (baseHeight - 20) / maxValue;
	
	
	
	// <draw chart>
	path = [UIBezierPath bezierPath];

	
	// <set starting point as the first value in array>
	currentVal = [((NSNumber*)[vals objectAtIndex:0]) floatValue];
	
	[path moveToPoint:CGPointMake(0, baseHeight - (currentVal * multiplier))];
	// </set starting point as the first value in array>

	
	for (int i = 0; i < vals.count; i++)
	{
		
		currentVal = [((NSNumber*)[vals objectAtIndex:i]) floatValue];
		
		[path addLineToPoint:CGPointMake(i * stepWidth, baseHeight - (currentVal * multiplier))];
		
	}
	
	shapeLayer = [CAShapeLayer layer];
	
	shapeLayer.path = [path CGPath];
	
	shapeLayer.strokeColor = [lineColour CGColor];
	
	shapeLayer.lineWidth = 2.0;
	
	shapeLayer.fillColor = [[UIColor clearColor] CGColor];
	
	
	[self.layer addSublayer:shapeLayer];
	// </draw chart>
	
	return self;
	
}


@end
