//
//  NSDate+DayNumber.m
//  BabySticker
//
//  Created by Ankit on 12/04/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "NSDate+DayNumber.h"

@implementation NSDate (DayNumber)

- (NSInteger)numberOfDaysUntil:(NSDate *)aDate {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:aDate options:0];
    
    return [components day];
}

@end
