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
-(BOOL)updateDataLogin:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"callsign"] forKey:@"callsign"];
    [self setValue:[dic objectForKey:@"lat"] forKey:@"lat"];
    [self setValue:[dic objectForKey:@"lon"] forKey:@"lon"];
    [self setValue:[dic objectForKey:@"mmsi"] forKey:@"mmsi"];
    [self setValue:[dic objectForKey:@"shipdynamic"] forKey:@"shipdynamic"];
    [self setValue:[dic objectForKey:@"shipname"] forKey:@"shipname"];
    return YES;
}

-(BOOL)updateDetailData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"callSign"] forKey:@"callsign"];
    [self setValue:[dic objectForKey:@"cog"] forKey:@"cog"];
    [self setValue:[dic objectForKey:@"country"] forKey:@"country"];
    [self setValue:[dic objectForKey:@"destplace"] forKey:@"destplace"];
    [self setValue:[dic objectForKey:@"draught"] forKey:@"draught"];
    [self setValue:[dic objectForKey:@"dynamicplace"] forKey:@"dynamicplace"];
    [self setValue:[dic objectForKey:@"dynamictime"] forKey:@"dynamictime"];
    [self setValue:[dic objectForKey:@"heading"] forKey:@"heading"];
    [self setValue:[dic objectForKey:@"imo"] forKey:@"imo"];
    [self setValue:[dic objectForKey:@"lat"] forKey:@"lat"];
    [self setValue:[dic objectForKey:@"lon"] forKey:@"lon"];
    [self setValue:[dic objectForKey:@"mmsi"] forKey:@"mmsi"];
    [self setValue:[dic objectForKey:@"shipLength"] forKey:@"shipLength"];
    [self setValue:[dic objectForKey:@"shipName"] forKey:@"shipname"];
    [self setValue:[dic objectForKey:@"shipWidth"] forKey:@"shipWidth"];
    [self setValue:[dic objectForKey:@"shipdynamic"] forKey:@"shipdynamic"];
    [self setValue:[dic objectForKey:@"sog"] forKey:@"sog"];
    [self setValue:[dic objectForKey:@"status"] forKey:@"status"];
    [self setValue:[dic objectForKey:@"type"] forKey:@"type"];
    return YES;
}
@end
