//
//  HNMessageData.h
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-16.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import <Foundation/Foundation.h>
//{"code":"11","deloytime":1414944000000,"des":"备注信息","name":"123"}
@interface HNMessageData : NSObject
@property (nonatomic,strong) NSString* code;
@property (nonatomic,strong) NSString* deloytime;
@property (nonatomic,strong) NSString* des;
@property (nonatomic,strong) NSString* name;
-(BOOL)updateData:(NSDictionary *)dic;
@end
