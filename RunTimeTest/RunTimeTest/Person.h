//
//  Person.h
//  RunTimeTest
//
//  Created by xfg on 2018/3/20.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;

@end
