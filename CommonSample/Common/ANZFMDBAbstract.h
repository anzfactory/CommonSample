//
//  ANZFMDBAbstract.h
//  golfdiary
//
//  Created by shingo asato on 2013/11/18.
//  Copyright (c) 2013年 ANZ Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FMDatabase.h>

@interface ANZFMDBAbstract : NSObject {
    @protected
    FMDatabase* _db;
}

+ (id)sharedManager;

@end
