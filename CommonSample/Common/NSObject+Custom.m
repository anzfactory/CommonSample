//
//  NSObject+Custom.m
//  CommonSample
//
//  Created by ANZ on 2013/12/09.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "NSObject+Custom.h"

#import <objc/runtime.h>

@implementation NSObject (Custom)

- (NSDictionary *)properties
{
    NSMutableDictionary* prop = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary new]];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        prop[[NSString stringWithUTF8String:name]] = [self valueForKey:propertyName];
    }
    free(properties);
    
    return prop;
}
@end
