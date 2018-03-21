//
//  ViewController.m
//  RunTimeTest
//
//  Created by xfg on 2018/3/20.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)save:(id)sender
{
    Person *p = [[Person alloc] init];
    p.name = @"张三";
    p.age = 16;
    
    NSMutableData *mutableData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    [archiver encodeObject:p forKey:@"person"];
    [archiver finishEncoding];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"yezi.plist"];
    if ([mutableData writeToFile:filePath atomically:YES]) {
        NSLog(@"归档成功");
    }
}

- (IBAction)read:(id)sender
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"yezi.plist"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    Person *p = [unarchiver decodeObjectForKey:@"person"];
    [unarchiver finishDecoding];
    
    NSLog(@"name = %@, age = %d",p.name, p.age);
}

@end
