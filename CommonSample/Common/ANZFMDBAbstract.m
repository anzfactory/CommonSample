//
//  ANZFMDBAbstract.m
//  golfdiary
//
//  Created by shingo asato on 2013/11/18.
//  Copyright (c) 2013年 ANZ Factory. All rights reserved.
//

#import "ANZFMDBAbstract.h"

@implementation ANZFMDBAbstract

static id _instance = nil;

+ (id)sharedManager {
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
        // databaseのコピー
        _db = nil;
        [self initializeDataBase];
    }
    return self;
}

- (void)initializeDataBase
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([paths count] == 0) {
        NSLog(@"exeption!! : not search path...");
        return;
    }
    
    NSString* documentsDir = [paths objectAtIndex:0];
    NSString* dbPath = [documentsDir stringByAppendingPathComponent:DB_FILE_NAME];
    
    NSLog(@"db path :%@", dbPath);
    
    // file check
    if (![fileManager fileExistsAtPath:dbPath]) {
        NSString* templateDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_FILE_NAME];
        
        // copy database file
        [fileManager copyItemAtPath:templateDBPath toPath:dbPath error:&error];
        
        if (error) {
            NSLog(@"db copy error: \n%@", [error debugDescription]);
            return;
        }
    }
    
    _db = [FMDatabase databaseWithPath:dbPath];
    
}

@end
