//
//  HNUserModel.m
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-18.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import "HNUserModel.h"

@implementation HNUserModel

@end

@implementation HNUserDate
-(id)init
{
    self = [super init];
    self.shipList = [[NSMutableArray alloc]init];
    return self;
}
+ (instancetype)shared {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}
@end