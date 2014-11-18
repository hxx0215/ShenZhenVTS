//
//  HNRegisterViewController.h
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-18.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNUserModel.h"

typedef enum _HNRegisterType
{
    KHNRegister = 0,
    KHNForgetPW,
    KHNModifPW
}HNRegisterType;

@interface HNRegisterViewController : UIViewController
@property (nonatomic, strong) HNUserModel* userModel;
@property (nonatomic) HNRegisterType type;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *oldPW;
@end
