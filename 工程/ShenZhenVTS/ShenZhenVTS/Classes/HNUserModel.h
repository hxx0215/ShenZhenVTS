//
//  HNUserModel.h
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-18.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNShipDynamicsModel.h"

@interface HNUserModel : NSObject
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *repassword;
@property (nonatomic, strong) NSString *oldpassword;
@property (nonatomic, strong) NSString *phonenum;
@end

@interface HNUserDate  : NSObject
+(instancetype)shared;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *phonenum;
@property (nonatomic, strong) NSMutableArray *shipList;
@end
