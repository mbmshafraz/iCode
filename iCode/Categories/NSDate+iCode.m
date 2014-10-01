//
//  NSDate+iCode.m
//  AvAd
//
/*
 
 Copyright (c) 2012, Shafraz Buhary
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the Copyright holder  nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

#import "NSDate+iCode.h"
#import "iCode.h"

@implementation NSDate (iCode)

+ (NSString*)currentDateTimeInFormate:(NSString*)formate
{
    return [[[NSDate alloc] init] dateTimeInFormate:formate];
}

+ (NSDate*)dateFromeString:(NSString*)dateString inFormate:(NSString*)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    return [dateFormatter dateFromString: dateString];
}

- (NSString*)dateTimeInFormate:(NSString*)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    
//    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
//    [timeFormat setDateFormat:@"HH:mm:ss"];
    
    return [dateFormatter stringFromDate:self];
}

- (NSString*)dateTimeInFormate:(NSString*)formate withTimeZoneName:(NSString*)timeZoneName
{
    return [self dateTimeInFormate:formate withTimeZone:[NSTimeZone timeZoneWithName:timeZoneName]];
}

- (NSString*)dateTimeInFormate:(NSString*)formate withTimeZone:(NSTimeZone*)timeZone
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:formate];
    
    return [dateFormatter stringFromDate:self];
}

- (NSString*)utcDateTimeInFormate:(NSString*)formate
{
    return [self dateTimeInFormate:formate withTimeZoneName:@"UTC"];
}

//-(NSString *)getUTCFormateDate:(NSDate *)localDate
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//    [dateFormatter setTimeZone:timeZone];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *dateString = [dateFormatter stringFromDate:localDate];
//    return dateString;
//}


- (NSDate*)dateByAddingSeconds:(NSInteger)seconds
{
    return [self dateByAddingTimeInterval:seconds];
}

- (NSDate*)dateByAddingMinutes:(NSInteger)minutes
{
    return [self dateByAddingTimeInterval:minutes * 60];
}

- (NSDate*)dateByAddingHours:(NSInteger)hours
{
    return [self dateByAddingTimeInterval:3600 *hours];
}

- (NSDate*)dateByAddingDays:(NSInteger)days
{
    return [self dateByAddingTimeInterval:86400*days];
}

- (NSDate*)dateByAddingWeeks:(NSInteger)weeks
{
    return [self dateByAddingTimeInterval:604800*weeks];
}

//- (NSDictionary*)timeDiffSinceDate:(NSDate*)date
//{
////    NSInteger timeIntervel = [self timeIntervalSince1970] - [date timeIntervalSince1970];
//    //[self timeIntervalSinceDate:date];
//    NSInteger selfTimeInterval = [self timeIntervalSince1970];
//    NSInteger targatTimeInterval = [date timeIntervalSince1970];
//    
//    /* Removing seconds componants */
//    
////        selfTimeInterval = selfTimeInterval / 60;
////        targatTimeInterval = targatTimeInterval / 60;
//    
//    NSInteger timeIntervel = selfTimeInterval = targatTimeInterval;
//    NSInteger seconds = timeIntervel % 60;
//    NSInteger minutes = (timeIntervel / 60) % 60;
//    NSInteger hours = (timeIntervel / 3600) % 24;
//    NSInteger days = (timeIntervel / 86400);
//    return @{@"days": @(days),
//             @"hours":@(hours),
//             @"minutes":@(minutes),
//             @"seconds":@(seconds)};
//}

- (NSInteger)timeDiffInMinutesSince:(NSDate*)date ignoreSeconds:(BOOL)ignoreSeconds
{
    NSInteger selfTimeInterval = [self timeIntervalSince1970];
    NSInteger targatTimeInterval = [date timeIntervalSince1970];
    
    /* Removing seconds componants */
    if (ignoreSeconds) {
        selfTimeInterval = selfTimeInterval / 60;
        targatTimeInterval = targatTimeInterval / 60;
    }
    
    return selfTimeInterval - targatTimeInterval;
}

- (NSDate *) dateWithHour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components: NSYearCalendarUnit|
                                    NSMonthCalendarUnit|
                                    NSDayCalendarUnit
                                               fromDate:self];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    NSDate *newDate = [calendar dateFromComponents:components];
    return newDate;
}

+ (NSDate *)currentDateWithHour:(NSInteger)hour
                         minute:(NSInteger)minute
                         second:(NSInteger)second
{
    NSDate *currentDate = [NSDate date];
    return [currentDate dateWithHour:hour minute:minute second:second];
}

- (NSDate *)dateWithHourAndMinute:(NSString*)hourAndMinute
{
    NSArray *components = [hourAndMinute componentsSeparatedByString:@":"];
    if (components.count < 2) {
        return self;
    }
    
    return [self dateWithHour:[components[0] integerValue] minute:[components[1] integerValue] second:0];
}

+ (NSDate *)currentDateWithHourAndMinute:(NSString*)hourAndMinute
{
    NSDate *currentDate = [NSDate date];
    return [currentDate dateWithHourAndMinute:hourAndMinute];
}

- (NSDate *)dateWithOutTime
{
    NSDateComponents* components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}
@end
