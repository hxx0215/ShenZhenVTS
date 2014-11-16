//
//  HNMessageData.m
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-16.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import "HNMessageData.h"

@implementation HNMessageData
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"code"] forKey:@"code"];
    [self setValue:[dic objectForKey:@"deloytime"] forKey:@"deloytime"];
    [self setValue:[dic objectForKey:@"des"] forKey:@"des"];
    [self setValue:[dic objectForKey:@"name"] forKey:@"name"];
    return YES;
}
@end
