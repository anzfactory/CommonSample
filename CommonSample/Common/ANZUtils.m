//
//  ANZUtils.m
//  golfdiary
//
//  Created by ANZ on 2013/11/01.
//  Copyright (c) 2013年 ANZ Factory. All rights reserved.
//

#import "ANZUtils.h"

@implementation ANZUtils

+ (float)currentSysytemVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (BOOL)isLaterOS7
{
    float currentVersion = [ANZUtils currentSysytemVersion];
    return currentVersion >= 7.f;
}

+ (float)heightMainScreen
{
    return [[UIScreen mainScreen] bounds].size.height;
}

@end
