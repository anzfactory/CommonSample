//
//  ANZUserInfo.h
//
//  Created by ANZ on 2013/11/01.
//  Copyright (c) 2013年 ANZ Factory. All rights reserved.
//

/*
 * shared化だけと本当に必要なものだけは実装しておくので、
 * 必要なプロパティとかメソッドはカテゴライズなり継承なりして
 * プロジェクト側で実装する
 */

#import <Foundation/Foundation.h>

@protocol ANZUserInfoProtocol <NSObject>

@required
- (void)saveAllProperty;
@end

@interface ANZUserInfo : NSObject

@property (nonatomic, readonly) NSUserDefaults* ud;

+ (id)sharedManager;

@end
