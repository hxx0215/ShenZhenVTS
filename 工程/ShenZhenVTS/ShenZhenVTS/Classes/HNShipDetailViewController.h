//
//  HNShipDetailViewController.h
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-16.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNShipDynamicsModel.h"

typedef enum _HNShipDynamicsType
{
    KHNSee,
    KHNUnSee
}HNShipDynamicsType;

@interface HNShipDetailViewController : UIViewController
@property (nonatomic,strong) HNShipDynamicsModel* shipModel;
@property (nonatomic) HNShipDynamicsType type;
@end
