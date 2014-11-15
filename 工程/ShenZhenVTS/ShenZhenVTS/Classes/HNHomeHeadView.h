//
//  HNHomeHeadView.h
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-15.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AHKit.h"

@interface HNHomeHeadView : UIView
@property (nonatomic, strong) UISegmentedControl* segmentView;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *settingButton;
@property (nonatomic, strong) UIButton *serchButton;
@end
