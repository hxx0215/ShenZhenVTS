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
//{"destplace":"大铲湾2","draught":0,"dynamictime":1415871734000,"etx":0,"fromplace":"大铲湾2","shipdynamic":1,"shiplength":1.3912974E7,"shipname_cn":"冷鑫","shiptype":"货船","shipwidth":7907816,"vestid":129}
@interface HNShipDynamicsModel : NSObject
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
-(BOOL)updateData:(NSDictionary *)dic;
@end
