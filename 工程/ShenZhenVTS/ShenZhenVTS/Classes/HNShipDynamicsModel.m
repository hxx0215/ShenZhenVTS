//
//  HNShipDynamicsModel.m
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-16.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import "HNShipDynamicsModel.h"

/*
 @property (nonatomic,strong) NSString* destplace;
 @property (nonatomic,strong) NSString* draught;
 @property (nonatomic,strong) NSString* dynamictime;
 @property (nonatomic,strong) NSString* etx;
 @property (nonatomic,strong) NSString* fromplace;
 @property (nonatomic,strong) NSString* shipdynamic;
 @property (nonatomic,strong) NSString* shiplength;
 @property (nonatomic,strong) NSString* shipname_cn;
 @property (nonatomic,strong) NSString* shiptype;
 @property (nonatomic,strong) NSString* shipwidth;
 @property (nonatomic,strong) NSString* vestid;
 */
@implementation HNShipDynamicsModel
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"destplace"] forKey:@"destplace"];
    [self setValue:[dic objectForKey:@"draught"] forKey:@"draught"];
    [self setValue:[dic objectForKey:@"dynamictime"] forKey:@"dynamictime"];
    [self setValue:[dic objectForKey:@"etx"] forKey:@"etx"];
    [self setValue:[dic objectForKey:@"fromplace"] forKey:@"fromplace"];
    [self setValue:[dic objectForKey:@"shipdynamic"] forKey:@"shipdynamic"];
    [self setValue:[dic objectForKey:@"shiplength"] forKey:@"shiplength"];
    [self setValue:[dic objectForKey:@"shipname_cn"] forKey:@"shipname_cn"];
    [self setValue:[dic objectForKey:@"shiptype"] forKey:@"shiptype"];
    [self setValue:[dic objectForKey:@"shipwidth"] forKey:@"shipwidth"];
    [self setValue:[dic objectForKey:@"vestid"] forKey:@"vestid"];
    return YES;
}
@end
