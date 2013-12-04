//
//  ANZUserInfo.m
//  golfdiary
//
//  Created by ANZ on 2013/11/01.
//  Copyright (c) 2013年 ANZ Factory. All rights reserved.
//

#import "ANZUserInfo.h"

@interface ANZUserInfo()

@end

@implementation ANZUserInfo

static ANZUserInfo* _instance = nil;

+ (ANZUserInfo *)sharedManager {
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [self new];
        }
    }
    return _instance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
            return _instance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone*)zone {
    return self;  // シングルトン状態を保持するため何もせず self を返す
}

- (id)init
{
    if (self = [super init]) {
        _ud = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

@end
