//
//  Person.m
//  RunTimeTest
//
//  Created by xfg on 2018/3/20.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar *list = class_copyIvarList(self.class, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = list[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(list);
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder
{
    if ([self init]) {
        unsigned int count = 0;
        Ivar *list = class_copyIvarList(self.class, &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = list[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            if (value)
            {
                [self setValue:value forKey:key];
            }
        }
        free(list);
    }
    return self;
}

@end
