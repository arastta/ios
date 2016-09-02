//
//  DatePart.m
//  Arastta
//
//  Created by Ayhan Dorman on 03/08/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "DatePart.h"

@implementation DatePart


+(NSDateFormatter*)formatter
{
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	
	return dateFormatter;
	
}


+(NSString*)today
{
	
	NSDate *today = [self beginningOfDay:[NSDate date]];
	
	NSString *strToday = [self.formatter stringFromDate:today];
	
	return strToday;
	
}


+(NSString*)tomorrow
{
	
	NSDate *today = [self beginningOfDay:[NSDate date]];
	
	NSDate *tomorrow = [today dateByAddingTimeInterval: 86400.0];
	
	NSString *strTomorrow = [self.formatter stringFromDate:tomorrow];
	
	return strTomorrow;
	
}


+(NSString*)beginningOfMonth
{
	
	NSDate *today = [NSDate date];
	
	NSDate *beginningOfMonth = [self beginningOfMonth:today];
	
	NSString *strBeginningOfMonth = [self.formatter stringFromDate:beginningOfMonth];
	
	return strBeginningOfMonth;
	
}


+(NSString*)endOfMonth
{
	
	NSDate *today = [NSDate date];
	
	NSDate *endOfMonth = [self endOfMonth:today];
	
	NSString *strEndOfMonth = [self.formatter stringFromDate:endOfMonth];
	
	return strEndOfMonth;
	
}


+(NSString*)beginningOfYear
{
	
	NSDate *today = [NSDate date];
	
	NSDate *beginningOfYear = [self beginningOfYear:today];
	
	NSString *strBeginningOfYear = [self.formatter stringFromDate:beginningOfYear];
	
	return strBeginningOfYear;
	
}


+(NSString*)endOfYear
{
	
	NSDate *today = [NSDate date];
	
	NSDate *endOfYear = [self endOfYear:today];
	
	NSString *strEndOfYear = [self.formatter stringFromDate:endOfYear];
	
	return strEndOfYear;
	
}


+(NSDate *)beginningOfDay:(NSDate *)date
{
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
	
	return [calendar dateFromComponents:components];
	
}


+(NSDate *)beginningOfMonth:(NSDate *)date
{
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
	
	[components setDay:1];
	
	return [calendar dateFromComponents:components];
	
}


+(NSDate *)endOfMonth:(NSDate *)date
{
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
	
	[components setMonth:[components month]+1];
	[components setDay:1];
	
	return [calendar dateFromComponents:components];
	
}


+(NSDate *)beginningOfYear:(NSDate *)date
{
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
	
	[components setMonth:1];
	[components setDay:1];
	
	return [calendar dateFromComponents:components];
	
}


+(NSDate *)endOfYear:(NSDate *)date
{
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
	
	[components setYear:[components year]+1];
	[components setMonth:1];
	[components setDay:1];
	
	return [calendar dateFromComponents:components];
	
}


@end
