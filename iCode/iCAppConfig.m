//
//  iCAppConfig.m
//  iCode
//
//  Created by Mohamed Shafraz on 12/03/2014.
//  Copyright (c) 2014 Shafraz. All rights reserved.
//

#import "iCAppConfig.h"

@interface iCAppConfig ()

@property (nonatomic, strong, readwrite) NSDictionary *config;

@end

@implementation iCAppConfig

- (id)init
{
	if (self = [super init]) {
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"AppConfig"
                                                              ofType:@"plist"];
		self.config = [[NSDictionary alloc]
                       initWithContentsOfFile:plistPath];
	}
	
	return self;
}

+ (iCAppConfig  *) sharedObject
{
    iCAppConfig *appConfig = (iCAppConfig*)[super sharedObject];
    return appConfig;
}

+ (NSDictionary *) config
{
    return [iCAppConfig sharedObject].config;
}

@end
