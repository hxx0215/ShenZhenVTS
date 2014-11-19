//
//  HNShipDynamicsModel.h
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-16.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 船舶信息
 private int mmsi;     //MMSI
 private float lat ;     //纬度
 private float lon ;    //经度
 private float cog ;    //对地航向
 private short heading ;   //真航向    511不可用
 private float sog ;       //对地航速
 private String status ;      //航行状态  #
 private int imo ;            //IMO
 private String type ;        //船舶类型 #
 private String callSign ;    //船呼号
 private String shipName ;    //船舶名字
 private short shipLength ;//船长
 private float draught ;//吃水量
 private short shipWidth ;//船宽
 private String country ;//国籍
 private int    shipdynamic;//动态 (1：预抵 2：预离 3：正在抵港 4：正在离港 5：移泊 6：已靠泊 7：已锚泊 8：已离港
 private String dynamicplace;//动态位置
 private long   dynamictime; //动态时间
 private String startplace; //起始点
 private String destplace;  //目的地
 */
@interface HNShipDynamicsModel : NSObject
@property (nonatomic,strong) NSString* mmsi;
@property (nonatomic,strong) NSString* lat;
@property (nonatomic,strong) NSString* lon;
@property (nonatomic,strong) NSString* cog;
@property (nonatomic,strong) NSString* heading;
@property (nonatomic,strong) NSString* sog;
@property (nonatomic,strong) NSString* status;
@property (nonatomic,strong) NSString* imo;
@property (nonatomic,strong) NSString* type;
@property (nonatomic,strong) NSString* callsign;
@property (nonatomic,strong) NSString* shipname;
@property (nonatomic,strong) NSString* shipLength;
@property (nonatomic,strong) NSString* draught;
@property (nonatomic,strong) NSString* shipWidth;
@property (nonatomic,strong) NSString* country;
@property (nonatomic,strong) NSString* shipdynamic;
@property (nonatomic,strong) NSString* dynamicplace;
@property (nonatomic,strong) NSString* dynamictime;
@property (nonatomic,strong) NSString* startplace;
@property (nonatomic,strong) NSString* destplace;
-(BOOL)updateDataLogin:(NSDictionary *)dic;
-(BOOL)updateDetailData:(NSDictionary *)dic;
@end
